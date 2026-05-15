import SwiftUI

public enum FontScaleSettings
{
    public static let storageKey = "fontScaleIndex"

    private static let scaleFactors: [CGFloat] =
    [
        0.80, 0.90, 0.96, 1.00,
        1.12, 1.28, 1.48
    ]

    public static let defaultIndex = 3
    public static var maximumIndex: Int { scaleFactors.count - 1 }

    public static func scale(for index: Int) -> CGFloat
    {
        scaleFactors[normalizedIndex(index)]
    }

    public static func scaledSize(_ baseSize: CGFloat, scale: CGFloat) -> CGFloat
    {
        max(8, baseSize * scale)
    }

    public static func font(
        _ textStyle: Font.TextStyle,
        weight: Font.Weight? = nil,
        design: Font.Design = .default,
        scale: CGFloat
    ) -> Font
    {
        .system(
            size: scaledSize(baseSize(for: textStyle), scale: scale),
            weight: weight,
            design: design
        )
    }

    public static func font(_ role: FontRole, scale: CGFloat) -> Font
    {
        switch role
        {
        case .screenTitle:
            return font(.largeTitle, weight: .semibold, scale: scale)
        case .sectionTitle:
            return font(.title3, weight: .semibold, scale: scale)
        case .itemTitle:
            return font(.headline, weight: .semibold, scale: scale)
        case .controlLabel:
            return font(.callout, weight: .medium, scale: scale)
        case .metadata:
            return font(.caption, scale: scale)
        case .status:
            return font(.caption, weight: .bold, design: .rounded, scale: scale)
        case .metric:
            return font(.title2, weight: .semibold, design: .rounded, scale: scale)
        case .badge:
            return font(.caption2, weight: .medium, design: .rounded, scale: scale)
        case .paragraph:
            return font(.body, design: .serif, scale: scale)
        case .paragraphCaption:
            return font(.footnote, design: .serif, scale: scale)
        case .symbol(let baseSize):
            return .system(
                size: scaledSize(baseSize, scale: scale),
                weight: .semibold,
                design: .rounded
            )
        }
    }

    public static func canIncrease(_ index: Int) -> Bool
    {
        normalizedIndex(index) < maximumIndex
    }

    public static func canDecrease(_ index: Int) -> Bool
    {
        normalizedIndex(index) > 0
    }

    public static func increasedIndex(from index: Int) -> Int
    {
        min(normalizedIndex(index) + 1, maximumIndex)
    }

    public static func decreasedIndex(from index: Int) -> Int
    {
        max(normalizedIndex(index) - 1, 0)
    }

    public static func normalizedIndex(_ index: Int) -> Int
    {
        min(max(index, 0), maximumIndex)
    }

    private static func baseSize(for textStyle: Font.TextStyle) -> CGFloat
    {
        switch textStyle
        {
        case .largeTitle:
            34
        case .title:
            28
        case .title2:
            22
        case .title3:
            20
        case .headline:
            17
        case .subheadline:
            15
        case .body:
            16
        case .callout:
            15
        case .caption:
            12
        case .caption2:
            11
        case .footnote:
            13
        @unknown default:
            16
        }
    }
}

private struct FontScaleEnvironmentKey: EnvironmentKey
{
    static let defaultValue: CGFloat = FontScaleSettings.scale(
        for: FontScaleSettings.defaultIndex
    )
}

public extension EnvironmentValues
{
    var fontScale: CGFloat
    {
        get { self[FontScaleEnvironmentKey.self] }
        set { self[FontScaleEnvironmentKey.self] = newValue }
    }
}
