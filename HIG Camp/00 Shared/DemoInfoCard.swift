//
//  DemoInfoCard.swift
//  HIG Camp
//

import SwiftUI

/// The "what to look at" card that opens most demo screens.
///
/// ``DemoPage`` renders one for you — pass it as `info:`. Screens that build
/// their own stack place it themselves, usually in a `.safeAreaBar`.
struct DemoInfoCard: View {
    /// Bold heading. Omit for a single-paragraph note.
    var title: String?
    /// The explanation. This is the part people actually read.
    let description: String
    /// Leading SF Symbol.
    var systemImage: String = "info.bubble"

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: systemImage)
                .foregroundStyle(.tint)
                .font(.largeTitle)

            VStack(alignment: .leading, spacing: 8) {
                if let title {
                    Text(title)
                        .font(.title3)
                        .bold()
                }
                Text(description)
                    .font(.default)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.vertical, DemoMetrics.cardPadding)
        .background(.background, in: RoundedRectangle(cornerRadius: DemoMetrics.cardCorner))
    }
}

#Preview("Title and description") {
    DemoInfoCard(
        title: "Material as background",
        description: "Observe how the cards interact with the window background.",
        systemImage: "lightspectrum.horizontal"
    )
    .padding()
    .background(.tint.secondary)
}

#Preview("Description only") {
    DemoInfoCard(description: "A card with no title reads as a plain note.")
        .padding()
        .background(.tint.secondary)
}
