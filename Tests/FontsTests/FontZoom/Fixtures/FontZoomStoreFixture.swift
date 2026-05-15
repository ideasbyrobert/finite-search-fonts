import Foundation
import Fonts

struct FontZoomStoreFixture
{
    let suiteName: String
    let defaults: UserDefaults

    init() throws
    {
        let suiteName = "FontsTests.FontZoomStore.\(UUID().uuidString)"

        guard let defaults = UserDefaults(suiteName: suiteName)
        else
        {
            throw FontZoomStoreFixtureError.couldNotCreateUserDefaultsSuite(suiteName)
        }

        self.suiteName = suiteName
        self.defaults = defaults
    }

    func cleanUp()
    {
        defaults.removePersistentDomain(forName: suiteName)
    }

    func saveLevelText(_ levelText: String)
    {
        defaults.set(levelText, forKey: FontZoomLevels.userDefaultsKey)
    }

    @MainActor
    func makeStore() -> FontZoomStore
    {
        FontZoomStore(defaults: defaults)
    }
}
