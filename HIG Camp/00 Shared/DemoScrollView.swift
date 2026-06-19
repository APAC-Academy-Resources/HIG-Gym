import SwiftUI

struct DemoScrollView: View {
    let count: Int
    var tint: Color = Color(.tintColor)
    /// When this value changes, the list scrolls back to the top.
    var scrollResetToken: AnyHashable? = nil

    @State private var position = ScrollPosition()

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
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
        .background(tint.gradient.opacity(0.5))
        .contentMargins(.horizontal, 16, for: .automatic)
        .onChange(of: scrollResetToken) {
            withAnimation { position.scrollTo(edge: .top) }
        }
    }
}

#Preview {
    NavigationStack {
        DemoScrollView(count: 24)
    }
}
