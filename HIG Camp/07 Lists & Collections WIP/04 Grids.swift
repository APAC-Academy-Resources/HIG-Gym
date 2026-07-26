//
//  04 Grids.swift
//  HIG Camp
//

import SwiftUI

struct GridsDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Grids",
        description: "LazyVGrid lays content out in columns defined by GridItem. Adaptive items fit as many as will go, fixed items pin a count, and flexible items share the remaining width.",
        systemImage: "square.grid.2x2"
    )

    // MARK: - State
    private let swatches = Array(1...12)

    // MARK: - Body
    var body: some View {
        DemoPage("Grids", info: infoCard) { _ in
            DemoSection("Adaptive — minimum 72pt") {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 72), spacing: 12)],
                    spacing: 12
                ) {
                    swatchCells
                }
                caption("`GridItem(.adaptive(minimum:))` fits as many columns as the width allows.")
            }

            DemoSection("Fixed — 3 columns") {
                LazyVGrid(
                    columns: Array(repeating: GridItem(.fixed(80), spacing: 12), count: 3),
                    spacing: 12
                ) {
                    swatchCells
                }
                caption("`GridItem(.fixed(_:))` pins each column to an exact width.")
            }

            DemoSection("Flexible — 2 columns") {
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2),
                    spacing: 12
                ) {
                    swatchCells
                }
                caption("`GridItem(.flexible())` splits the available width evenly between the columns.")
            }
        }
    }

    // MARK: - View Components
    @ViewBuilder
    private var swatchCells: some View {
        ForEach(swatches, id: \.self) { index in
            RoundedRectangle(cornerRadius: 12)
                .fill(.tint.opacity(Double(index) / Double(swatches.count)))
                .frame(height: 72)
                .overlay {
                    Text("\(index)")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
        }
    }
}

#Preview {
    GridsDemo()
}
