//
//  03 Text Styles.swift
//  HIG Camp
//

import SwiftUI

struct TextStylesDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Semantic text styles",
        description: "Prefer the semantic text-style ramp (.largeTitle → .caption2) over hard-coded point sizes — every style scales with Dynamic Type. You can also compose styled runs by adding Text values, or feed Text Markdown and AttributedString.",
        systemImage: "textformat.size"
    )

    // MARK: - State
    @State private var applyBold = false
    @State private var applyItalic = false
    @State private var upperCased = false

    /// Composed at runtime so the accented run can pick up the live tint.
    private func attributed(accent tint: Color) -> AttributedString {
        let string = AttributedString("Runtime-styled ")
        var accent = AttributedString("accented")
        accent.foregroundColor = .white
        accent.backgroundColor = tint
        accent.font = .body.bold()
        var trailing = AttributedString(" run.")
        trailing.foregroundColor = .secondary
        return string + accent + trailing
    }

    // MARK: - Body
    var body: some View {
        DemoPage("Text Styles", info: infoCard) { tint in
            DemoSection("The style ramp") {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(TextStyleRamp.allCases) { style in
                        Text(style.label)
                            .font(.system(style.textStyle))
                            .bold(applyBold)
                            .italic(applyItalic)
                            .textCase(upperCased ? .uppercase : nil)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Toggle("Bold", isOn: $applyBold)
                Toggle("Italic", isOn: $applyItalic)
                Toggle("Uppercase", isOn: $upperCased)
                caption("`Font.TextStyle` cases map to Dynamic Type sizes. `.font(.system(_:))` and modifiers like `.bold()`/`.italic()`/`.textCase()` layer on top.")
            }

            DemoSection("Concatenation") {
                (
                    Text("HIG ")
                        .font(.title2).fontWeight(.black).foregroundStyle(.tint)
                    + Text("Gym")
                        .font(.title2).fontWeight(.light).italic()
                    + Text("  demo")
                        .font(.caption).foregroundStyle(.secondary)
                )
                caption("Adding `Text` values with `+` builds one run with mixed weight, style, and color — laid out as a single line of type.")
            }

            DemoSection("Markdown") {
                Text("Text renders inline **bold**, _italic_, `code`, and [links](https://developer.apple.com) from Markdown automatically.")
                caption("A `String` literal passed to `Text` is parsed as Markdown at compile time.")
            }

            DemoSection("AttributedString") {
                Text(attributed(accent: tint))
                caption("Build an `AttributedString` for styled runs computed at runtime.")
            }
        }
    }
}

// MARK: - Options

enum TextStyleRamp: String, CaseIterable, Identifiable {
    case largeTitle, title, title2, title3, headline, subheadline, body, callout, footnote, caption, caption2

    var id: Self { self }

    var textStyle: Font.TextStyle {
        switch self {
        case .largeTitle: .largeTitle
        case .title: .title
        case .title2: .title2
        case .title3: .title3
        case .headline: .headline
        case .subheadline: .subheadline
        case .body: .body
        case .callout: .callout
        case .footnote: .footnote
        case .caption: .caption
        case .caption2: .caption2
        }
    }

    var label: String {
        switch self {
        case .largeTitle: "Large Title"
        case .title: "Title"
        case .title2: "Title 2"
        case .title3: "Title 3"
        case .headline: "Headline"
        case .subheadline: "Subheadline"
        case .body: "Body"
        case .callout: "Callout"
        case .footnote: "Footnote"
        case .caption: "Caption"
        case .caption2: "Caption 2"
        }
    }
}

#Preview {
    TextStylesDemo()
}
