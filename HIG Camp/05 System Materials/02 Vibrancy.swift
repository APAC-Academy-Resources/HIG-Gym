//
//  02 Vibrancy.swift
//  HIG Camp
//

import SwiftUI

struct VibrancyDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Hierarchical Style Foreground",
        description: "Applying a hierarchical style (primary, secondary, etc) to an element's foreground style when it has a system material background will trigger vibrancy. Randomize the tint from the toolbar to see the cards resample the colour behind them.",
        systemImage: "lightspectrum.horizontal"
    )

    // MARK: - Body
    var body: some View {
        DemoPage("Vibrancy", info: infoCard) { _ in
            sampleCard("Background", material: AnyShapeStyle(.background))
            sampleCard("Regular Material", material: AnyShapeStyle(.regularMaterial))
            sampleCard("Thick Material", material: AnyShapeStyle(.thickMaterial))
            sampleCard("Ultra Thick Material", material: AnyShapeStyle(.ultraThickMaterial))
            sampleCard("Thin Material", material: AnyShapeStyle(.thinMaterial))
            sampleCard("Ultra Thin Material", material: AnyShapeStyle(.ultraThinMaterial))
        }
    }

    // MARK: - View Components

    /// One card showing the full hierarchical ramp over a given material.
    private func sampleCard(_ title: String, material: AnyShapeStyle) -> some View {
        DemoSection(title, background: material) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Title Primary")
                        .font(.title)
                        .fontDesign(.serif)
                        .foregroundStyle(.primary)
                    Label("Caption Secondary Bold", systemImage: "checkmark.circle.fill")
                        .textCase(.uppercase)
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "book.pages.fill")
                    .font(.title3)
                    .padding(10)
                    .foregroundStyle(.secondary)
                    .background(.fill.secondary, in: .circle)
            }

            Text("Body Primary as Section")

            Divider()

            Text("Body Secondary. Every element in this card specifies no colour of its own — only the system's hierarchical foreground styles. The result adapts to whatever is behind the card's \(title) background.")
                .font(.body)
                .foregroundStyle(.secondary)

            Divider()

            Text("Body Tertiary. Vibrancy only kicks in when a hierarchical foreground style sits on a material background, like this tertiary text on the card's \(title) background.")
                .font(.body)
                .foregroundStyle(.tertiary)

            Divider()

            Text("What's up Quaternary")
                .font(.body)
                .foregroundStyle(.quaternary)
            Text("Yo Quinary here")
                .font(.body)
                .foregroundStyle(.quinary)

            caption("`.primary` through `.quinary` step down in contrast; over a material each one samples the colour behind it.")
        }
    }
}

#Preview {
    VibrancyDemo()
}
