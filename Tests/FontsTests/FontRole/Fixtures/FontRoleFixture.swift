import Fonts

enum FontRoleFixture
{
    static let readingRoles: Set<FontRole> =
    [
        .paragraph,
        .paragraphCaption
    ]

    static let standardInterfaceRoles: Set<FontRole> =
    [
        .screenTitle,
        .sectionTitle,
        .itemTitle,
        .controlLabel,
        .metadata
    ]

    static let roundedInterfaceRoles: Set<FontRole> =
    [
        .status,
        .metric,
        .badge,
        .symbol
    ]

    static let monospacedContentRoles: Set<FontRole> =
    [
        .url,
        .code
    ]

    static var allClassifiedRoles: Set<FontRole>
    {
        readingRoles
            .union(standardInterfaceRoles)
            .union(roundedInterfaceRoles)
            .union(monospacedContentRoles)
    }
}
