//
//  02 Vibrancy.swift
//  HIG Camp
//
//  Created by George Ananda on 19/06/26.
//

import SwiftUI

struct Vibrancy: View {
    // MARK: - Info Card
    let infoCard =
        DemoInfoCard(title: "Hierarchical Style Foreground", description: "Applying a hierarchical style (primary, secondary, etc) to an element's foreground style when it has a system material background will trigger vibrancy. Try changing the color of the background using the toolbar button in the top right corner.", systemImage: "lightspectrum.horizontal")

    // MARK: - Properties & Methods
    static let customColor: Color = Color(hue: .random(in: 0...1), saturation: 1, brightness: 0.5)

    @State var selectedColor: Color = customColor
    @State var darkModeOn: Bool = false

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    infoCard
                        .tint(selectedColor)

                    sampleCard("Regular Material")
                        .background(
                            .regularMaterial,
                            in: cardShape
                        )

                    sampleCard("Thick Material")
                        .background(
                            .thickMaterial,
                            in: cardShape
                        )

                    sampleCard("Ultra Thick Material")
                        .background(
                            .ultraThickMaterial,
                            in: cardShape
                        )

                    sampleCard("Window Background")
                        .background(
                            .windowBackground,
                            in: cardShape
                        )

                    sampleCard("Thin Material")
                        .background(
                            .thinMaterial,
                            in: cardShape
                        )

                    sampleCard("Ultra Thin Material")
                        .background(
                            .ultraThinMaterial,
                            in: cardShape
                        )
                }
                .padding(.bottom, 64)
            }
            .contentMargins(16)
            .frame(maxWidth: .infinity)
            .background(selectedColor.secondary)
            .animation(.easeInOut, value: selectedColor)
            .navigationTitle("Vibrancy")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                        self.selectedColor = Color(hue: .random(in: 0...1), saturation: .random(in: 0.2...0.8), brightness: .random(in: 0.5...0.8)
                        )
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Toggle("Dark Mode", systemImage: "moon.fill", isOn: $darkModeOn)
                        .tint(.primary)
                }
            }
        }
        .preferredColorScheme(darkModeOn ? .dark : .light)
    }

    // MARK: - View Components
    var cardShape: some Shape = RoundedRectangle(cornerRadius: 24)

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

    func sampleCard(_ background: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Title Primary")
                        .font(.title)
                        .fontDesign(.serif)
                        .foregroundStyle(.primary)
                    Label("Caption Secondary Bold", systemImage: "checkmark.circle.fill")
                        .textCase(.uppercase)
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "book.pages.fill")
                    .font(.title3)
                    .padding(10)
                    .foregroundStyle(.secondary)
                    .background(.fill.secondary, in: .circle)
            }

            Spacer()

            Text("Body Secondary. Every element in this card does not specify any specific colors, instead it uses the system's hierarchical foreground styles (this body text uses the 'secondary' style). The result is the components adapt to the background. It dynamically samples the color behind the card's \(background) background.")
                .font(.body)
                .foregroundStyle(.secondary)

            Divider()

            Text("Body Tertiary. This effect is only triggered when you put a hierarchical foreground style in a material background, like this tertiary text on the card's \(background) background")
                .font(.body)
                .foregroundStyle(.tertiary)

            Divider()

            Text("What's up Quaternary")
                .font(.body)
                .foregroundStyle(.quaternary)
            Text("Yo Quinary here")
                .font(.body)
                .foregroundStyle(.quinary)
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .overlay(alignment: .bottomTrailing) {
            badge(background)
        }
    }
}

#Preview {
    Vibrancy()

}
