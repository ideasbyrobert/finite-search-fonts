import Foundation
import SwiftUI
import Testing
@testable import Fonts

struct FontScaleTests
{
    @Test func fontScaleSettingsClampOutOfRangeIndexes() async throws
    {
        #expect(FontScaleSettings.scale(for: -1) == 0.80)
        #expect(FontScaleSettings.scale(for: 100) == 1.48)
    }

    @Test func fontScaleSettingsIncreaseAndDecreaseWithinBounds() async throws
    {
        #expect(FontScaleSettings.decreasedIndex(from: -1) == 0)
        #expect(FontScaleSettings.decreasedIndex(from: 3) == 2)

        #expect(FontScaleSettings.increasedIndex(from: 3) == 4)
        #expect(FontScaleSettings.increasedIndex(from: 100) == FontScaleSettings.maximumIndex)
    }

    @Test func fontScaleSettingsScalesPointSizes() async throws
    {
        #expect(abs(FontScaleSettings.scaledSize(10, scale: 1.48) - 14.8) < 0.001)
        #expect(FontScaleSettings.scaledSize(4, scale: 0.80) == 8)
    }

    @Test
    @MainActor
    func fontScaleStorePersistsNormalizedSizeIndex() async throws
    {
        let suiteName = "FontsTests.FontScaleStore.\(UUID().uuidString)"
        let defaults = try #require(UserDefaults(suiteName: suiteName))
        defer { defaults.removePersistentDomain(forName: suiteName) }

        let store = FontScaleStore(defaults: defaults)
        store.setSizeIndex(100)

        #expect(store.sizeIndex == FontScaleSettings.maximumIndex)
        #expect(defaults.integer(forKey: FontScaleSettings.storageKey) == FontScaleSettings.maximumIndex)

        store.reset()

        #expect(store.sizeIndex == FontScaleSettings.defaultIndex)
        #expect(defaults.integer(forKey: FontScaleSettings.storageKey) == FontScaleSettings.defaultIndex)
    }
}
