import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
public final class FontZoomStore
{
    public static let shared = FontZoomStore()

    @ObservationIgnored private let defaults: UserDefaults

    public private(set) var zoomIndex: Int

    public var zoom: CGFloat
    {
        FontZoomSettings.zoom(for: zoomIndex)
    }

    public var canZoomIn: Bool
    {
        FontZoomSettings.canZoomIn(zoomIndex)
    }

    public var canZoomOut: Bool
    {
        FontZoomSettings.canZoomOut(zoomIndex)
    }

    public init(defaults: UserDefaults = .standard)
    {
        self.defaults = defaults
        zoomIndex = Self.savedZoomIndex(defaults: defaults)
    }

    public func zoomIn()
    {
        setZoomIndex(FontZoomSettings.zoomedInIndex(from: zoomIndex))
    }

    public func zoomOut()
    {
        setZoomIndex(FontZoomSettings.zoomedOutIndex(from: zoomIndex))
    }

    public func resetZoom()
    {
        setZoomIndex(FontZoomSettings.defaultIndex)
    }

    public func setZoomIndex(_ newZoomIndex: Int)
    {
        zoomIndex = FontZoomSettings.normalizedIndex(newZoomIndex)
        defaults.set(zoomIndex, forKey: FontZoomSettings.storageKey)
        defaults.synchronize()
    }

    private static func savedZoomIndex(defaults: UserDefaults) -> Int
    {
        if let savedIndex = defaults.object(forKey: FontZoomSettings.storageKey) as? Int
        {
            return FontZoomSettings.normalizedIndex(savedIndex)
        }

        if let savedIndexString = defaults.string(forKey: FontZoomSettings.storageKey),
           let savedIndex = Int(savedIndexString)
        {
            return FontZoomSettings.normalizedIndex(savedIndex)
        }

        return FontZoomSettings.defaultIndex
    }
}
