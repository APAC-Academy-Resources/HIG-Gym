//
//  01 Symbol Gallery.swift
//  HIG Camp
//

import SwiftUI

struct SymbolGalleryDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "SF Symbols",
        description: "Symbols scale with text, respect font weight and Dynamic Type. Prefer them over custom icons.",
        systemImage: "square.grid.2x2"
    )

    // MARK: - State
    @State private var wifiStrength: Double = 0.66

    let weights: [(String, Font.Weight)] = [
        ("Ultra Light", .ultraLight),
        ("Thin", .thin),
        ("Regular", .regular),
        ("Semibold", .semibold),
        ("Bold", .bold),
        ("Black", .black),
    ]

    private let variableColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    // MARK: - Body
    var body: some View {
        DemoPage("Symbol Gallery", info: infoCard, infoPlacement: .pinned) { _ in
            weightsSection
            variableValueSection
        }
    }

    // MARK: - View Components
    private var weightsSection: some View {
        DemoSection("Font Weights") {
            HStack(alignment: .top) {
                ForEach(weights, id: \.0) { name, weight in
                    VStack(spacing: 6) {
                        Image(systemName: "line.diagonal.arrow")
                            .font(.title2)
                            .fontWeight(weight)
                            .foregroundStyle(.tint)
                        Text(name)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            Divider()
            HStack(alignment: .top) {
                ForEach(weights, id: \.0) { name, weight in
                    VStack(spacing: 6) {
                        Image(systemName: "person.crop.circle")
                            .font(.title2)
                            .fontWeight(weight)
                            .foregroundStyle(.tint)
                        Text(name)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            caption("`.fontWeight(_:)` on an `Image` picks the matching symbol weight, so icons track the text beside them.")
        }
    }

    private var variableValueSection: some View {
        DemoSection("Variable Value") {
            LazyVGrid(columns: variableColumns, spacing: 20) {
                Image(systemName: "wifi", variableValue: wifiStrength)
                Image(systemName: "speaker.wave.3.fill", variableValue: wifiStrength)
                Image(systemName: "dot.radiowaves.left.and.right", variableValue: wifiStrength)
                Image(systemName: "chart.bar.fill", variableValue: wifiStrength)
                Image(systemName: "waveform", variableValue: wifiStrength)
                Image(systemName: "rainbow", variableValue: wifiStrength)
                    .symbolRenderingMode(.multicolor)
                Image(systemName: "heart", variableValue: wifiStrength)
                    .foregroundStyle(.red)
                Image(systemName: "figure.outdoor.cycle.circle", variableValue: wifiStrength)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.tint, .red)
                Image(systemName: "thermometer.high", variableValue: wifiStrength)
                    .foregroundStyle(.red, .tint.secondary)
            }
            .symbolVariableValueMode(.draw)
            .font(.title)
            .foregroundStyle(.tint)
            Slider(value: $wifiStrength)
            caption("`Image(systemName:variableValue:)` fills a symbol's layers by a 0...1 value; `.symbolVariableValueMode(.draw)` traces them instead of switching them on.")
        }
    }
}

#Preview {
    SymbolGalleryDemo()
}
