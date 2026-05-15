import SwiftUI

struct FontRoleModifier: ViewModifier
{
    let role: FontRole
    @Environment(\.fontScale) private var fontScale

    func body(content: Content) -> some View
    {
        content.font(role.font(scale: fontScale))
    }
}
