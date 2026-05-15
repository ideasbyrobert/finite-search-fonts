import SwiftUI

public enum FontZoomLevels
{
    public static let userDefaultsKey = "fontZoomIndex"
    public static let defaultLevelIndex = 2
    public static let defaultScale: CGFloat = 1

    private static let minimumPointSize: CGFloat = 8

    private static let scaleByLevel: [CGFloat] =
    [
        0.80, 0.90, 1.00, 1.12,
        1.28, 1.48, 1.72
    ]

    public static var largestLevelIndex: Int
    {
        scaleByLevel.count - 1
    }

    public static func scale(for levelIndex: Int) -> CGFloat
    {
        scaleByLevel[clampedLevelIndex(levelIndex)]
    }

    public static func scaledPointSize(_ basePointSize: CGFloat, scale: CGFloat) -> CGFloat
    {
        max(minimumPointSize, basePointSize * scale)
    }

    public static func canMoveUp(from levelIndex: Int) -> Bool
    {
        clampedLevelIndex(levelIndex) < largestLevelIndex
    }

    public static func canMoveDown(from levelIndex: Int) -> Bool
    {
        clampedLevelIndex(levelIndex) > 0
    }

    public static func nextLevel(after levelIndex: Int) -> Int
    {
        min(clampedLevelIndex(levelIndex) + 1, largestLevelIndex)
    }

    public static func previousLevel(before levelIndex: Int) -> Int
    {
        max(clampedLevelIndex(levelIndex) - 1, 0)
    }

    public static func clampedLevelIndex(_ levelIndex: Int) -> Int
    {
        min(max(levelIndex, 0), largestLevelIndex)
    }
}
