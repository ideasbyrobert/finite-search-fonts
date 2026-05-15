import SwiftUI

public extension EnvironmentValues
{
    var fontScale: CGFloat
    {
        get
        {
            self[FontScaleEnvironmentKey.self]
        }
        set
        {
            self[FontScaleEnvironmentKey.self] = newValue
        }
    }

}
