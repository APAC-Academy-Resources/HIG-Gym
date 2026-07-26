//
//  03 ScrollEdgeEffects.swift
//  HIG Camp
//

import SwiftUI

struct ScrollEdgeEffectsDemo: View {
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

    // MARK: - State
    private let tint: Color = .purple

    private var style: ScrollEdgeEffectStyle {
        switch variant {
        case .soft: .soft
        case .hard, .hardWithMaterial: .hard
        default: .automatic
        }
    }
    
    private var customMaterialBackground: Bool {
        variant == .hardWithMaterial
    }
    
    @State private var sheetIsOpen = false

    // MARK: - Body
    var body: some View {
        NavigationStack {
            if customMaterialBackground {
                content
                    .toolbarBackground(.thickMaterial, for: .navigationBar)
                    .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            } else {
                content
            }
        }
        .tint(tint)
    }

    // MARK: - View Components
    private var content: some View {
        DemoScrollView(count: 40)
            .scrollEdgeEffectStyle(style, for: .top)
            .scrollEdgeEffectHidden(variant == .hidden)
            .navigationTitle("Edge Effect")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                DemoSimpleTopToolbar()
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Open Sheet") {
                        sheetIsOpen.toggle()
                    }
                }
            }
            .safeAreaBar(edge: .bottom) {
                infoCard
                    .padding(.horizontal)
                    .padding(.top)
            }
            .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
            .sheet(isPresented: $sheetIsOpen) {
                NavigationStack {
                    if customMaterialBackground {
                        sheetContent
                            .toolbarBackground(.thickMaterial, for: .navigationBar)
                            .toolbarBackgroundVisibility( .visible, for: .navigationBar)
                    } else {
                        sheetContent
                    }
                }
                .presentationDetents([.medium])
            }
    }
    
    private var sheetContent: some View {
        DemoScrollView(count: 40)
            .scrollEdgeEffectStyle(style, for: .top)
            .scrollEdgeEffectHidden(variant == .hidden)
            .navigationTitle("Edge Effect on Sheet")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                DemoMixedTopToolbar()
            }
            .presentationDragIndicator(.visible)
    }
}

#Preview("Soft") {
    ScrollEdgeEffectsDemo(variant: .soft)
}

#Preview("Hard") {
    ScrollEdgeEffectsDemo(variant: .hard)
}

#Preview("Hard with Thick Material Background") {
    ScrollEdgeEffectsDemo(variant: .hardWithMaterial)
}

#Preview("Automatic") {
    ScrollEdgeEffectsDemo(variant: .automatic)
}

#Preview("Hidden") {
    ScrollEdgeEffectsDemo(variant: .hidden)
}
