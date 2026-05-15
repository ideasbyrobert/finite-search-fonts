import Testing
@testable import Fonts

struct FontRoleTests
{
    @Test func allRolesResolveToSwiftUIFonts() async throws
    {
        for role in FontRoleFixture.allRoles
        {
            _ = role.font
        }
    }
}
