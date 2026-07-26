//
//  03 Sliders.swift
//  HIG Camp
//

import SwiftUI

struct SlidersDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Sliders",
        description: "Sliders pick a value from a continuous or stepped range. They can carry min/max labels and report when the user starts and stops dragging.",
        systemImage: "slider.horizontal.3"
    )

    // MARK: - State
    @State private var basic: Double = 0.5
    @State private var ranged: Double = 50
    @State private var stepped: Double = 4
    @State private var isEditing: Bool = false

    // MARK: - Body
    var body: some View {
        DemoPage("Sliders", info: infoCard) { _ in
            DemoSection("Basic (0–1)") {
                Slider(value: $basic)
                Text(basic, format: .number.precision(.fractionLength(2)))
                    .font(.title2)
                    .monospacedDigit()
                    .foregroundStyle(.tint)
                caption("`Slider(value:)` with no range defaults to a continuous 0...1.")
            }

            DemoSection("Range with Labels (0–100)") {
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
                caption("`minimumValueLabel:` and `maximumValueLabel:` sit at the ends; the `label:` itself is used by VoiceOver.")
            }

            DemoSection("Stepped (0–10, step 1)") {
                Slider(value: $stepped, in: 0...10, step: 1) { editing in
                    isEditing = editing
                }
                .sliderThumbVisibility(.visible)
                Label(
                    isEditing ? "Dragging" : "Idle",
                    systemImage: isEditing ? "hand.draw.fill" : "hand.raised.slash"
                )
                .font(.caption)
                .foregroundStyle(.secondary)
                caption("`step:` snaps to discrete values and the `onEditingChanged` closure fires true on drag start, false on release.")
            }
        }
    }
}

#Preview {
    SlidersDemo()
}
