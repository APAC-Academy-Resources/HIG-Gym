//
//  DemoTint.swift
//  HIG Camp
//

import SwiftUI

extension Color {
    /// A random mid-saturation hue.
    ///
    /// Demo pages re-roll this from the toolbar so you can check a component
    /// against an arbitrary tint rather than the one accent colour you happen
    /// to like. The saturation and brightness ranges are deliberately narrow —
    /// every result stays legible in both light and dark mode.
    static var demoRandom: Color {
        Color(
            hue: .random(in: 0...1),
            saturation: .random(in: 0.4...0.8),
            brightness: .random(in: 0.6...0.8)
        )
    }
}
