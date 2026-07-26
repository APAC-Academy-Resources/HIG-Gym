//
//  05 Dynamic Type.swift
//  HIG Camp
//

import SwiftUI

struct DynamicTypeDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Dynamic Type",
        description: "Text built on semantic styles scales with the user's preferred size. Drag the size control to preview from xSmall up to accessibility5, and watch @ScaledMetric grow the icon and spacing to match. Clamp the range when a layout can't absorb the largest sizes.",
        systemImage: "textformat.size.larger"
    )

    // MARK: - State
    @State private var sizeIndex = 3.0            // index into DynamicTypeSize.allCases
    @State private var clamp = false

    // Scales with the *ambient* Dynamic Type size so it tracks the previewed size below.
    @ScaledMetric(relativeTo: .largeTitle) private var iconSize = 34

    private var selectedSize: DynamicTypeSize {
        let all = DynamicTypeSize.allCases
        return all[min(max(Int(sizeIndex.rounded()), 0), all.count - 1)]
    }

    private func label(for size: DynamicTypeSize) -> String {
        switch size {
        case .xSmall: "xSmall"
        case .small: "small"
        case .medium: "medium"
        case .large: "large (default)"
        case .xLarge: "xLarge"
        case .xxLarge: "xxLarge"
        case .xxxLarge: "xxxLarge"
        case .accessibility1: "accessibility1"
        case .accessibility2: "accessibility2"
        case .accessibility3: "accessibility3"
        case .accessibility4: "accessibility4"
        case .accessibility5: "accessibility5"
        @unknown default: "unknown"
        }
    }

    // MARK: - Body
    var body: some View {
        DemoPage("Dynamic Type", info: infoCard) { _ in
            Group {
                DemoSection("Preview size") {
                    LabeledContent("Size", value: label(for: selectedSize))
                    Slider(value: $sizeIndex,
                           in: 0...Double(DynamicTypeSize.allCases.count - 1),
                           step: 1)
                    Toggle("Clamp to .large", isOn: $clamp)
                    caption("Everything below inherits this size via `.dynamicTypeSize(_:)`. Clamping caps the effective size at `.large` so tight layouts stay intact.")
                }

                DemoSection("Scaling content") {
                    HStack(spacing: 16) {
                        Image(systemName: "bell.badge.fill")
                            .font(.system(size: iconSize))
                            .foregroundStyle(.tint)
                        VStack(alignment: .leading) {
                            Text("Notifications").font(.headline)
                            Text("Body text and the leading icon grow together because the icon uses @ScaledMetric.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    caption("`@ScaledMetric(relativeTo:)` scales a raw number against a text style, so icons and spacing keep pace with the type.")
                }

                DemoSection("Reflow & truncation") {
                    Label("A label truncates to one line under large sizes", systemImage: "arrow.left.and.right")
                        .lineLimit(1)
                        .font(.callout)
                    caption("At accessibility sizes single-line text truncates — pair large sizes with generous `lineLimit` or `ViewThatFits` (see 01 Text Behaviours).")
                }
            }
            // Apply the previewed size to every section.
            .dynamicTypeSize(clamp ? .xSmall ... .large : selectedSize ... selectedSize)
        }
    }
}

#Preview {
    DynamicTypeDemo()
}
