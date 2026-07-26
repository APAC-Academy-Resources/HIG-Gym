//
//  02 Rendering Modes.swift
//  HIG Camp
//

import SwiftUI

struct SymbolRenderingModesDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Rendering Modes",
        description: "Monochrome tints the whole symbol; hierarchical fades layers by depth; palette assigns your colours per layer; multicolor uses the symbol's own colours.",
        systemImage: "paintpalette"
    )

    // MARK: - State
    @State private var paletteColors: [Color] = SymbolRenderingModesDemo.randomPalette()

    /// Symbols with multiple layers / intrinsic colours worth showing across modes.
    private let symbols = [
        "cloud.sun.rain.fill",
        "person.crop.circle.badge.checkmark",
        "battery.75percent",
        "bell.badge.fill",
        "externaldrive.badge.plus",
    ]

    private static func randomPalette() -> [Color] {
        (0..<3).map { _ in
            Color(
                hue: .random(in: 0...1),
                saturation: .random(in: 0.5...0.9),
                brightness: .random(in: 0.6...0.9)
            )
        }
    }

    // MARK: - Body
    var body: some View {
        DemoPage(
            "Rendering Modes",
            info: infoCard,
            infoPlacement: .pinned,
            toolbar: {
                ToolbarItem(placement: .primaryAction) {
                    Button("Randomize Palette", systemImage: "paintpalette") {
                        paletteColors = Self.randomPalette()
                    }
                }
            }
        ) { _ in
            monochromeSection
            gradientSection(
                "Monochrome with gradient",
                mode: .monochrome,
                caption: "`.symbolColorRenderingMode(.gradient)` derives an axial gradient from the single fill."
            )
            modeSection(
                "Hierarchical",
                mode: .hierarchical,
                caption: "`.symbolRenderingMode(.hierarchical)` tints layers by depth from one colour."
            )
            gradientSection(
                "Hierarchical with gradient",
                mode: .hierarchical,
                caption: "Gradient and hierarchical compose — each depth level gets its own gradient."
            )
            paletteSection
            modeSection(
                "Multicolor",
                mode: .multicolor,
                caption: "`.symbolRenderingMode(.multicolor)` uses the symbol's own built-in colours and ignores the tint."
            )
        }
    }

    // MARK: - View Components
    private func modeSection(
        _ title: String,
        mode: SymbolRenderingMode,
        caption text: LocalizedStringKey
    ) -> some View {
        DemoSection(title) {
            symbolRow
                .symbolRenderingMode(mode)
                .foregroundStyle(.tint)
            caption(text)
        }
    }

    private var paletteSection: some View {
        DemoSection("Palette") {
            symbolRow
                .symbolRenderingMode(.palette)
                .foregroundStyle(
                    paletteColors[0],
                    paletteColors[1],
                    paletteColors[2]
                )
            symbolRow
                .symbolRenderingMode(.palette)
                .foregroundStyle(
                    .orange,
                    .red,
                    .gray
                )
            symbolRow
                .symbolRenderingMode(.palette)
                .foregroundStyle(
                    .mint,
                    .indigo,
                    .orange
                )
            caption("`.symbolRenderingMode(.palette)` maps each style you pass to `.foregroundStyle` onto one layer. Tap Randomize Palette to re-roll the top row.")
        }
        .animation(.easeInOut, value: paletteColors)
    }

    /// Monochrome fills every layer with the foreground style.
    /// `symbolColorRenderingMode(.flat)` opts out of any gradient treatment.
    private var monochromeSection: some View {
        DemoSection("Monochrome") {
            symbolRow
                .symbolColorRenderingMode(.flat)
                .symbolRenderingMode(.monochrome)
                .foregroundStyle(.tint)
            caption("`.symbolRenderingMode(.monochrome)` paints every layer with the same style.")
        }
    }

    private func gradientSection(
        _ title: String,
        mode: SymbolRenderingMode,
        caption text: LocalizedStringKey
    ) -> some View {
        DemoSection(title) {
            HStack(spacing: 20) {
                Image(systemName: "figure.run.circle.fill")
                Image(systemName: "airplane.ticket.fill")
                Image(systemName: "hand.raised.circle.fill")
            }
            .font(.system(size: 70))
            .foregroundStyle(.tint)
            .symbolColorRenderingMode(.gradient)
            .symbolRenderingMode(mode)
            caption(text)
        }
    }

    private var symbolRow: some View {
        HStack {
            ForEach(symbols, id: \.self) { name in
                Image(systemName: name)
                    .font(.system(size: 36))
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    SymbolRenderingModesDemo()
}
