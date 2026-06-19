# HIG Gym — Project Overview

## Purpose

A personal iOS 26 teaching/reference app for exploring Apple Human Interface Guidelines in practice. Each view demonstrates a specific configuration or capability of a system component. The app is used **primarily through Xcode Previews** — there is no central navigation UI.

## Conventions

- Topics are grouped into numbered feature folders under `HIG Camp/` (`01 Toolbar`, `02 Safe Area bar`, …); shared building blocks live in `00 Shared`.
- Files within a topic folder are numbered (`01 Toolbar Items.swift`, `02 TitleDisplayModes.swift`) and hold one component each.
- Shared components are prefixed `Demo` (`DemoScrollView`, `DemoRowView`, …) and are parameterized so call sites stay terse.
- Variants of a concept are modelled as an `UpperCamelCase` enum (`<Topic>Variant`) driving one parameterized view with multiple `#Preview` macros.
- `ScrollView + ForEach` is preferred over `List` to allow background customization.
- `navigationDestination(for:)` is registered at the call site (not inside shared views) so each screen owns its navigation.
- No UITests, no central router, no shared coordinator.

## Current Topics

### 00 Shared — reusable building blocks
`DemoScrollView` (tinted scrolling list, optional scroll-reset token), `DemoRowView`, `DemoDetailView`, `DemoSearchView`, `DemoPickerView`, `DemoMenuView`, `DemoModalView`.

### 01 Toolbar
| File | What it demos |
|---|---|
| `01 Toolbar Items.swift` | Toolbar item placements, groups, overflow, bottom bar, mixed controls |
| `02 TitleDisplayModes.swift` | Title display modes (`.large`/`.inlineLarge`/`.inline`/`.automatic`) + title menu |
| `03 ScrollEdgeEffects.swift` | `scrollEdgeEffectStyle(_:for:)` — `.soft`/`.hard`/`.automatic` |
| `04 Search.swift` | `.searchable()` placements incl. `.navigationBarDrawer`, `.toolbarPrincipal` |

### 02 Safe Area bar
| File | What it demos |
|---|---|
| `01 SafeAreaBarVerticalDemoView.swift` | `safeAreaBar(edge:)` top/bottom, material, alongside a toolbar |
| `02 SafeAreaBarHorizontalDemoView.swift` | `safeAreaBar(edge:)` leading/trailing tool rails |

### 03 Tab bar
| File | What it demos |
|---|---|
| `01 Tab Items.swift` | `Tab` API: text+icon, badges, icon-only |
| `02 Tab Counts.swift` | 2/4/6 tabs, minimize-on-scroll |
| `03 Visibility.swift` | Tab bar visibility / hide-on-detail |
| `04 TabBarSearch.swift` | `Tab(role: .search)`, sidebar-adaptable |
| `05 BottomAccessory.swift` | `tabViewBottomAccessory` adapting to placement |
| `06 PageStyle.swift` | `.page` / `.sidebarAdaptable` tab view styles |
| `07 Minimize Behavior.swift` | `tabBarMinimizeBehavior` |

### 04 Sheet
| File | What it demos |
|---|---|
| `01 Sheet Configurations.swift` | Detents, drag indicator, non-modal background interaction |
| `02 FullScreenCover.swift` | `fullScreenCover` |
| `03 Transitions.swift` | Zoom transition via `matchedTransitionSource` + `navigationTransition(.zoom)` |

### Root
`SampleInterface.swift` — interactive sandbox: a Form sheet that live-drives the demo list's tint, navigation title and toolbar title display mode (scrolls to top on mode change). `ColorTest.swift` — scratch view. `HIG_GymApp.swift` — app entry (swap the root view to preview on simulator).

## Target

- **Platform:** iOS 26 (builds/runs on the iOS 26.5 simulator)
- **Xcode:** 26
- **Swift:** 6 (strict concurrency, `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`)
- **File discovery:** `PBXFileSystemSynchronizedRootGroup` — new files in the source folder are auto-included, no `.pbxproj` edits needed
- **Note:** the app is named *HIG Gym* (struct `HIG_GymApp`); the Xcode project/scheme and source folder are still named `HIG Camp`.
