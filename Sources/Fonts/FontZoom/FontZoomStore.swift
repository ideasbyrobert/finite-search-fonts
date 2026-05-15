import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
public final class FontZoomStore
{
    public static let shared = FontZoomStore()

    @ObservationIgnored private let defaults: UserDefaults

    public private(set) var selectedLevelIndex: Int

    public var scale: CGFloat
    {
        FontZoomLevels.scale(for: selectedLevelIndex)
    }

    public var canZoomIn: Bool
    {
        FontZoomLevels.canMoveUp(from: selectedLevelIndex)
    }

    public var canZoomOut: Bool
    {
        FontZoomLevels.canMoveDown(from: selectedLevelIndex)
    }

    public var isAtDefaultLevel: Bool
    {
        selectedLevelIndex == FontZoomLevels.defaultLevelIndex
    }

    public init(defaults: UserDefaults = .standard)
    {
        self.defaults = defaults
        selectedLevelIndex = Self.savedLevelIndex(defaults: defaults)
    }

    public func zoomIn()
    {
        selectLevel(FontZoomLevels.nextLevel(after: selectedLevelIndex))
    }

    public func zoomOut()
    {
        selectLevel(FontZoomLevels.previousLevel(before: selectedLevelIndex))
    }

    public func resetZoom()
    {
        selectLevel(FontZoomLevels.defaultLevelIndex)
    }

    public func selectLevel(_ levelIndex: Int)
    {
        selectedLevelIndex = FontZoomLevels.clampedLevelIndex(levelIndex)
        defaults.set(selectedLevelIndex, forKey: FontZoomLevels.userDefaultsKey)
    }

    private static func savedLevelIndex(defaults: UserDefaults) -> Int
    {
        if let savedLevelIndex = defaults.object(forKey: FontZoomLevels.userDefaultsKey) as? Int
        {
            return FontZoomLevels.clampedLevelIndex(savedLevelIndex)
        }

        if let savedLevelIndexText = defaults.string(forKey: FontZoomLevels.userDefaultsKey),
           let savedLevelIndex = Int(savedLevelIndexText)
        {
            return FontZoomLevels.clampedLevelIndex(savedLevelIndex)
        }

        return FontZoomLevels.defaultLevelIndex
    }
}
