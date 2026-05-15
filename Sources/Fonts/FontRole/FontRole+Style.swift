import SwiftUI

extension FontRole
{
    var fontStyle: FontRoleStyle
    {
        switch self
        {
        case .screenTitle:
            return FontRoleStyle(.largeTitle, pointSize: 34, weight: .semibold)
        case .sectionTitle:
            return FontRoleStyle(.title3, pointSize: 20, weight: .semibold)
        case .itemTitle:
            return FontRoleStyle(.headline, pointSize: 17, weight: .semibold)
        case .controlLabel:
            return FontRoleStyle(.callout, pointSize: 15, weight: .medium)
        case .metadata:
            return FontRoleStyle(.caption, pointSize: 12)
        case .status:
            return FontRoleStyle(.caption, pointSize: 12, design: .rounded, weight: .bold)
        case .metric:
            return FontRoleStyle(.title2, pointSize: 22, design: .rounded, weight: .semibold)
        case .badge:
            return FontRoleStyle(.caption2, pointSize: 11, design: .rounded, weight: .medium)
        case .paragraph:
            return FontRoleStyle(.body, pointSize: 16, design: .serif)
        case .paragraphCaption:
            return FontRoleStyle(.footnote, pointSize: 13, design: .serif)
        case .symbol:
            return FontRoleStyle(.largeTitle, pointSize: 34, design: .rounded, weight: .semibold)
        }
    }
}
