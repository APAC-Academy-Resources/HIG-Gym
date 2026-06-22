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

### 05 System Materials
| File | What it demos |
|---|---|
| `01 Materials.swift` | Material backgrounds (`.ultraThick`/`.thick`/`.regular`/`.thin`/`.ultraThinMaterial`) + `.glassEffect(.regular/.clear)` over photo / gradient / solid backgrounds, randomizable tint |
| `02 Vibrancy.swift` | Hierarchical `foregroundStyle` (`.primary`/`.secondary`/`.tertiary`/`.quaternary`/`.quinary`) vibrancy across material types |

### 06 Controls
| File | What it demos |
|---|---|
| `01 Buttons.swift` | `.buttonStyle` `.borderedProminent`/`.bordered`/`.plain`/`.glass`; `.controlSize` `.mini`→`.large`; `role: .destructive`; toggleable `.disabled()`; live tint |
| `02 Toggles & Steppers.swift` | `.toggleStyle` `.switch`/`.button`/`.automatic`; `Stepper` value + range + `step:` |
| `03 Sliders.swift` | basic `Slider`, range, `step:`, min/max value labels, `onEditingChanged` readout |
| `04 Pickers.swift` | `.pickerStyle` `.segmented`/`.menu`/`.wheel`/`.inline` (reuses `DemoPickerView`) + `DatePicker` `.compact`/`.graphical` |
| `05 Progress.swift` | `ProgressView` linear/circular determinate + indeterminate, slider-driven value, tinted |

### 07 Lists & Collections
| File | What it demos |
|---|---|
| `01 List Styles.swift` | `.listStyle` `.plain`/`.grouped`/`.insetGrouped`/`.inset`/`.sidebar` (bottom-bar switcher) + `Section` headers/footers |
| `02 Swipe Actions.swift` | `.swipeActions(edge:)` leading/trailing, `allowsFullSwipe`, per-button `.tint`, destructive delete |
| `03 Context Menus.swift` | `.contextMenu` w/ `preview:`, showcases `00 Shared/DemoMenuView` |
| `04 Grids.swift` | `LazyVGrid` adaptive / fixed / flexible `GridItem` columns |
| `05 Edit & Selection.swift` | `EditButton`, `List(selection:)` multi-select, `.onMove`/`.onDelete` |
| `06 Disclosure Groups.swift` | `DisclosureGroup` self-managed, bound `isExpanded`, nested |

### 08 Alerts & Feedback
| File | What it demos |
|---|---|
| `01 Alerts.swift` | `.alert()` simple, button roles, embedded `TextField` |
| `02 ConfirmationDialog.swift` | `.confirmationDialog` actions, destructive, `titleVisibility` |
| `03 Popovers.swift` | `.popover()` sheet-adaptive default + `.presentationCompactAdaptation(.popover)` |
| `04 Empty & Status States.swift` | `ContentUnavailableView` (+ `.search`), status enum (loading/empty/error) |

## Roadmap — planned topics

Source: a 3-persona audit (beginner iOS student, Sketch-based product designer, Apple Developer Academy mentor) of the 5 existing sections. All three converged: the app covers UI *chrome* (toolbars, tab bars, sheets, materials) well but lacks the **system controls, content containers, and feedback patterns** needed next. Scope is deliberately **component-focused** — each planned file showcases one iOS 26 *system component* in the existing Preview format. Out of scope: Swift-language tutorials, app architecture/routing, widgets, notifications, scene management, and iPad/Mac-leaning multi-column patterns (`NavigationSplitView`). Dark mode stays a cross-cutting habit (as in `05 System Materials`); accessibility gets one dedicated section, not duplication across files.

Build in tier order; preview each tier before continuing. New files auto-include via `PBXFileSystemSynchronizedRootGroup`. When a section ships, move its row up into **Current Topics** above.

### Tier 2 — Visual foundations

| Section | Files |
|---|---|
| `09 Typography` | `01 Text Styles` (`.largeTitle`→`.caption2`) · `02 Fonts` (weights, `.serif`/`.monospaced`/`.rounded`) · `03 Dynamic Type` (`@ScaledMetric`, `dynamicTypeSize`, truncation) |
| `10 Color` | `01 Semantic Colors` (system palette, `.primary`/`.secondary`/`.fill`/`.background`) · `02 Tint & Adaptive` (`.tint()` reach, light/dark, `.mix(with:by:)`) |
| `11 SF Symbols` | `01 Symbol Gallery` (categories, weights, scales) · `02 Rendering Modes` (monochrome/hierarchical/palette/multicolor) · `03 Symbol Effects` (`.symbolEffect`, variable value) |

### Tier 3 — Structure & polish

| Section | Files |
|---|---|
| `12 Animation & Motion` | `01 Implicit Animations` (`.animation(_:value:)`, `.bouncy`/`.smooth`) · `02 Transitions` (`.transition`, `matchedGeometryEffect`; complements `04 Sheet/03 Transitions`) · `03 Gestures` (drag/long-press/swipe, pull-to-refresh) |
| `13 Accessibility` | `01 Labels & Hints` (`.accessibilityLabel`/`.accessibilityHint`/`.accessibilityElement(children:)`) · `02 Traits & Actions` (traits, custom actions, focus order) · `03 Forms Accessibility` (accessible labeling of `06 Controls`) |


## Target

- **Platform:** iOS 26 (builds/runs on the iOS 26.5 simulator)
- **Xcode:** 26
- **Swift:** 6 (strict concurrency, `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`)
- **File discovery:** `PBXFileSystemSynchronizedRootGroup` — new files in the source folder are auto-included, no `.pbxproj` edits needed
- **Note:** the app is named *HIG Gym* (struct `HIG_GymApp`); the Xcode project/scheme and source folder are still named `HIG Camp`.
