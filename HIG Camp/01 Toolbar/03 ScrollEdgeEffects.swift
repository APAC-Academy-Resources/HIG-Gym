import SwiftUI

struct ScrollEdgeEffectDemoView: View {
    // MARK: - Variant
    enum Variant {
        case soft
        case hard
        case hardWithMaterial
        case automatic
        case hidden
    }

    let variant: Variant

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Scroll down",
        description: "This demo explores different scroll edge effect styles that shows when you scroll the view.",
        systemImage: "circle.lefthalf.striped.horizontal"
    )

    // MARK: - Body
    var body: some View {
        NavigationStack {
            if (variant == .hardWithMaterial) {
                content
                    .toolbarBackground(.thickMaterial, for: .navigationBar)
                    .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            } else {
                content
            }
        }
    }

    // MARK: - Properties & Methods
    var style: ScrollEdgeEffectStyle {
        switch variant {
            case .soft: .soft
            case .hard, .hardWithMaterial: .hard
            default: .automatic
        }
    }

    // MARK: - View Components
    var content: some View {
        DemoScrollView(count: 40)
            .scrollEdgeEffectStyle(style, for: .top)
            .scrollEdgeEffectHidden(variant == .hidden)
            .navigationTitle("Edge Effect")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                DemoSimpleTopToolbar()
            }
            .safeAreaBar(edge: .bottom) {
                infoCard
                    .padding(.horizontal)
                    .padding(.top)
            }
            .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
    }
}

#Preview("Soft") {
    ScrollEdgeEffectDemoView(variant: .soft)
        .tint(.red)
}

#Preview("Hard") {
    ScrollEdgeEffectDemoView(variant: .hard)
        .tint(.purple)
}

#Preview("Hard with Thick Material Background") {
    ScrollEdgeEffectDemoView(variant: .hardWithMaterial)
        .tint(.purple)
}


#Preview("Automatic") {
    ScrollEdgeEffectDemoView(variant: .automatic)
        .tint(.brown)
}

#Preview("Hidden") {
    ScrollEdgeEffectDemoView(variant: .hidden)
        .tint(.brown)
}
