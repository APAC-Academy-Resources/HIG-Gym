//
//  01 Text Behaviours.swift
//  HIG Camp
//

import SwiftUI

struct TextBehavioursDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Text layout & formatting",
        description: "A single Text view has a lot of behaviour. Drag the controls to see each knob respond.",
        systemImage: "text.alignleft"
    )

    // MARK: - State
    @State private var lineLimit = 2
    @State private var reservesSpace = false
    @State private var truncation: TruncationOption = .tail
    @State private var minimumScaleFactor = 1.0
    @State private var allowsTightening = false
    @State private var alignment: AlignmentOption = .leading
    @State private var lineSpacing = 2.0

    private let sampleParagraph = "SwiftUI text automatically wraps, truncates, and scales to fit the space it is given. This paragraph is deliberately long so the line-limit, truncation, and scaling controls have something to act on."
    private let sampleLine = "supercalifragilisticexpialidocious/very/long/single/line/path/that/must/truncate.txt"

    // MARK: - Body
    var body: some View {
        DemoPage("Text Behaviours", info: infoCard) { _ in
            DemoSection("Line limit") {
                Text(sampleParagraph)
                    .lineLimit(lineLimit, reservesSpace: reservesSpace)
                Stepper("Line limit: \(lineLimit)", value: $lineLimit, in: 1...8)
                    .foregroundStyle(.secondary)
                Toggle("Reserves space", isOn: $reservesSpace)
                    .foregroundStyle(.secondary)
                caption("`lineLimit(_:reservesSpace:)` keeps room for the maximum number of lines even when the text is shorter.")
            }

            DemoSection("Truncation mode") {
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

            DemoSection("Scale to fit") {
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

            DemoSection("Alignment & spacing") {
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
                caption("`multilineTextAlignment` aligns wrapped lines; `lineSpacing` adds leading between them.")
            }

            DemoSection("Text selection") {
                Text("Press and hold to select and copy this text.")
                    .textSelection(.enabled)
                caption("`textSelection(.enabled)` makes otherwise static Text selectable and copyable.")
            }
        }
    }
}

// MARK: - Options

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

#Preview {
    TextBehavioursDemo()
}
