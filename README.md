# Fonts

Typographic roles and a user controlled zoom for SwiftUI on macOS.

## Roles

`FontRole` names sixteen jobs a piece of text can do, from `screenTitle` and
`sectionTitle` down to `metadata`, `status`, `metric`, `url`, `code`, and the
icon roles. A view states the role and never a point size:

```swift
import Fonts

Text(heading).fontRole(.sectionTitle)
```

`View.fontRole(_:)` applies a `ViewModifier` that reads the current scale from
the environment and resolves the role against one of four Apple typefaces, San
Francisco, New York, SF Rounded and SF Mono, by way of `Font.Design`. The
typeface mapping stays internal, so a caller cannot reach past the role and pin
a face.

## Zoom

`FontZoomLevels` defines seven scale steps from 0.80 to 1.72 with a floor of
eight points, so no role can shrink to unreadable. The active scale travels
through the SwiftUI environment by way of `FontScaleEnvironmentKey` and
`EnvironmentValues.fontScale`, which means a role deep in a view tree scales
without a single explicit hand off. `FontZoomStore` persists the level, and
`FontZoomCommands` contributes the menu items and key equivalents.

```swift
WindowGroup { ContentView() }
    .commands { FontZoomCommands(store: zoomStore) }
```

Swift 6, macOS 14 or later. No dependencies. Eighteen tests across four suites.

Extracted from a search interface project, where it sits alongside
[Colors](https://github.com/ideasbyrobert/finite-search-colors) and
[Spacing](https://github.com/ideasbyrobert/finite-search-spacing).
