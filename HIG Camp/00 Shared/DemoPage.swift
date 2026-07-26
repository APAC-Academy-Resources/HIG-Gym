//
//  DemoPage.swift
//  HIG Camp
//

import SwiftUI

/// The standard scrolling demo screen: nav stack, title, tinted background,
/// and a toolbar with Dark Mode and Randomize Tint.
///
/// Everything a demo page repeats lives here so each demo file contains only
/// the API it teaches. Compose the body out of ``DemoSection`` cards:
///
/// ```swift
/// var body: some View {
///     DemoPage("Progress", info: infoCard) { tint in
///         DemoSection("Indeterminate") {
///             ProgressView()
///             caption("A `ProgressView` with no value spins indefinitely.")
///         }
///     }
/// }
/// ```
///
/// The content closure receives the live tint as a `Color`. Most demos ignore
/// it and read the ambient `.tint` shape style instead; take it when you need
/// an actual `Color` value, e.g. to build a gradient.
struct DemoPage<Content: View, Extra: ToolbarContent>: View {
    /// Where the info card sits on screen.
    enum InfoPlacement {
        /// Scrolls with the content, above the first section.
        case inline
        /// Pinned to the bottom edge, always visible while scrolling.
        case pinned
    }

    let title: String
    /// Explains what to look at. Omit for demos that are self-evident.
    var info: DemoInfoCard?
    var infoPlacement: InfoPlacement = .inline
    /// Overrides the randomizer for demos where colour is the subject and must
    /// not change. Also removes the Randomize Tint button.
    var fixedTint: Color?
    var extraToolbar: () -> Extra
    var content: (Color) -> Content

    @State private var randomTint: Color = .demoRandom
    @State private var isDarkMode = false

    private var tint: Color { fixedTint ?? randomTint }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: DemoMetrics.stackSpacing) {
                    if let info, infoPlacement == .inline {
                        info
                    }
                    content(tint)
                }
                .padding(.vertical)
            }
            .contentMargins(DemoMetrics.pageMargin)
            .background(.tint.secondary)
            .navigationTitle(title)
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                extraToolbar()
                if fixedTint == nil {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Randomize Tint", systemImage: "arrow.trianglehead.2.clockwise") {
                            randomTint = .demoRandom
                        }
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Toggle("Dark Mode", systemImage: "moon.fill", isOn: $isDarkMode)
                }
            }
            .safeAreaBar(edge: .bottom) {
                if let info, infoPlacement == .pinned {
                    info.padding(.horizontal)
                }
            }
            .animation(.easeInOut, value: tint)
        }
        .tint(tint)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

// MARK: - Convenience initializers

extension DemoPage where Extra == EmptyDemoToolbar {
    /// The common case: no toolbar items beyond Dark Mode and Randomize Tint.
    init(
        _ title: String,
        info: DemoInfoCard? = nil,
        infoPlacement: InfoPlacement = .inline,
        fixedTint: Color? = nil,
        @ViewBuilder content: @escaping (Color) -> Content
    ) {
        self.init(
            title: title,
            info: info,
            infoPlacement: infoPlacement,
            fixedTint: fixedTint,
            extraToolbar: { EmptyDemoToolbar() },
            content: content
        )
    }
}

extension DemoPage {
    /// Adds demo-specific toolbar items alongside the standard two.
    init(
        _ title: String,
        info: DemoInfoCard? = nil,
        infoPlacement: InfoPlacement = .inline,
        fixedTint: Color? = nil,
        @ToolbarContentBuilder toolbar: @escaping () -> Extra,
        @ViewBuilder content: @escaping (Color) -> Content
    ) {
        self.init(
            title: title,
            info: info,
            infoPlacement: infoPlacement,
            fixedTint: fixedTint,
            extraToolbar: toolbar,
            content: content
        )
    }
}

/// Stands in for "no extra toolbar items".
///
/// `ToolbarContentBuilder` has no empty `buildBlock`, so a generic default
/// needs a concrete type to point at. An empty group renders nothing.
struct EmptyDemoToolbar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .primaryAction) { }
    }
}

#Preview("Inline info card") {
    DemoPage(
        "Demo Page",
        info: DemoInfoCard(
            title: "The standard scaffold",
            description: "Nav stack, tinted background, section cards and the Dark Mode / Randomize Tint toolbar — all supplied by DemoPage.",
            systemImage: "rectangle.on.rectangle"
        )
    ) { tint in
        DemoSection("A section") {
            Text("Content goes here.")
            caption("Each `DemoSection` is one idea.")
        }
        DemoSection("Using the tint value") {
            RoundedRectangle(cornerRadius: DemoMetrics.cardCorner)
                .fill(tint.gradient)
                .frame(height: 80)
            caption("The content closure hands you the live tint as a `Color`.")
        }
    }
}

#Preview("Pinned info card + extra toolbar") {
    DemoPage(
        "Demo Page",
        info: DemoInfoCard(description: "A pinned card stays visible while the content scrolls."),
        infoPlacement: .pinned,
        toolbar: {
            ToolbarItem(placement: .topBarLeading) {
                Button("Add", systemImage: "plus") { }
            }
        }
    ) { _ in
        ForEach(1...6, id: \.self) { index in
            DemoSection("Section \(index)") {
                Text("Content goes here.")
            }
        }
    }
}
