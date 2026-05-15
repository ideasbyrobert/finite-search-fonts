import Testing
@testable import Fonts

struct FontZoomLevelsTests
{
    @Test func clampsOutOfRangeLevelIndexes() async throws
    {
        #expect(FontZoomLevels.scale(for: -1) == 0.80)
        #expect(FontZoomLevels.scale(for: 100) == 1.72)
    }

    @Test func movesOneStepAtATimeWithinBounds() async throws
    {
        #expect(FontZoomLevels.previousLevel(before: -1) == 0)
        #expect(FontZoomLevels.previousLevel(before: 2) == 1)
        #expect(FontZoomLevels.nextLevel(after: 2) == 3)
        #expect(FontZoomLevels.nextLevel(after: 100) == FontZoomLevels.largestLevelIndex)
    }

    @Test func scalesPointSizesWithMinimumReadableSize() async throws
    {
        #expect(abs(FontZoomLevels.scaledPointSize(10, scale: 1.48) - 14.8) < 0.001)
        #expect(FontZoomLevels.scaledPointSize(4, scale: 0.80) == 8)
    }
}
