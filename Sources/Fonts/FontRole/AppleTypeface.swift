import SwiftUI

enum AppleTypeface: Equatable, Sendable
{
    case sanFrancisco
    case newYork
    case sanFranciscoRounded
    case sanFranciscoMono

    var design: Font.Design
    {
        switch self
        {
        case .sanFrancisco:
            return .default
        case .newYork:
            return .serif
        case .sanFranciscoRounded:
            return .rounded
        case .sanFranciscoMono:
            return .monospaced
        }
    }

    var isSanFranciscoFamily: Bool
    {
        switch self
        {
        case .sanFrancisco, .sanFranciscoRounded, .sanFranciscoMono:
            return true
        case .newYork:
            return false
        }
    }
}
