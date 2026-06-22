//
//  03 Sliders.swift
//  HIG Camp
//
//  Created by George Ananda on 21/06/26.
//

import SwiftUI

struct Sliders: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Sliders",
        description: "Sliders pick a value from a continuous or stepped range. They can carry min/max labels and report when the user starts and stops dragging.",
        systemImage: "slider.horizontal.3"
    )

    // MARK: - Properties & Methods
    @State private var darkModeOn: Bool = false
    @State private var basic: Double = 0.5
    @State private var ranged: Double = 50
    @State private var stepped: Double = 4
    @State private var isEditing: Bool = false
    @State private var tint: Color = Sliders.getRandomColor()

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

                    section("Basic (0–1)") {
                        Slider(value: $basic)
                        Text(basic, format: .number.precision(.fractionLength(2)))
                            .font(.title2)
                            .monospacedDigit()
                            .foregroundStyle(.tint)
                    }

                    section("Range with Labels (0–100)") {
                        Slider(value: $ranged, in: 0...100) {
                            Text("Value")
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("100")
                        }
                        Text(ranged, format: .number.precision(.fractionLength(0)))
                            .font(.title2)
                            .monospacedDigit()
                            .foregroundStyle(.tint)
                    }

                    section("Stepped (0–10, step 1)") {
                        Slider(value: $stepped, in: 0...10, step: 1) { editing in
                            isEditing = editing
                        }
                        Label(
                            isEditing ? "Dragging" : "Idle",
                            systemImage: isEditing ? "hand.draw.fill" : "hand.raised.slash"
                        )
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical)
            }
            .contentMargins(16)
            .navigationTitle("Sliders")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                toolbar
            }
            .animation(.easeInOut, value: tint)
        }
        .tint(tint)
        .preferredColorScheme(darkModeOn ? .dark : .light)
    }

    // MARK: - View Components
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = Sliders.getRandomColor()
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Toggle("Dark Mode", systemImage: "moon.fill", isOn: $darkModeOn)
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
    Sliders()
}
