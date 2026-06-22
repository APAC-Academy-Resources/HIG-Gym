import SwiftUI

/// Demonstrates `safeAreaBar(edge:)` on the **vertical** edges (`.top` / `.bottom`).
///
/// A vertical safe area bar pins a control strip along the top or bottom and *insets*
/// the scrolling content so it never slides under the strip — while still extending the
/// scroll edge effect (Liquid Glass) behind it. Pass `showMaterial` to back the strip
/// with `.ultraThinMaterial`; pass `toolbar` to add a real navigation/bottom `toolbar`
/// alongside the bar, showing how the two layout systems stack and coexist.
struct VerticalSafeAreaBarDemoView: View {
    // MARK: - Variant
    enum VerticalSafeAreaBarEdge {
        case top
        case bottom
        case both
    }

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Safe Area Bars",
        description: "This is newly introduced in iOS26. A Safe Area Bar integrates with the top or bottom toolbar. The system's scroll edge effect extends to cover the safe area bar.",
        systemImage: "sparkles"
    )

    // MARK: - Properties & Methods
    let edge: VerticalSafeAreaBarEdge
    var showMaterial = false
    var toolbar = false
    var title = true

    @State private var topSelection = 0
    @State private var bottomSelection = 0
    @State private var isOn = false

    // MARK: - Body
    var body: some View {
        NavigationStack {
            Group {
                switch edge {
                case .top:
                    demoList
                        .safeAreaBar(edge: .top) { topBar($topSelection) }
                    
                case .bottom:
                    demoList
                        .safeAreaBar(edge: .bottom) { bottomBar($bottomSelection) }
                    
                case .both:
                    demoList
                        .safeAreaBar(edge: .top) { topBar($topSelection) }
                        .safeAreaBar(edge: .bottom) { bottomBar($bottomSelection) }
                }
            }
        }
    }

    // MARK: - View Components
    private var demoList: some View {
        DemoScrollView(count: 35, infoCard: infoCard)
            .scrollEdgeEffectStyle(showMaterial ? .hard : .soft, for: .vertical)
            .toolbarTitleDisplayMode(.inline)
            .navigationTitle(title ? "Safe Area Bar" : "")
            .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
            .toolbar { toolbarContent }
    }

    private func topBar(_ selection: Binding<Int>) -> some View {
        DemoPickerView(selectedSegment: selection)
            .controlSize(.large)
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.vertical, 8)
    }
    
    private func bottomBar(_ selection: Binding<Int>) -> some View {
        HStack {
            Text("SFO")
                .bold()

            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 6)
                .foregroundStyle(.tint)
            VStack {
                Image(systemName: "airplane")
            }
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 6)
                .foregroundStyle(.tint)

            Text("CGK")
                .bold()
        }
        .padding()
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        if toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add", systemImage: "plus") { }
            }
            ToolbarItem(placement: .bottomBar) {
                Toggle(isOn: $isOn) {
                    Label("Filter", systemImage: "line.3.horizontal.decrease")
                }
                .toggleStyle(.button)
            }
            ToolbarSpacer(placement: .bottomBar)
            ToolbarItem(placement: .bottomBar) {
                Button("Erase", systemImage: "square.and.arrow.up") { }
            }
            ToolbarItem(placement: .bottomBar) {
                Button("Write", systemImage: "pencil.and.scribble") { }
            }
        }
    }
}

#Preview("Top no title") {
    VerticalSafeAreaBarDemoView(edge: .top, title: false)
        .tint(.orange)
}

#Preview("Top") {
    VerticalSafeAreaBarDemoView(edge: .top)
        .tint(.orange)
}

#Preview("Top + Background") {
    VerticalSafeAreaBarDemoView(edge: .top, showMaterial: true)
        .tint(.indigo)
}

#Preview("Bottom") {
    VerticalSafeAreaBarDemoView(edge: .bottom)
        .tint(.blue)
}

#Preview("Bottom + Background + Toolbar") {
    VerticalSafeAreaBarDemoView(edge: .bottom, showMaterial: true, toolbar: true)
        .tint(.brown)
}

#Preview("Both") {
    VerticalSafeAreaBarDemoView(edge: .both)
        .tint(.purple)
}

#Preview("Both + Toolbar") {
    VerticalSafeAreaBarDemoView(edge: .both, toolbar: true)
        .tint(.pink)
}
