//
//  DemoScrollView.swift
//  HIG Camp
//

import SwiftUI

/// A tinted scrolling list of placeholder rows that navigate to
/// ``DemoDetailView``.
///
/// The default filler for any demo that needs scrollable content behind the
/// chrome it is showing off. Register the destination at the call site:
/// ```swift
/// .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
/// ```
struct DemoScrollView: View {
    /// How many rows to generate.
    let count: Int
    /// Background wash behind the rows.
    var tint: Color = Color(.tintColor)
    /// When this value changes, the list scrolls back to the top.
    var scrollResetToken: AnyHashable? = nil
    /// Optional card pinned above the first row, scrolling with the content.
    var infoCard: DemoInfoCard?

    @State private var position = ScrollPosition()

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                if let infoCard {
                    infoCard
                }

                ForEach(1...count, id: \.self) { index in
                    let label = "Item \(index)"
                    NavigationLink(value: label) {
                        DemoRowView(label: label)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical)
        }
        .scrollPosition($position)
        .background(tint.gradient.secondary)
        .contentMargins(.horizontal, DemoMetrics.pageMargin, for: .automatic)
        .onChange(of: scrollResetToken) {
            withAnimation { position.scrollTo(edge: .top) }
        }
    }
}

#Preview {
    NavigationStack {
        DemoScrollView(
            count: 24,
            infoCard: DemoInfoCard(
                title: "Hello",
                description: "This is an info card to let viewers know what to pay attention to",
                systemImage: "star.fill"
            )
        )
        .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
    }
}
