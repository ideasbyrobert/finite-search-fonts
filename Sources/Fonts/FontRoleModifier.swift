import SwiftUI

public extension View
{
    func fontRole(_ role: FontRole) -> some View
    {
        modifier(FontRoleModifier(role: role))
    }
}

private struct FontRoleModifier: ViewModifier
{
    let role: FontRole
    @Environment(\.fontZoom) private var fontZoom

    func body(content: Content) -> some View
    {
        content.font(role.font(zoom: fontZoom))
    }
}
