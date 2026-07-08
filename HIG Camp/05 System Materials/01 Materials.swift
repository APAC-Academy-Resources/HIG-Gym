//
//  01 Materials.swift
//  HIG Camp
//
//  Created by George Ananda on 20/06/26.
//

import SwiftUI

struct Materials: View {
    // MARK: - Variant
    enum Variant {
        case photoBackground
        case gradientBackground
        case solidBackground
    }
    
    let variant: Variant
    
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Material as background",
        description: "Observe how the cards interacts with the window background",
        systemImage: "lightspectrum.horizontal"
    )
    
    // MARK: - Properties & Methods
    @State var selectedColor: Color = Materials.getRandomColor()
    @State private var darkModeOn: Bool = false

    var cardShape: some Shape = RoundedRectangle(cornerRadius: 24)

    var tint: Color = .green.mix(with: .mint, by: 0.5)
    
    let customGradient: LinearGradient = LinearGradient(
        colors: [
            .blue,
            .mint,
            .orange
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static func getRandomColor() -> Color {
        Color(
            hue: .random(in: 0...1),
            saturation: .random(in: 0.4...0.8),
            brightness: .random(in: 0.6...0.8)
        )
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 28, pinnedViews: [.sectionHeaders]) {
                    standardMaterialsSection

                    Spacer()

                    liquidGlassSection

                    Spacer()

                    semanticMaterialsSection
                }
                .padding(.bottom)
            }
            .contentMargins(.horizontal, 16)
            .background { background }
            .navigationTitle("Materials")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbarBackgroundVisibility(
                .visible, for: .navigationBar)
            .toolbarBackground(.bar, for: .navigationBar)
            .scrollEdgeEffectStyle(.hard, for: .top)
            .toolbar {
                toolbar
            }
            .safeAreaBar(edge: .bottom) {
                infoCard
                    .padding(.horizontal)
            }
            .animation(.easeInOut, value: selectedColor)
        }
        .tint(tint)
        .preferredColorScheme(darkModeOn ? .dark : .light)
    }

    // MARK: - View Components
    private var standardMaterialsSection: some View {
        Section {
            card(material: "Ultra Thick Material")
                .background(.ultraThickMaterial, in: cardShape)

            card(material: "Thick Material")
                .background(.thickMaterial, in: cardShape)

            card(material: "Regular Material")
                .background(.regularMaterial, in: cardShape)

            card(material: "Thin Material")
                .background(.thinMaterial, in: cardShape)

            card(material: "Ultra Thin Material")
                .background(.ultraThinMaterial, in: cardShape)

            card(material: "Bar")
                .background(.bar, in: cardShape)
        } header: {
            sectionHeader(title: "Standard Materials")
        }
    }

    private var liquidGlassSection: some View {
        Section {
            card(material: "Regular Glass")
                .glassEffect(.regular, in: cardShape)

            card(material: "Clear Glass")
                .glassEffect(.clear, in: cardShape)
        } header: {
            sectionHeader(title: "Liquid Glass")
        }
    }

    private var semanticMaterialsSection: some View {
        Section {
            card(material: "Background")
                .background(.background, in: cardShape)

            card(material: "Fill")
                .background(.fill, in: cardShape)
        } header: {
            sectionHeader(title: "Semantic Materials")
        }
    }

    @ViewBuilder
    var background: some View {
        switch variant {
        case .photoBackground:
            Image(.bali)
                .blur(radius: 6)
        case .gradientBackground:
            customGradient
                .ignoresSafeArea()
                .opacity(0.5)
        case .solidBackground:
            selectedColor
                .ignoresSafeArea()
                .opacity(0.5)
        }
    }
    
    func sectionHeader(title: String) -> some View {
        Text(title)
            .font(.caption)
            .foregroundStyle(.secondary)
            .textCase(.uppercase)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.bar)
            .padding(.horizontal, -16)
            .overlay(alignment: .top) {
                Divider()
                    .padding(.horizontal, -16)
            }
    }
    
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Toggle("Dark Mode", systemImage: "moon.fill", isOn: $darkModeOn)
        }
        if variant == .solidBackground {
            ToolbarItem(placement: .primaryAction) {
                Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                    self.selectedColor = Materials.getRandomColor()
                }
            }
        }
    }

    func badge(_ label: String) -> some View {
        VStack {
            Text(label)
                .textCase(.uppercase)
                .bold()
                .font(.caption2)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(.fill.secondary, in: .containerRelative)
                .multilineTextAlignment(.center)
        }
        .padding()
    }

    func card(material: String) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Today's Flight")
                    .font(.body)
                    .foregroundStyle(.primary)
                Spacer()
                Label("18 Hrs", systemImage: "clock")
                    .font(.caption)
                    .bold()
                    .textCase(.uppercase)
                    .foregroundStyle(.tint)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 6)
                    .background(.tint.quaternary, in: .capsule)
            }
            HStack {
                Text("DPS")
                    .bold()
                    .foregroundStyle(.tint)

                Gauge(value: 0.7) { }
                    .gaugeStyle(.accessoryLinearCapacity)

                Text("SFO")
                    .bold()
                    .foregroundStyle(.tint)
            }
            HStack {
                Label("In-flight Wifi", systemImage: "wifi")
                    .font(.caption)
                    .textCase(.uppercase)
                    .bold()
                    .padding(.vertical, 6)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .overlay(alignment: .bottomTrailing) {
            badge(material)
        }
    }
}

#Preview("Photo Background") {
    Materials(variant: .photoBackground)
}

#Preview("Gradient Background") {
    Materials(variant: .gradientBackground)
}

#Preview("Solid Background") {
    Materials(variant: .solidBackground)
}
