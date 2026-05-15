import SwiftUI

public struct FontZoomCommands: Commands
{
    private let store: FontZoomStore

    public init(store: FontZoomStore)
    {
        self.store = store
    }

    public var body: some Commands
    {
        CommandGroup(after: .toolbar)
        {
            Button("Zoom In")
            {
                store.zoomIn()
            }
            .keyboardShortcut("+", modifiers: .command)
            .disabled(!store.canZoomIn)

            Button("Zoom Out")
            {
                store.zoomOut()
            }
            .keyboardShortcut("-", modifiers: .command)
            .disabled(!store.canZoomOut)

            Button("Actual Size")
            {
                store.resetZoom()
            }
            .keyboardShortcut("0", modifiers: .command)
            .disabled(store.zoomIndex == FontZoomSettings.defaultIndex)
        }
    }
}
