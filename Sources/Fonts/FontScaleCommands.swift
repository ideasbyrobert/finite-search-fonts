import SwiftUI

public struct FontScaleCommands: Commands
{
    private let store: FontScaleStore

    public init(store: FontScaleStore)
    {
        self.store = store
    }

    public var body: some Commands
    {
        CommandGroup(after: .toolbar)
        {
            Button("Increase Font Size")
            {
                store.increase()
            }
            .keyboardShortcut("+", modifiers: .command)
            .disabled(!store.canIncrease)

            Button("Decrease Font Size")
            {
                store.decrease()
            }
            .keyboardShortcut("-", modifiers: .command)
            .disabled(!store.canDecrease)

            Button("Reset Font Size")
            {
                store.reset()
            }
            .keyboardShortcut("0", modifiers: .command)
        }
    }
}
