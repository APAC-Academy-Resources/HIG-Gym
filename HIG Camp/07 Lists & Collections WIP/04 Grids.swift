//
//  04 Grids.swift
//  HIG Camp
//
//  Created by George Ananda on 22/06/26.
//

import SwiftUI

struct Grids: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Grids",
        description: "LazyVGrid lays content out in columns defined by GridItem. Adaptive items fit as many as will go, fixed items pin a count, and flexible items share the remaining width.",
        systemImage: "square.grid.2x2"
    )

    // MARK: - Properties & Methods
    @State private var tint: Color = Grids.getRandomColor()

    let swatches = Array(1...12)

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
                VStack(spacing: 16) {
                    infoCard

                    section("Adaptive — minimum 72pt") {
                        LazyVGrid(
                            columns: [GridItem(.adaptive(minimum: 72), spacing: 12)],
                            spacing: 12
                        ) {
                            swatchCells
                        }
                    }

                    section("Fixed — 3 columns") {
                        LazyVGrid(
                            columns: Array(repeating: GridItem(.fixed(80), spacing: 12), count: 3),
                            spacing: 12
                        ) {
                            swatchCells
                        }
                    }

                    section("Flexible — 2 columns") {
                        LazyVGrid(
                            columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2),
                            spacing: 12
                        ) {
                            swatchCells
                        }
                    }
                }
            }
            .contentMargins(16)
            .navigationTitle("Grids")
            .toolbarTitleDisplayMode(.inlineLarge)
            .animation(.easeInOut, value: tint)
            .background(.tint.secondary)
        }
        .tint(tint)
    }

    // MARK: - View Components
    @ViewBuilder
    var swatchCells: some View {
        ForEach(swatches, id: \.self) { index in
            RoundedRectangle(cornerRadius: 12)
                .fill(.tint.opacity(Double(index) / 12))
                .frame(height: 72)
                .overlay {
                    Text("\(index)")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
        }
    }

    func section(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .textCase(.uppercase)
                .font(.caption)
                .bold()
                .foregroundStyle(.secondary)
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(.windowBackground, in: RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    Grids()
}
