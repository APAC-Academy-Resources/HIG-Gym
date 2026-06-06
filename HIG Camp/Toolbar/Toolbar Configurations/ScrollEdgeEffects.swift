import SwiftUI

struct ScrollEdgeEffectDemoView: View {
    let style: ScrollEdgeEffectStyle

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(0..<40) { index in
                        DemoRow(label: "Item \(index + 1)")
                    }
                }
                .padding(.vertical)
            }
            .scrollEdgeEffectStyle(style, for: .all)
            .navigationTitle("Edge Effect")
            .toolbarTitleDisplayMode(.inline)
        }
    }
}

#Preview("Soft") {
    ScrollEdgeEffectDemoView(style: .soft)
}

#Preview("Hard") {
    ScrollEdgeEffectDemoView(style: .hard)
}

#Preview("Automatic") {
    ScrollEdgeEffectDemoView(style: .automatic)
}
