import SwiftUI

struct FontRoleStyle
{
    let textStyle: Font.TextStyle
    let standardPointSize: CGFloat
    let design: Font.Design
    let weight: Font.Weight?

    init(
        _ textStyle: Font.TextStyle,
        pointSize: CGFloat,
        design: Font.Design = .default,
        weight: Font.Weight? = nil
    )
    {
        self.textStyle = textStyle
        standardPointSize = pointSize
        self.design = design
        self.weight = weight
    }
}
