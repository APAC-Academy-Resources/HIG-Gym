import SwiftUI

enum VerticalSafeAreaBarEdge {
    case top
    case bottom
    case both
}

/// Demonstrates `safeAreaBar(edge:)` on the **vertical** edges (`.top` / `.bottom`).
///
/// A vertical safe area bar pins a control strip along the top or bottom and *insets*
/// the scrolling content so it never slides under the strip — while still extending the
/// scroll edge effect (Liquid Glass) behind it. Pass `showMaterial` to back the strip
/// with `.ultraThinMaterial`; pass `toolbar` to add a real navigation/bottom `toolbar`
/// alongside the bar, showing how the two layout systems stack and coexist.
struct VerticalSafeAreaBarDemoView: View {
    let edge: VerticalSafeAreaBarEdge
    var showMaterial = false
    var toolbar = false
    var title = true

    @State private var topSelection = 0
    @State private var bottomSelection = 0
    @State private var isOn = false

    var body: some View {
        NavigationStack {
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

    private var demoList: some View {
        DemoScrollView(count: 35)
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

    /// A real `toolbar` (top action + bottom bar) shown alongside the safe area bar(s).
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
