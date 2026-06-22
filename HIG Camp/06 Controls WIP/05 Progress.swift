//
//  05 Progress.swift
//  HIG Camp
//
//  Created by George Ananda on 21/06/26.
//

import SwiftUI

struct ProgressDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Progress indicators",
        description: "A ProgressView with a value shows determinate progress (linear or circular). Without a value it spins indefinitely. Drag the slider to drive the determinate examples.",
        systemImage: "progress.indicator"
    )

    // MARK: - Properties & Methods
    @State private var darkModeOn: Bool = false
    @State private var progress: Double = 0.4
    @State private var tint: Color = ProgressDemo.getRandomColor()

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

                    section("Drive Determinate Value") {
                        Slider(value: $progress)
                        Text(progress, format: .percent.precision(.fractionLength(0)))
                            .font(.title2)
                            .monospacedDigit()
                            .foregroundStyle(.tint)
                    }

                    section("Linear (Determinate)") {
                        ProgressView(value: progress)
                        ProgressView("Downloading", value: progress)
                    }

                    section("Circular (Determinate)") {
                        ProgressView(value: progress)
                            .progressViewStyle(.circular)
                    }

                    section("Indeterminate") {
                        ProgressView()
                        ProgressView("Loading…")
                    }
                }
                .padding(.vertical)
            }
            .contentMargins(16)
            .navigationTitle("Progress")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                toolbar
            }
            .animation(.easeInOut, value: tint)
            .background(.tint.secondary)
        }
        .tint(tint)
        .preferredColorScheme(darkModeOn ? .dark : .light)
    }

    // MARK: - View Components
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = ProgressDemo.getRandomColor()
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
    ProgressDemo()
}
