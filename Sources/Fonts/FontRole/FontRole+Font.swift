import SwiftUI

public extension FontRole
{
    var font: Font
    {
        font(scale: FontZoomLevels.defaultScale)
    }

    func font(scale: CGFloat) -> Font
    {
        let style = fontStyle

        return .system(
            size: FontZoomLevels.scaledPointSize(style.standardPointSize, scale: scale),
            weight: style.weight,
            design: style.design
        )
    }

}
