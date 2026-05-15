import Testing
@testable import Fonts

struct FontZoomStoreTests
{
    @Test
    @MainActor
    func persistsClampedSelectedLevel() async throws
    {
        let fixture = try FontZoomStoreFixture()
        defer { fixture.cleanUp() }

        let store = fixture.makeStore()
        store.selectLevel(100)

        #expect(store.selectedLevelIndex == FontZoomLevels.largestLevelIndex)
        #expect(fixture.defaults.integer(forKey: FontZoomLevels.userDefaultsKey) == FontZoomLevels.largestLevelIndex)

        store.resetZoom()

        #expect(store.selectedLevelIndex == FontZoomLevels.defaultLevelIndex)
        #expect(fixture.defaults.integer(forKey: FontZoomLevels.userDefaultsKey) == FontZoomLevels.defaultLevelIndex)
    }

    @Test
    @MainActor
    func readsSavedLevelFromStringDefaultsValue() async throws
    {
        let fixture = try FontZoomStoreFixture()
        defer { fixture.cleanUp() }

        fixture.saveLevelText("4")

        let store = fixture.makeStore()

        #expect(store.selectedLevelIndex == 4)
        #expect(store.scale == FontZoomLevels.scale(for: 4))
    }
}
