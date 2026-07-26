//
//  02 Toggles & Steppers.swift
//  HIG Camp
//

import SwiftUI

struct TogglesAndSteppersDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Toggles & Steppers",
        description: "Toggles flip a boolean and adapt to their toggle style. Steppers increment a value within a range and step. Both pick up the current tint.",
        systemImage: "switch.2"
    )

    // MARK: - State
    @State private var switchOn: Bool = true
    @State private var buttonOn: Bool = false
    @State private var automaticOn: Bool = true
    @State private var quantity: Int = 1
    @State private var temperature: Int = 20

    // MARK: - Body
    var body: some View {
        DemoPage("Toggles & Steppers", info: infoCard) { _ in
            DemoSection("Toggle Styles") {
                Divider()
                Toggle("Switch", isOn: $switchOn)
                    .toggleStyle(.switch)
                Divider()
                HStack {
                    Text("Button")
                    Spacer()
                    Toggle("Light", systemImage: "sun.max.fill", isOn: $buttonOn)
                        .toggleStyle(.button)
                        .labelStyle(.iconOnly)
                }
                Divider()
                Toggle("Automatic", isOn: $automaticOn)
                    .toggleStyle(.automatic)
                caption("`.toggleStyle(_:)` swaps the presentation without changing the `Bool` binding; `.automatic` lets the container decide.")
            }

            DemoSection("Stepper") {
                Stepper("Quantity: \(quantity)", value: $quantity, in: 0...10)
                Stepper(
                    "Temperature: \(temperature)°",
                    value: $temperature,
                    in: 16...30,
                    step: 2
                )
                caption("`in:` clamps the value and disables the arrow at each end; `step:` sets how much one tap moves it.")
            }
        }
    }
}

#Preview {
    TogglesAndSteppersDemo()
}
