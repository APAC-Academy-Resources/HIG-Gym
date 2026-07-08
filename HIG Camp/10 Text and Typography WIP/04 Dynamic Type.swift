//
//  04 Dynamic Type.swift
//  HIG Camp
//
//  Created by George Ananda on 07/07/26.
//

import SwiftUI

struct DynamicType: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Dynamic Type",
        description: "Text built on semantic styles scales with the user's preferred size. Drag the size control to preview from xSmall up to accessibility5, and watch @ScaledMetric grow the icon and spacing to match. Clamp the range when a layout can't absorb the largest sizes.",
        systemImage: "textformat.size.larger"
    )

    // MARK: - Properties
    @State private var darkModeOn = false
    @State private var tint = DynamicType.getRandomColor()
    @State private var sizeIndex = 3.0            // index into DynamicTypeSize.allCases
    @State private var clamp = false

    // Scales with the *ambient* Dynamic Type size so it tracks the previewed size below.
    @ScaledMetric(relativeTo: .largeTitle) private var iconSize = 34

    static func getRandomColor() -> Color {
        Color(hue: .random(in: 0...1), saturation: .random(in: 0.4...0.8), brightness: .random(in: 0.6...0.8))
    }

    private var selectedSize: DynamicTypeSize {
        let all = DynamicTypeSize.allCases
        return all[min(max(Int(sizeIndex.rounded()), 0), all.count - 1)]
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    infoCard

                    section("Preview size") {
                        LabeledContent("Size", value: label(for: selectedSize))
                        Slider(value: $sizeIndex,
                               in: 0...Double(DynamicTypeSize.allCases.count - 1),
                               step: 1)
                        Toggle("Clamp to .large", isOn: $clamp)
                        caption("Everything below inherits this size via `.dynamicTypeSize(_:)`. Clamping caps the effective size at `.large` so tight layouts stay intact.")
                    }

                    section("Scaling content") {
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
                    }

                    section("Reflow & truncation") {
                        Label("A label truncates to one line under large sizes", systemImage: "arrow.left.and.right")
                            .lineLimit(1)
                            .font(.callout)
                        caption("At accessibility sizes single-line text truncates — pair large sizes with generous `lineLimit` or `ViewThatFits` (see 01 Text Behaviours).")
                    }
                }
                .padding(.vertical)
                // Apply the previewed size to the whole stack.
                .dynamicTypeSize(clamp ? .xSmall ... .large : selectedSize ... selectedSize)
            }
            .contentMargins(16)
            .navigationTitle("Dynamic Type")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar { toolbar }
            .animation(.easeInOut, value: tint)
            .background(.tint.opacity(0.5))
        }
        .tint(tint)
        .preferredColorScheme(darkModeOn ? .dark : .light)
    }

    // MARK: - View Components
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

    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = DynamicType.getRandomColor()
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Toggle("Dark Mode", systemImage: "moon.fill", isOn: $darkModeOn)
        }
    }

    func caption(_ markdown: LocalizedStringKey) -> some View {
        Text(markdown)
            .font(.caption)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    func section(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .textCase(.uppercase)
                .font(.caption)
                .bold()
                .foregroundStyle(.secondary)
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    DynamicType()
}
