//
//  01 Text Behaviours.swift
//  HIG Camp
//
//  Created by George Ananda on 07/07/26.
//

import SwiftUI

struct TextBehaviours: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Text layout & formatting",
        description: "A single Text view has a lot of behaviour. Drag the controls to see each knob respond.",
        systemImage: "text.alignleft"
    )

    // MARK: - Properties
    @State private var darkModeOn = false
    @State private var tint = TextBehaviours.getRandomColor()

    @State private var lineLimit = 2
    @State private var reservesSpace = false
    @State private var truncation: TruncationOption = .tail
    @State private var minimumScaleFactor = 1.0
    @State private var allowsTightening = false
    @State private var alignment: AlignmentOption = .leading
    @State private var lineSpacing = 2.0

    private let sampleParagraph = "SwiftUI text automatically wraps, truncates, and scales to fit the space it is given. This paragraph is deliberately long so the line-limit, truncation, and scaling controls have something to act on."
    private let sampleLine = "supercalifragilisticexpialidocious/very/long/single/line/path/that/must/truncate.txt"

    static func getRandomColor() -> Color {
        Color(hue: .random(in: 0...1), saturation: .random(in: 0.4...0.8), brightness: .random(in: 0.6...0.8))
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    infoCard

                    section("Line limit") {
                        Text(sampleParagraph)
                            .lineLimit(lineLimit, reservesSpace: reservesSpace)
                        Stepper("Line limit: \(lineLimit)", value: $lineLimit, in: 1...8)
                            .foregroundStyle(.secondary)
                        Toggle("Reserves space", isOn: $reservesSpace)
                            .foregroundStyle(.secondary)
                        caption("`lineLimit(_:reservesSpace:)` keeps room for the maximum number of lines even when the text is shorter.")
                    }

                    section("Truncation mode") {
                        Text(sampleLine)
                            .lineLimit(2)
                            .truncationMode(truncation.mode)
                        Picker("Truncation", selection: $truncation) {
                            ForEach(TruncationOption.allCases) { Text($0.label).tag($0) }
                        }
                        .pickerStyle(.segmented)
                        
                        Divider()
                        
                        Text("**Tail Truncation** Example")
                            .font(.largeTitle)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        
                        
                        Divider()
                        
                        Text("Example of **Head Truncation**")
                            .font(.largeTitle)
                            .lineLimit(1)
                            .truncationMode(.head)
                        
                        Divider()
                        
                        Text("**Truncation** in the **Middle**")
                            .font(.largeTitle)
                            .lineLimit(1)
                            .truncationMode(.middle)
                        
                        caption("`truncationMode` controls where the ellipsis lands when text overflows a single line.")
                    }

                    section("Scale to fit") {
                        Text(sampleLine)
                            .lineLimit(1)
                            .minimumScaleFactor(minimumScaleFactor)
                            .allowsTightening(allowsTightening)
                        LabeledContent("Min scale") {
                            Text(minimumScaleFactor, format: .percent.precision(.fractionLength(0)))
                                .monospacedDigit()
                        }
                        Slider(value: $minimumScaleFactor, in: 0.3...1.0)
                        Toggle("Allows tightening", isOn: $allowsTightening)
                        caption("`minimumScaleFactor` lets text shrink before truncating; `allowsTightening` reduces inter-character spacing first.")
                    }

                    section("Alignment & spacing") {
                        Text(sampleParagraph)
                            .multilineTextAlignment(alignment.textAlignment)
                            .lineSpacing(lineSpacing)
                            .frame(maxWidth: .infinity)
                        Picker("Alignment", selection: $alignment) {
                            ForEach(AlignmentOption.allCases) { Text($0.label).tag($0) }
                        }
                        .pickerStyle(.segmented)
                        LabeledContent("Line spacing") {
                            Text(lineSpacing, format: .number.precision(.fractionLength(0)))
                                .monospacedDigit()
                        }
                        Slider(value: $lineSpacing, in: 0...16)
                    }

                    section("Text selection") {
                        Text("Press and hold to select and copy this text.")
                            .textSelection(.enabled)
                        caption("`textSelection(.enabled)` makes otherwise static Text selectable and copyable.")
                    }
                }
                .padding(.vertical)
            }
            .contentMargins(16)
            .navigationTitle("Text Behaviours")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar { toolbar }
            .animation(.easeInOut, value: tint)
            .background(.tint.opacity(0.5))
        }
        .tint(tint)
        .preferredColorScheme(darkModeOn ? .dark : .light)
    }

    // A fixed reference date so the preview is deterministic (no `Date()` churn).
    private var sampleDate: Date { Date(timeIntervalSince1970: 1_780_000_000) }

    // MARK: - View Components
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = TextBehaviours.getRandomColor()
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
    TextBehaviours()
}

// MARK: - Variant Pickers
enum TruncationOption: String, CaseIterable, Identifiable {
    case head, middle, tail
    var id: Self { self }
    var label: String { rawValue.capitalized }
    var mode: Text.TruncationMode {
        switch self {
        case .head: .head
        case .middle: .middle
        case .tail: .tail
        }
    }
}

enum AlignmentOption: String, CaseIterable, Identifiable {
    case leading, center, trailing
    var id: Self { self }
    var label: String { rawValue.capitalized }
    var textAlignment: TextAlignment {
        switch self {
        case .leading: .leading
        case .center: .center
        case .trailing: .trailing
        }
    }
}
