import Foundation
import SwiftUI
import Testing
@testable import Fonts

struct FontRoleTests
{
    @Test func rolesBuildSystemFonts() async throws
    {
        let roles: [FontRole] =
        [
            .screenTitle,
            .sectionTitle,
            .itemTitle,
            .controlLabel,
            .metadata,
            .status,
            .metric,
            .badge,
            .paragraph,
            .paragraphCaption,
            .symbol
        ]

        for role in roles
        {
            _ = role.font
        }
    }

    @Test func fontZoomSettingsClampOutOfRangeIndexes() async throws
    {
        #expect(FontZoomSettings.zoom(for: -1) == 0.80)
        #expect(FontZoomSettings.zoom(for: 100) == 1.72)
    }

    @Test func fontZoomSettingsIncreaseAndDecreaseWithinBounds() async throws
    {
        #expect(FontZoomSettings.zoomedOutIndex(from: -1) == 0)
        #expect(FontZoomSettings.zoomedOutIndex(from: 2) == 1)
        #expect(FontZoomSettings.zoomedInIndex(from: 2) == 3)
        #expect(FontZoomSettings.zoomedInIndex(from: 100) == FontZoomSettings.maximumIndex)
    }

    @Test func fontZoomSettingsZoomsPointSizes() async throws
    {
        #expect(abs(FontZoomSettings.zoomedSize(10, zoom: 1.48) - 14.8) < 0.001)
        #expect(FontZoomSettings.zoomedSize(4, zoom: 0.80) == 8)
    }

    @Test
    @MainActor
    func fontZoomStorePersistsNormalizedZoomIndex() async throws
    {
        let suiteName = "FontsTests.FontZoomStore.\(UUID().uuidString)"
        let defaults = try #require(UserDefaults(suiteName: suiteName))
        defer { defaults.removePersistentDomain(forName: suiteName) }

        let store = FontZoomStore(defaults: defaults)
        store.setZoomIndex(100)

        #expect(store.zoomIndex == FontZoomSettings.maximumIndex)
        #expect(defaults.integer(forKey: FontZoomSettings.storageKey) == FontZoomSettings.maximumIndex)

        store.resetZoom()

        #expect(store.zoomIndex == FontZoomSettings.defaultIndex)
        #expect(defaults.integer(forKey: FontZoomSettings.storageKey) == FontZoomSettings.defaultIndex)
    }
}
