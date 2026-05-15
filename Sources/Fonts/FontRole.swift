import SwiftUI

public enum FontRole: Equatable, Sendable
{
    case screenTitle
    case sectionTitle
    case itemTitle
    case controlLabel
    case metadata
    case status
    case metric
    case badge
    case paragraph
    case paragraphCaption
    case symbol
}

public extension FontRole
{
    var font: Font
    {
        font(zoom: FontZoomSettings.defaultZoom)
    }

    func font(zoom: CGFloat) -> Font
    {
        if zoom == FontZoomSettings.defaultZoom
        {
            return systemFont
        }

        return .system(
            size: FontZoomSettings.zoomedSize(baseSize, zoom: zoom),
            weight: weight,
            design: design
        )
    }

    private var systemFont: Font
    {
        switch self
        {
        case .screenTitle:
            return .system(.largeTitle, design: .default, weight: .semibold)
        case .sectionTitle:
            return .system(.title3, design: .default, weight: .semibold)
        case .itemTitle:
            return .system(.headline, design: .default, weight: .semibold)
        case .controlLabel:
            return .system(.callout, design: .default, weight: .medium)
        case .metadata:
            return .system(.caption, design: .default)
        case .status:
            return .system(.caption, design: .rounded, weight: .bold)
        case .metric:
            return .system(.title2, design: .rounded, weight: .semibold)
        case .badge:
            return .system(.caption2, design: .rounded, weight: .medium)
        case .paragraph:
            return .system(.body, design: .serif)
        case .paragraphCaption:
            return .system(.footnote, design: .serif)
        case .symbol:
            return .system(.largeTitle, design: .rounded, weight: .semibold)
        }
    }

    private var baseSize: CGFloat
    {
        switch self
        {
        case .screenTitle:
            return 34
        case .sectionTitle:
            return 20
        case .itemTitle:
            return 17
        case .controlLabel:
            return 15
        case .metadata:
            return 12
        case .status:
            return 12
        case .metric:
            return 22
        case .badge:
            return 11
        case .paragraph:
            return 16
        case .paragraphCaption:
            return 13
        case .symbol:
            return 34
        }
    }

    private var design: Font.Design
    {
        switch self
        {
        case .status, .metric, .badge, .symbol:
            return .rounded
        case .paragraph, .paragraphCaption:
            return .serif
        default:
            return .default
        }
    }

    private var weight: Font.Weight?
    {
        switch self
        {
        case .screenTitle, .sectionTitle, .itemTitle, .metric, .symbol:
            return .semibold
        case .controlLabel, .badge:
            return .medium
        case .status:
            return .bold
        case .metadata, .paragraph, .paragraphCaption:
            return nil
        }
    }
}
