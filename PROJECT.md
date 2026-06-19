# HIG Camp — Project Overview

## Purpose

A personal iOS 26 teaching/reference app for exploring Apple Human Interface Guidelines in practice. Each view demonstrates a specific configuration or capability of a system component. The app is used **primarily through Xcode Previews** — there is no central navigation UI.

## Conventions

- Each HIG topic area gets its own subfolder under `HIG Camp/`
- A topic folder contains one file per component (e.g. `ToolbarTitleDisplayModes.swift`)
- Nested concepts (e.g. display mode variants) live as multiple `#Preview` macros in the same file
- Views are parameterized so multiple previews share one struct
- `ScrollView + ForEach` is preferred over `List` to allow background customization
- No UITests, no central router, no shared coordinator

## Current Topics

### Toolbar (`HIG Camp/Toolbar/`)

| File | What it demos |
|---|---|
| `ToolbarTitleDisplayModes.swift` | Navigation title display modes (`.large`, `.inlineLarge`, `.inline`) + detail view with grouped toolbar items (`ToolbarItemGroup`) |
| `ToolbarWithSearchBar.swift` | `.searchable()` placements: `.automatic`, `.navigationBarDrawer`, `.navigationBarDrawer(displayMode: .always)`, `.toolbarPrincipal` |
| `ScrollEdgeEffects.swift` | `scrollEdgeEffectStyle(_:for:)` — `.soft`, `.hard`, `.automatic` (iOS 26+) |

## Target

- **Platform:** iOS 26.4+
- **Xcode:** 26.4
- **Swift:** 6 (strict concurrency, `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`)
- **File discovery:** `PBXFileSystemSynchronizedRootGroup` — new files added to the source folder are auto-included, no `.pbxproj` edits needed
