//
//  02 Toggles & Steppers.swift
//  HIG Camp
//
//  Created by George Ananda on 21/06/26.
//

import SwiftUI

struct TogglesAndSteppers: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Toggles & Steppers",
        description: "Toggles flip a boolean and adapt to their toggle style. Steppers increment a value within a range and step. Both pick up the current tint.",
        systemImage: "switch.2"
    )

    // MARK: - Properties & Methods
    @State private var darkModeOn: Bool = false
    @State private var switchOn: Bool = true
    @State private var buttonOn: Bool = false
    @State private var automaticOn: Bool = true
    @State private var quantity: Int = 1
    @State private var temperature: Int = 20
    @State private var tint: Color = TogglesAndSteppers.getRandomColor()

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

                    section("Toggle Styles") {
                        Toggle("Switch", isOn: $switchOn)
                            .toggleStyle(.switch)
                        Toggle("Button", systemImage: "star.fill", isOn: $buttonOn)
                            .toggleStyle(.button)
                        Toggle("Automatic", isOn: $automaticOn)
                            .toggleStyle(.automatic)
                    }

                    section("Stepper") {
                        Stepper("Quantity: \(quantity)", value: $quantity, in: 0...10)
                        Stepper(
                            "Temperature: \(temperature)°",
                            value: $temperature,
                            in: 16...30,
                            step: 2
                        )
                    }
                }
                .padding(.vertical)
            }
            .contentMargins(16)
            .navigationTitle("Toggles & Steppers")
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
                tint = TogglesAndSteppers.getRandomColor()
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
    TogglesAndSteppers()
}
