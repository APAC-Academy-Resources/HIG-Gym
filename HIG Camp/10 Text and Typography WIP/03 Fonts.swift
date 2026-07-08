//
//  03 Fonts.swift
//  HIG Camp
//
//  Created by George Ananda on 07/07/26.
//

import SwiftUI

struct Fonts: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Fonts & type treatment",
        description: "The system font ships four designs and the full weight range, plus width variants and monospaced digits. Layer visual treatment on top: gradient fills, kerning/tracking, and baseline offset.",
        systemImage: "character.cursor.ibeam"
    )

    // MARK: - Properties
    @State private var darkModeOn = false
    @State private var tint = Fonts.getRandomColor()
    @State private var weight: WeightOption = .regular
    @State private var design: DesignOption = .default
    @State private var width: WidthOption = .standard
    @State private var isItalic = false
    @State private var tracking = 0.0
    @State private var baselineOffset = 0.0

    static func getRandomColor() -> Color {
        Color(hue: .random(in: 0...1), saturation: .random(in: 0.4...0.8), brightness: .random(in: 0.6...0.8))
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    infoCard

                    section("Weight, design & width") {
                        Text("Typography")
                            .font(.system(.largeTitle, design: design.design))
                            .fontWeight(weight.weight)
                            .fontWidth(width.width)
                            .italic(isItalic)
                            .frame(maxWidth: .infinity)
                        Picker("Weight", selection: $weight) {
                            ForEach(WeightOption.allCases) { Text($0.label).tag($0) }
                        }
                        Picker("Design", selection: $design) {
                            ForEach(DesignOption.allCases) { Text($0.label).tag($0) }
                        }
                        Picker("Width", selection: $width) {
                            ForEach(WidthOption.allCases) { Text($0.label).tag($0) }
                        }
                        Toggle("Italic", isOn: $isItalic)
                        caption("`.font(.system(_:design:))` picks the design; `.fontWeight` and `.fontWidth` refine it independently of the text style.")
                    }

                    section("Monospaced digits") {
                        Text("00:00:07.42")
                            .font(.title2)
                            .monospacedDigit()
                        caption("`.monospacedDigit()` keeps numbers from shifting as they change — ideal for timers and counters.")
                    }

                    section("Gradient fill") {
                        Text("Gradient")
                            .font(.system(size: 56, weight: .black, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(colors: [tint, tint.mix(with: .white, by: 0.6)],
                                               startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .frame(maxWidth: .infinity)
                        caption("`foregroundStyle` accepts any `ShapeStyle`, so gradients paint glyphs directly.")
                    }

                    section("Tracking & baseline") {
                        Text("SPACED")
                            .font(.title.weight(.semibold))
                            .tracking(tracking)
                            .frame(maxWidth: .infinity)
                        LabeledContent("Tracking") {
                            Text(tracking, format: .number.precision(.fractionLength(1))).monospacedDigit()
                        }
                        Slider(value: $tracking, in: -2...20)

                        (
                            Text("E = mc")
                            + Text("2").baselineOffset(baselineOffset).font(.footnote)
                        )
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        LabeledContent("Baseline offset") {
                            Text(baselineOffset, format: .number.precision(.fractionLength(0))).monospacedDigit()
                        }
                        Slider(value: $baselineOffset, in: 0...16)
                        caption("`.tracking` spaces every character; `.baselineOffset` raises a run for superscripts and the like.")
                    }
                }
                .padding(.vertical)
            }
            .contentMargins(16)
            .navigationTitle("Fonts")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar { toolbar }
            .animation(.easeInOut, value: tint)
            .background(.tint.opacity(0.5))
        }
        .tint(tint)
        .preferredColorScheme(darkModeOn ? .dark : .light)
    }

    // MARK: - View Components
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = Fonts.getRandomColor()
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Toggle("Dark Mode", systemImage: "moon.fill", isOn: $darkModeOn)
        }
    }

    func caption(_ markdown: LocalizedStringKey) -> some View {
        Text(markdown)
            .font(.caption)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    func section(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .textCase(.uppercase)
                .font(.caption)
                .bold()
                .foregroundStyle(.secondary)
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    Fonts()
}

// MARK: - Variant Pickers
enum WeightOption: String, CaseIterable, Identifiable {
    case ultraLight, light, regular, medium, semibold, bold, heavy, black
    var id: Self { self }
    var label: String { rawValue.capitalized }
    var weight: Font.Weight {
        switch self {
        case .ultraLight: .ultraLight
        case .light: .light
        case .regular: .regular
        case .medium: .medium
        case .semibold: .semibold
        case .bold: .bold
        case .heavy: .heavy
        case .black: .black
        }
    }
}

enum DesignOption: String, CaseIterable, Identifiable {
    case `default`, serif, monospaced, rounded
    var id: Self { self }
    var label: String { rawValue.capitalized }
    var design: Font.Design {
        switch self {
        case .default: .default
        case .serif: .serif
        case .monospaced: .monospaced
        case .rounded: .rounded
        }
    }
}

enum WidthOption: String, CaseIterable, Identifiable {
    case compressed, condensed, standard, expanded
    var id: Self { self }
    var label: String { rawValue.capitalized }
    var width: Font.Width {
        switch self {
        case .compressed: .compressed
        case .condensed: .condensed
        case .standard: .standard
        case .expanded: .expanded
        }
    }
}
