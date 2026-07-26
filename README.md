# HIG Gym

A hands-on reference app for the **Apple Human Interface Guidelines on iOS 26**.
Every file under `HIG Camp/` is one demo of one system component, showing its real
configurations side by side — toolbar placements, sheet detents, list styles, symbol
effects — with a one-line caption explaining the API on screen.

It is not a navigable app. There is no index screen and no menu: you read and run it
**through Xcode Previews**, one file at a time.

## Requirements

- Xcode 26
- iOS 26 simulator (deployment target 26.4)
- Swift 6, strict concurrency

## How to use it

1. Open `HIG Camp.xcodeproj`.
2. Open any numbered file, e.g. `HIG Camp/01 Toolbar/02 TitleDisplayModes.swift`.
3. Show the Canvas with **⌥⌘↩**, then pick one of the named previews at the bottom.
4. Tinker in place — the demos are built to be edited while the preview is live.

Most demos carry a **Dark Mode** toggle and a **Randomize Tint** button in the
toolbar, so you can check a component in both appearances and against an arbitrary
accent colour without leaving the preview.

To run one on the simulator instead, swap the view inside `WindowGroup` in
[`HIG Camp/HIG_GymApp.swift`](HIG%20Camp/HIG_GymApp.swift) and build the
`HIG Camp` scheme.

## What's inside

| Folder | Topic |
|---|---|
| `00 Shared` | The scaffold every demo reuses: `DemoPage`, `DemoSection`, `caption(_:)`, filler content views |
| `01 Toolbar` | Toolbar items and placements, title display modes, scroll edge effects, search |
| `02 Safe Area bar` | `safeAreaBar(edge:)` — top/bottom bars and leading/trailing rails |
| `03 Tab bar` | `Tab` API, badges, visibility, search tab, bottom accessory, page style, minimize behaviour |
| `04 Sheet` | Detents and drag indicators, `fullScreenCover`, zoom transitions |
| `05 System Materials` | Material backgrounds, `glassEffect`, hierarchical vibrancy |
| `06 Controls` *(WIP)* | Buttons, toggles, steppers, sliders, pickers, progress, control groups |
| `07 Lists & Collections` *(WIP)* | List styles, swipe actions, context menus, grids, edit/selection, disclosure groups |
| `08 Alerts & Feedback` *(WIP)* | Alerts, confirmation dialogs, popovers, empty and status states |
| `09 Menu` | `Menu` basics, primary action, embedded picker and control group, sections and submenus |
| `10 Text and Typography` *(WIP)* | Text behaviours, styles, fonts, Dynamic Type |
| `12 SF Symbols` | Symbol gallery, rendering modes, symbol effects (plus a custom `cowboy` symbol) |
| `XX Experiments` | Scratch space, not part of the curriculum |

## Where to look next

- [PROJECT.md](PROJECT.md) — file-by-file index of every demo and the exact APIs it covers.
- [CLAUDE.md](CLAUDE.md) — the canonical shape a demo file follows, if you add one.

## Notes

- The app is named *HIG Gym* (`HIG_GymApp`); the Xcode project, scheme, and source
  folder are still named *HIG Camp*.
- The target uses a synchronized file group, so a new file dropped into the source
  folder is picked up automatically — no `.pbxproj` edits.
