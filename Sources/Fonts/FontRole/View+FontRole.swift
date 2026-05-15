import SwiftUI

public extension View
{
    func fontRole(_ role: FontRole) -> some View
    {
        modifier(FontRoleModifier(role: role))
    }
}
