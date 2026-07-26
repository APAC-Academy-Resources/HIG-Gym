//
//  DemoSection.swift
//  HIG Camp
//

import SwiftUI

/// A titled card grouping one idea inside a ``DemoPage``.
///
/// Put only the API being taught inside the closure — the card, the title
/// treatment and the spacing are handled here so the demo reads as the
/// component and nothing else.
///
/// ```swift
/// DemoSection("Monospaced digits") {
///     Text("00:00:07.42")
///         .monospacedDigit()
///     caption("`.monospacedDigit()` keeps numbers from shifting as they change.")
/// }
/// ```
struct DemoSection<Content: View>: View {
    /// Shown uppercased above the content.
    let title: String
    /// Fill behind the card. Override when the demo is *about* materials.
    var background: AnyShapeStyle = AnyShapeStyle(.windowBackground)
    @ViewBuilder var content: () -> Content

    init(
        _ title: String,
        background: AnyShapeStyle = AnyShapeStyle(.windowBackground),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.background = background
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: DemoMetrics.stackSpacing) {
            Text(title)
                .textCase(.uppercase)
                .font(.caption)
                .bold()
                .foregroundStyle(.secondary)
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(DemoMetrics.cardPadding)
        .background(background, in: RoundedRectangle(cornerRadius: DemoMetrics.cardCorner))
    }
}

/// A one-line explanation of the API demonstrated directly above it.
///
/// Wrap API names in backticks — the string is a `LocalizedStringKey`, so
/// Markdown renders: ``caption("`.lineLimit(_:)` caps the line count.")``.
func caption(_ markdown: LocalizedStringKey) -> some View {
    Text(markdown)
        .font(.caption)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
}

#Preview {
    ScrollView {
        VStack(spacing: DemoMetrics.stackSpacing) {
            DemoSection("Default background") {
                Text("00:00:07.42")
                    .font(.title2)
                    .monospacedDigit()
                caption("`.monospacedDigit()` keeps numbers from shifting as they change.")
            }
            DemoSection("Custom background", background: AnyShapeStyle(.regularMaterial)) {
                Text("For demos that are about materials.")
            }
        }
        .padding(DemoMetrics.pageMargin)
    }
    .background(.tint.secondary)
    .tint(.demoRandom)
}
