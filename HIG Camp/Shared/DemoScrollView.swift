import SwiftUI

struct DemoScrollView: View {
    let count: Int

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(1...count, id: \.self) { index in
                    let label = "Item \(index)"
                    NavigationLink(value: label) {
                        DemoRowView(label: label)
                    }
                }
            }
            .padding(.vertical)
        }
        .contentMargins(.horizontal, 16, for: .automatic)
    }
}
