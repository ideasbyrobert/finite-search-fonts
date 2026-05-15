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

        if scale == FontZoomLevels.defaultScale
        {
            return .system(style.textStyle, design: style.design, weight: style.weight)
        }

        return .system(
            size: FontZoomLevels.scaledPointSize(style.standardPointSize, scale: scale),
            weight: style.weight,
            design: style.design
        )
    }

}
