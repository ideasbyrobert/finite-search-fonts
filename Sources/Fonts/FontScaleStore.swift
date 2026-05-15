import CoreGraphics
import Foundation
import Observation

@MainActor
@Observable
public final class FontScaleStore
{
    public static let shared = FontScaleStore()

    @ObservationIgnored private let defaults: UserDefaults

    public private(set) var sizeIndex: Int

    public var scale: CGFloat
    {
        FontScaleSettings.scale(for: sizeIndex)
    }

    public var canIncrease: Bool
    {
        FontScaleSettings.canIncrease(sizeIndex)
    }

    public var canDecrease: Bool
    {
        FontScaleSettings.canDecrease(sizeIndex)
    }

    public init(defaults: UserDefaults = .standard)
    {
        self.defaults = defaults
        sizeIndex = Self.savedSizeIndex(defaults: defaults)
    }

    public func increase()
    {
        setSizeIndex(FontScaleSettings.increasedIndex(from: sizeIndex))
    }

    public func decrease()
    {
        setSizeIndex(FontScaleSettings.decreasedIndex(from: sizeIndex))
    }

    public func reset()
    {
        setSizeIndex(FontScaleSettings.defaultIndex)
    }

    public func setSizeIndex(_ newSizeIndex: Int)
    {
        sizeIndex = FontScaleSettings.normalizedIndex(newSizeIndex)
        defaults.set(sizeIndex, forKey: FontScaleSettings.storageKey)
        defaults.synchronize()
    }

    private static func savedSizeIndex(defaults: UserDefaults) -> Int
    {
        if let savedIndex = defaults.object(forKey: FontScaleSettings.storageKey) as? Int
        {
            return FontScaleSettings.normalizedIndex(savedIndex)
        }

        if let savedIndexString = defaults.string(forKey: FontScaleSettings.storageKey),
           let savedIndex = Int(savedIndexString)
        {
            return FontScaleSettings.normalizedIndex(savedIndex)
        }

        return FontScaleSettings.defaultIndex
    }
}
