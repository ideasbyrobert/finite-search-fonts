import SwiftUI

public extension View
{
    func scaledFont(_ role: FontRole) -> some View
    {
        modifier(ScaledFontModifier(role: role))
    }
}

private struct ScaledFontModifier: ViewModifier
{
    let role: FontRole
    @Environment(\.fontScale) private var fontScale

    func body(content: Content) -> some View
    {
        content.font(FontScaleSettings.font(role, scale: fontScale))
    }
}
