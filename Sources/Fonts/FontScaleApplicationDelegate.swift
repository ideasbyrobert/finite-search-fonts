import AppKit

public final class FontScaleApplicationDelegate: NSObject, NSApplicationDelegate
{
    public override init()
    {
        super.init()
    }

    public func applicationDidFinishLaunching(_ notification: Notification)
    {
        FontScaleMenuController.shared.installWhenReady()
    }

    public func applicationDidBecomeActive(_ notification: Notification)
    {
        FontScaleMenuController.shared.installWhenReady()
    }
}

@MainActor
final class FontScaleMenuController: NSObject, NSMenuItemValidation
{
    static let shared = FontScaleMenuController()

    private var isObserving = false
    private var installTask: Task<Void, Never>?

    private override init()
    {
        super.init()
    }

    func installWhenReady()
    {
        registerObserversIfNeeded()
        installTask?.cancel()
        installTask = Task { @MainActor in
            for delay in [0.0, 0.05, 0.15, 0.35, 0.75, 1.5]
            {
                if delay > 0
                {
                    try? await Task.sleep(for: .seconds(delay))
                }

                guard !Task.isCancelled else { return }
                _ = install()
            }
        }
    }

    @discardableResult
    func install() -> Bool
    {
        guard let viewMenu = NSApp.mainMenu?.item(withTitle: "View")?.submenu
        else
        {
            return false
        }

        if viewMenu.item(withTitle: "Increase Font Size") == nil
        {
            insertFontSizeItems(in: viewMenu)
        }

        configure(
            viewMenu.item(withTitle: "Increase Font Size"),
            action: #selector(increaseFontSize(_:)),
            keyEquivalent: "+"
        )
        configure(
            viewMenu.item(withTitle: "Decrease Font Size"),
            action: #selector(decreaseFontSize(_:)),
            keyEquivalent: "-"
        )
        configure(
            viewMenu.item(withTitle: "Reset Font Size"),
            action: #selector(resetFontSize(_:)),
            keyEquivalent: "0"
        )

        return true
    }

    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool
    {
        switch menuItem.action
        {
        case #selector(increaseFontSize(_:)):
            FontScaleStore.shared.canIncrease
        case #selector(decreaseFontSize(_:)):
            FontScaleStore.shared.canDecrease
        case #selector(resetFontSize(_:)):
            true
        default:
            true
        }
    }

    @objc private func increaseFontSize(_ sender: Any?)
    {
        FontScaleStore.shared.increase()
        NSApp.mainMenu?.update()
    }

    @objc private func decreaseFontSize(_ sender: Any?)
    {
        FontScaleStore.shared.decrease()
        NSApp.mainMenu?.update()
    }

    @objc private func resetFontSize(_ sender: Any?)
    {
        FontScaleStore.shared.reset()
        NSApp.mainMenu?.update()
    }

    private func insertFontSizeItems(in viewMenu: NSMenu)
    {
        let insertionIndex = viewMenu.indexOfItem(withTitle: "Enter Full Screen")
        let fontMenuIndex = insertionIndex == -1 ? viewMenu.numberOfItems : insertionIndex

        viewMenu.insertItem(.separator(), at: fontMenuIndex)
        viewMenu.insertItem(
            NSMenuItem(title: "Increase Font Size", action: nil, keyEquivalent: "+"),
            at: fontMenuIndex + 1
        )
        viewMenu.insertItem(
            NSMenuItem(title: "Decrease Font Size", action: nil, keyEquivalent: "-"),
            at: fontMenuIndex + 2
        )
        viewMenu.insertItem(
            NSMenuItem(title: "Reset Font Size", action: nil, keyEquivalent: "0"),
            at: fontMenuIndex + 3
        )
    }

    private func configure(
        _ item: NSMenuItem?,
        action: Selector,
        keyEquivalent: String
    )
    {
        guard let item else { return }

        item.target = self
        item.action = action
        item.keyEquivalent = keyEquivalent
        item.keyEquivalentModifierMask = [.command]
    }

    private func registerObserversIfNeeded()
    {
        guard !isObserving else { return }
        isObserving = true

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(installFromNotification(_:)),
            name: NSMenu.didBeginTrackingNotification,
            object: nil
        )
    }

    @objc private func installFromNotification(_ notification: Notification)
    {
        _ = install()
    }
}
