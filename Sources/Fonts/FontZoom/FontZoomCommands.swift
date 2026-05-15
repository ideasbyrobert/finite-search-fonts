import SwiftUI

public struct FontZoomCommands: Commands
{
    private let fontZoom: FontZoomStore

    public init(store: FontZoomStore)
    {
        fontZoom = store
    }

    public var body: some Commands
    {
        CommandGroup(after: .toolbar)
        {
            Button("Zoom In")
            {
                fontZoom.zoomIn()
            }
            .keyboardShortcut("+", modifiers: .command)
            .disabled(!fontZoom.canZoomIn)

            Button("Zoom Out")
            {
                fontZoom.zoomOut()
            }
            .keyboardShortcut("-", modifiers: .command)
            .disabled(!fontZoom.canZoomOut)

            Button("Actual Size")
            {
                fontZoom.resetZoom()
            }
            .keyboardShortcut("0", modifiers: .command)
            .disabled(fontZoom.isAtDefaultLevel)
        }
    }
}
