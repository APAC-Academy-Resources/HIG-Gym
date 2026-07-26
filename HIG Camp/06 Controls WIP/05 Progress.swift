//
//  05 Progress.swift
//  HIG Camp
//

import SwiftUI

struct ProgressDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Progress indicators",
        description: "A ProgressView with a value shows determinate progress (linear or circular). Without a value it spins indefinitely. Drag the slider to drive the determinate examples.",
        systemImage: "progress.indicator"
    )

    // MARK: - State
    @State private var progress: Double = 0.4

    // MARK: - Body
    var body: some View {
        DemoPage("Progress", info: infoCard) { _ in
            DemoSection("Drive determinate value") {
                Slider(value: $progress)
                Text(progress, format: .percent.precision(.fractionLength(0)))
                    .font(.title2)
                    .monospacedDigit()
                    .foregroundStyle(.tint)
                caption("Everything below reads this one `Double`.")
            }

            DemoSection("Linear (determinate)") {
                ProgressView(value: progress)
                ProgressView("Downloading", value: progress)
                caption("`ProgressView(value:)` expects 0...1 unless you pass a `total:`.")
            }

            DemoSection("Indeterminate") {
                ProgressView()
                ProgressView("Loading…")
                caption("Omit `value:` when you can't know how long the work will take.")
            }
        }
    }
}

#Preview {
    ProgressDemo()
}
