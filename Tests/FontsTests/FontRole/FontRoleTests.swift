import Testing
@testable import Fonts

struct FontRoleTests
{
    @Test func allRolesResolveToSwiftUIFonts() async throws
    {
        for role in FontRole.allCases
        {
            _ = role.font
        }
    }

    @Test func everyRoleHasAnExplicitTypographyClassification() async throws
    {
        #expect(Set(FontRole.allCases) == FontRoleFixture.allClassifiedRoles)
    }

    @Test func paragraphRolesUseNewYorkForReading() async throws
    {
        for role in FontRoleFixture.readingRoles
        {
            #expect(role.fontStyle.typeface == .newYork)
            #expect(role.fontStyle.design == .serif)
        }
    }

    @Test func standardInterfaceRolesUseSanFrancisco() async throws
    {
        for role in FontRoleFixture.standardInterfaceRoles
        {
            #expect(role.fontStyle.typeface == .sanFrancisco)
            #expect(role.fontStyle.design == .default)
        }
    }

    @Test func roundedInterfaceRolesUseSanFranciscoRounded() async throws
    {
        for role in FontRoleFixture.roundedInterfaceRoles
        {
            #expect(role.fontStyle.typeface == .sanFranciscoRounded)
            #expect(role.fontStyle.design == .rounded)
        }
    }

    @Test func monospacedContentRolesUseSanFranciscoMono() async throws
    {
        for role in FontRoleFixture.monospacedContentRoles
        {
            #expect(role.fontStyle.typeface == .sanFranciscoMono)
            #expect(role.fontStyle.design == .monospaced)
        }
    }

    @Test func allNonReadingRolesStayInTheSanFranciscoFamily() async throws
    {
        let nonReadingRoles = Set(FontRole.allCases).subtracting(FontRoleFixture.readingRoles)

        for role in nonReadingRoles
        {
            #expect(role.fontStyle.typeface.isSanFranciscoFamily)
        }
    }

    @Test func urlRoleUsesCompactMonospacedFootnoteTypography() async throws
    {
        #expect(FontRole.url.fontStyle.textStyle == .footnote)
        #expect(FontRole.url.fontStyle.standardPointSize == 13)
        #expect(FontRole.url.fontStyle.typeface == .sanFranciscoMono)
    }

    @Test func codeRoleUsesReadableMonospacedBodyTypography() async throws
    {
        #expect(FontRole.code.fontStyle.textStyle == .body)
        #expect(FontRole.code.fontStyle.standardPointSize == 15)
        #expect(FontRole.code.fontStyle.typeface == .sanFranciscoMono)
    }
}
