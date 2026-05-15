import SwiftUI

public enum FontZoomSettings
{
    public static let storageKey = "fontZoomIndex"
    public static let defaultIndex = 2
    public static let defaultZoom: CGFloat = 1

    private static let zoomFactors: [CGFloat] =
    [
        0.80, 0.90, 1.00, 1.12,
        1.28, 1.48, 1.72
    ]

    public static var maximumIndex: Int
    {
        zoomFactors.count - 1
    }

    public static func zoom(for index: Int) -> CGFloat
    {
        zoomFactors[normalizedIndex(index)]
    }

    public static func zoomedSize(_ baseSize: CGFloat, zoom: CGFloat) -> CGFloat
    {
        max(8, baseSize * zoom)
    }

    public static func canZoomIn(_ index: Int) -> Bool
    {
        normalizedIndex(index) < maximumIndex
    }

    public static func canZoomOut(_ index: Int) -> Bool
    {
        normalizedIndex(index) > 0
    }

    public static func zoomedInIndex(from index: Int) -> Int
    {
        min(normalizedIndex(index) + 1, maximumIndex)
    }

    public static func zoomedOutIndex(from index: Int) -> Int
    {
        max(normalizedIndex(index) - 1, 0)
    }

    public static func normalizedIndex(_ index: Int) -> Int
    {
        min(max(index, 0), maximumIndex)
    }
}

private struct FontZoomEnvironmentKey: EnvironmentKey
{
    static let defaultValue = FontZoomSettings.defaultZoom
}

public extension EnvironmentValues
{
    var fontZoom: CGFloat
    {
        get
        {
            self[FontZoomEnvironmentKey.self]
        }
        set
        {
            self[FontZoomEnvironmentKey.self] = newValue
        }
    }
}
