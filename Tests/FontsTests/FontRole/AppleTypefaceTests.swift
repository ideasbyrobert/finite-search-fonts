import SwiftUI
import Testing
@testable import Fonts

struct AppleTypefaceTests
{
    @Test func mapsAppleTypefacesToSwiftUISystemFontDesigns() async throws
    {
        #expect(AppleTypeface.sanFrancisco.design == .default)
        #expect(AppleTypeface.newYork.design == .serif)
        #expect(AppleTypeface.sanFranciscoRounded.design == .rounded)
        #expect(AppleTypeface.sanFranciscoMono.design == .monospaced)
    }

    @Test func identifiesEverySanFranciscoVariantAsPartOfTheSanFranciscoFamily() async throws
    {
        #expect(AppleTypeface.sanFrancisco.isSanFranciscoFamily)
        #expect(AppleTypeface.sanFranciscoRounded.isSanFranciscoFamily)
        #expect(AppleTypeface.sanFranciscoMono.isSanFranciscoFamily)
        #expect(!AppleTypeface.newYork.isSanFranciscoFamily)
    }
}
