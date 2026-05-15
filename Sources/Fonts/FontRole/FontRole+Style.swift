import SwiftUI

extension FontRole
{
    var fontStyle: FontRoleStyle
    {
        switch self
        {
        case .screenTitle:
            return FontRoleStyle(.largeTitle, pointSize: 28, weight: .semibold)
        case .sectionTitle:
            return FontRoleStyle(.headline, pointSize: 13, weight: .semibold)
        case .itemTitle:
            return FontRoleStyle(.headline, pointSize: 13, weight: .semibold)
        case .controlLabel:
            return FontRoleStyle(.callout, pointSize: 13, weight: .medium)
        case .metadata:
            return FontRoleStyle(.caption, pointSize: 11)
        case .status:
            return FontRoleStyle(.caption, pointSize: 11, typeface: .sanFranciscoRounded, weight: .bold)
        case .metric:
            return FontRoleStyle(.title2, pointSize: 17, typeface: .sanFranciscoRounded, weight: .semibold)
        case .badge:
            return FontRoleStyle(.caption2, pointSize: 11, typeface: .sanFranciscoRounded, weight: .medium)
        case .paragraph:
            return FontRoleStyle(.body, pointSize: 14, typeface: .newYork)
        case .paragraphCaption:
            return FontRoleStyle(.footnote, pointSize: 11, typeface: .newYork)
        case .url:
            return FontRoleStyle(.footnote, pointSize: 11)
        case .code:
            return FontRoleStyle(.body, pointSize: 13, typeface: .sanFranciscoMono)
        case .symbol:
            return FontRoleStyle(.largeTitle, pointSize: 28, typeface: .sanFranciscoRounded, weight: .semibold)
        }
    }
}
