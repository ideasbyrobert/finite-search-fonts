import SwiftUI

struct FontRoleStyle
{
    let textStyle: Font.TextStyle
    let standardPointSize: CGFloat
    let typeface: AppleTypeface
    let weight: Font.Weight?

    var design: Font.Design
    {
        typeface.design
    }

    init(
        _ textStyle: Font.TextStyle,
        pointSize: CGFloat,
        typeface: AppleTypeface = .sanFrancisco,
        weight: Font.Weight? = nil
    )
    {
        self.textStyle = textStyle
        standardPointSize = pointSize
        self.typeface = typeface
        self.weight = weight
    }
}
