import SwiftUI

struct ScrollEdgeEffectDemoView: View {
    let style: ScrollEdgeEffectStyle

    var body: some View {
        NavigationStack {
            DemoScrollView(count: 40)
                .scrollEdgeEffectStyle(style, for: .all)
                .toolbarTitleDisplayMode(.inline)
                .navigationTitle("Edge Effect")
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
        }
    }
}

#Preview("Soft") {
    ScrollEdgeEffectDemoView(style: .soft)
        .tint(.red)
}

#Preview("Hard") {
    ScrollEdgeEffectDemoView(style: .hard)
        .tint(.purple)
}

#Preview("Automatic") {
    ScrollEdgeEffectDemoView(style: .automatic)
        .tint(.brown)
}
    