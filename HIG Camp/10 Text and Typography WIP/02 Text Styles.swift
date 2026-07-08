//
//  02 Text Styles.swift
//  HIG Camp
//
//  Created by George Ananda on 07/07/26.
//

import SwiftUI

struct TextStyles: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Semantic text styles",
        description: "Prefer the semantic text-style ramp (.largeTitle → .caption2) over hard-coded point sizes — every style scales with Dynamic Type. You can also compose styled runs by adding Text values, or feed Text Markdown and AttributedString.",
        systemImage: "textformat.size"
    )

    // MARK: - Properties
    @State private var darkModeOn = false
    @State private var tint = TextStyles.getRandomColor()
    @State private var applyBold = false
    @State private var applyItalic = false
    @State private var upperCased = false

    static func getRandomColor() -> Color {
        Color(hue: .random(in: 0...1), saturation: .random(in: 0.4...0.8), brightness: .random(in: 0.6...0.8))
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    infoCard

                    section("The style ramp") {
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

                    section("Concatenation") {
                        (
                            Text("HIG ")
                                .font(.title2).fontWeight(.black).foregroundStyle(.tint)
                            + Text("Camp")
                                .font(.title2).fontWeight(.light).italic()
                            + Text("  demo")
                                .font(.caption).foregroundStyle(.secondary)
                        )
                        caption("Adding `Text` values with `+` builds one run with mixed weight, style, and color — laid out as a single line of type.")
                    }

                    section("Markdown") {
                        Text("Text renders inline **bold**, _italic_, `code`, and [links](https://developer.apple.com) from Markdown automatically.")
                        caption("A `String` literal passed to `Text` is parsed as Markdown at compile time.")
                    }

                    section("AttributedString") {
                        Text(attributed)
                        caption("Build an `AttributedString` for styled runs computed at runtime.")
                    }
                }
                .padding(.vertical)
            }
            .contentMargins(16)
            .navigationTitle("Text Styles")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar { toolbar }
            .animation(.easeInOut, value: tint)
            .background(.tint.opacity(0.5))
        }
        .tint(tint)
        .preferredColorScheme(darkModeOn ? .dark : .light)
    }

    // MARK: - View Components
    private var attributed: AttributedString {
        let string = AttributedString("Runtime-styled ")
        var accent = AttributedString("accented")
        accent.foregroundColor = .white
        accent.backgroundColor = tint
        accent.font = .body.bold()
        var trailing = AttributedString(" run.")
        trailing.foregroundColor = .secondary
        return string + accent + trailing
    }

    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = TextStyles.getRandomColor()
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
    TextStyles()
}

// MARK: - Text Style Ramp
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
