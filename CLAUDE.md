## Project Overview

See [PROJECT.md](PROJECT.md) for what this project is, its folder conventions, and a summary of topics covered so far.

## Coding Standards

### Swift Style
- Use Swift 6 strict concurrency
- Prefer `@Observable` over `ObservableObject`
- Use `async/await` for all async operations
- Follow Apple's Swift API Design Guidelines
- Use `guard` for early exits
- Prefer value types (structs) over reference types (classes)

### SwiftUI Patterns
- Extract views when they exceed 100 lines
- Use `@State` for local view state only
- Use `@Environment` for dependency injection
- Prefer `NavigationStack` over deprecated `NavigationView`
- Use `@Bindable` for bindings to @Observable objects

### Navigation Pattern
```swift
// Use NavigationStack with type-safe routing
enum Route: Hashable {
    case detail(Item)
    case settings
}

NavigationStack(path: $router.path) {
    ContentView()
        .navigationDestination(for: Route.self) { route in
            // Handle routing
        } }
}

### Error Handling
// Always use typed errors
enum AppError: LocalizedError {
    case networkError(underlying: Error)
    case validationError(message: String)

    var errorDescription: String? {
        switch self {
        case .networkError(let error): return error.localizedDescription
        case .validationError(let msg): return msg
        }
    } }
}

DO NOT

Write UITests during scaffolding phase
Use deprecated APIs (UIKit when SwiftUI suffices)
Create massive monolithic views
Use force unwrapping (!) without justification
Ignore Swift 6 concurrency warnings

## Demo File Structure

Every file in a numbered topic folder is one demo, read cold by someone who
wants to tinker. Follow this shape exactly — the point is that any two files
rhyme, so a reader learns the layout once.

### The guiding principle

**Chrome is shared, the subject is local.** The nav stack, the tinted
background, the section cards, the Dark Mode toggle — all of that lives in
`00 Shared` and must not be re-implemented. The API a file exists to teach
stays **literal and inline in that file**, never wrapped in a local helper to
save lines. If a reader has to open another file to see what a demo renders,
the extraction went too far.

### Canonical shape

```swift
//
//  NN Topic.swift
//  HIG Camp
//

import SwiftUI

struct TopicDemo: View {
    // MARK: - Variant          ← structural demos only; omit otherwise
    enum Variant { case a, b }
    let variant: Variant

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "...",
        description: "...",
        systemImage: "..."
    )

    // MARK: - State
    @State private var weight: WeightOption = .regular

    // MARK: - Body
    var body: some View {
        DemoPage("Topic", info: infoCard) { _ in
            DemoSection("What this shows") {
                Text("Sample")
                    .fontWeight(weight.weight)      // ← the lesson, literal
                Picker("Weight", selection: $weight) {
                    ForEach(WeightOption.allCases) { Text($0.label).tag($0) }
                }
                .pickerStyle(.segmented)
                caption("`.fontWeight(_:)` refines weight independently of the text style.")
            }
        }
    }

    // MARK: - View Components  ← only when a section is too long to inline
}

// MARK: - Options
enum WeightOption: String, CaseIterable, Identifiable {
    var id: Self { self }
    var label: String { rawValue.capitalized }
}

#Preview("Variant A") { TopicDemo(variant: .a) }
```

Rules:

- **Header comment** is those 4 lines. No `Created by` line.
- **Type name** is the filename minus the number prefix, plus a `Demo` suffix:
  `05 Progress.swift` → `ProgressDemo`. The suffix is mandatory — a bare
  `Progress`, `Menu` or `Grid` shadows a Foundation/SwiftUI type.
- **MARK order is fixed**, exactly as above. Omit a MARK that has no content;
  never reorder them.
- **Previews carry no modifiers.** Tint and colour scheme come from `DemoPage`.
  A preview is a bare `TypeName()` or `TypeName(variant: .x)`.
- **Everything not part of the demo's public surface is `private`.**
- **No `AnyView`.** Use `@ViewBuilder` on a computed property.

### Choosing a variant strategy

| Variation is… | Use | Shape |
|---|---|---|
| **Structural** — the preview must rebuild to show it (tab counts, sheet detents, toolbar placements) | nested `enum Variant` + `let variant` | one named `#Preview` per case |
| **Tinkerable** — a value the reader should drag or flip live (font weight, control size, list style) | top-level `enum <Thing>Option: String, CaseIterable, Identifiable` + `@State` + in-app `Picker` | one `#Preview` |

A file may use both. When in doubt: if a reader would want to see two states
*side by side*, it's structural; if they'd want to *sweep through* them, it's
tinkerable.

### The shared scaffold (`00 Shared`)

| Type | Use |
|---|---|
| `DemoPage(_:info:)` | The standard scrolling screen. Supplies nav stack, title, tinted background, Dark Mode + Randomize Tint toolbar. Pass `toolbar:` for demo-specific items, `infoPlacement: .pinned` to keep the card visible, `fixedTint:` when colour must not change. Its content closure hands you the live tint as a `Color`. |
| `DemoSection(_:)` | A titled card holding one idea. Pass `background:` only when the demo is *about* materials. |
| `caption(_:)` | One-line on-screen explanation under the demo content. Markdown — put API names in backticks. |
| `Color.demoRandom` | The random tint. Never re-implement it. |
| `DemoMetrics` | `cardCorner`, `cardPadding`, `stackSpacing`, `pageMargin`. |
| `DemoScrollView`, `DemoRowView`, `DemoDetailView`, `DemoSearchView`, `DemoPickerView`, `DemoMenuView`, `DemoModalView`, `DemoInfoCard` | Filler content and stand-in destinations. |

Add a `caption()` to each `DemoSection` unless the section already carries
explanatory `Text`. These are the main teaching surface — keep them one
sentence, accurate, and specific to the API on screen.

### When NOT to use `DemoPage`

Demos whose *subject is the page chrome itself* — folders `01 Toolbar`,
`02 Safe Area bar`, `03 Tab bar`, `04 Sheet`, and `05 System Materials` —
build their own `NavigationStack` / `TabView`, because the scaffold would hide
the very thing they teach. Same for any screen built on `List`, which cannot
live inside `DemoPage`'s `ScrollView`.

Those files still follow every other rule (header, naming, MARK order,
captions, `private`) and seed their tint from `.demoRandom`.

