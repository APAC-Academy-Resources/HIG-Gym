import SwiftUI

/// Demonstrates `safeAreaBar(edge:)` on the **horizontal** edges (`.leading` / `.trailing`).
///
/// A horizontal safe area bar pins a control rail along a side and *insets* the content
/// so it never slides under the rail — ideal for tool palettes in landscape, on iPad,
/// or in creative/editor apps. Unlike `safeAreaInset`, it also extends the scroll edge
/// effect behind the bar (Liquid Glass). The `alignment:` here is a `VerticalAlignment`
/// (`.top` / `.center` / `.bottom`); chain multiple calls to inset more than one edge.
struct HorizontalSafeAreaBarDemoView: View {
    // MARK: - Variant
    enum Variant {
        case trailing
        case leading
        case both
    }

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Horizontal Safe Area Bar",
        description: "A side rail pinned to the leading or trailing edge. Content insets so it never slides under the rail — and the scroll edge effect still extends behind it.",
        systemImage: "sidebar.right"
    )

    // MARK: - Properties & Methods
    let variant: Variant

    // MARK: - Body
    var body: some View {
        NavigationStack {
            switch variant {
            case .trailing:
                demoList
                    .safeAreaBar(edge: .trailing) {
                        ToolRail(tools: ToolRail.editing)
                    }

            case .leading:
                demoList
                    // alignment is a VerticalAlignment for horizontal edges
                    .safeAreaBar(
                        edge: .leading,
                        alignment: .top
                    ) {
                        ToolRail(
                            tools: ToolRail.layers,
                            material: true
                        )
                    }

            case .both:
                demoList
                    .safeAreaBar(edge: .leading) {
                        ToolRail(tools: ToolRail.layers, material: false)
                    }
                    .safeAreaBar(edge: .trailing) {
                        ToolRail(tools: ToolRail.editing, material: true)
                    }
            }
        }
    }

    // MARK: - View Components
    private var demoList: some View {
        DemoScrollView(count: 35, infoCard: infoCard)
            .scrollEdgeEffectStyle(.hard, for: .horizontal)
            .toolbarTitleDisplayMode(.inline)
            .navigationTitle("Horizontal Safe Area Bar")
            .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
    }
}

/// A vertical rail of tool buttons, laid out down the edge it is attached to.
private struct ToolRail: View {
    struct Tool: Identifiable {
        let label: String
        let symbol: String
        var id: String { symbol }
    }

    static let editing: [Tool] = [
        Tool(label: "Crop", symbol: "crop"),
        Tool(label: "Filters", symbol: "camera.filters"),
        Tool(label: "Adjust", symbol: "slider.horizontal.3"),
        Tool(label: "Enhance", symbol: "wand.and.stars"),
    ]

    static let layers: [Tool] = [
        Tool(label: "Layers", symbol: "square.3.layers.3d"),
        Tool(label: "Grid", symbol: "square.grid.2x2"),
        Tool(label: "Guides", symbol: "ruler"),
    ]

    let tools: [Tool]
    var material: Bool = false

    var body: some View {
        VStack(spacing: 24) {
            ForEach(tools) { tool in
                Button(tool.label, systemImage: tool.symbol) { }
            }
        }
        .font(.title2)
        .foregroundStyle(.primary)
        .labelStyle(.iconOnly)
        .padding(.vertical, 18)
        .padding(.horizontal, 12)
        .background(
            material ? AnyShapeStyle(.thinMaterial) : AnyShapeStyle(.clear),
            in: Capsule()
        )
    }
}

#Preview("Trailing") {
    HorizontalSafeAreaBarDemoView(variant: .trailing)
        .tint(.orange)
}

#Preview("Leading") {
    HorizontalSafeAreaBarDemoView(variant: .leading)
        .tint(.indigo)
}

#Preview("Both Edges") {
    HorizontalSafeAreaBarDemoView(variant: .both)
        .tint(.pink)
}
