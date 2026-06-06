import SwiftUI

struct ScrollEdgeEffectDemoView: View {
    let style: ScrollEdgeEffectStyle

    var body: some View {
        NavigationStack {
            DemoScrollView(count: 40)
            .background(.red.gradient.opacity(0.7))
            .tint(.red)
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
