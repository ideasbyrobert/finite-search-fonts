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
            return FontRoleStyle(.caption, pointSize: 12, typeface: .sanFranciscoRounded, weight: .bold)
        case .metric:
            return FontRoleStyle(.title2, pointSize: 22, typeface: .sanFranciscoRounded, weight: .semibold)
        case .badge:
            return FontRoleStyle(.caption2, pointSize: 11, typeface: .sanFranciscoRounded, weight: .medium)
        case .paragraph:
            return FontRoleStyle(.body, pointSize: 16, typeface: .newYork)
        case .paragraphCaption:
            return FontRoleStyle(.footnote, pointSize: 13, typeface: .newYork)
        case .url:
            return FontRoleStyle(.footnote, pointSize: 13, typeface: .sanFranciscoMono)
        case .code:
            return FontRoleStyle(.body, pointSize: 15, typeface: .sanFranciscoMono)
        case .symbol:
            return FontRoleStyle(.largeTitle, pointSize: 34, typeface: .sanFranciscoRounded, weight: .semibold)
        }
    }
}
