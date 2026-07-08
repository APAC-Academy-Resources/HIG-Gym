//
//  02 Text Formatting.swift
//  HIG Camp
//
//  Created by George Ananda on 07/07/26.
//

import SwiftUI
import AVFoundation

struct TextFormatting: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Format styles & naming",
        description: "Text can format raw values and person names without manual string interpolation.",
        systemImage: "textformat.123"
    )

    // MARK: - Properties
    @State private var darkModeOn = false
    @State private var tint = TextFormatting.getRandomColor()
    @State private var displayedLocale: NameLocaleOption = .enUS
    private let speechSynthesizer = AVSpeechSynthesizer()

    private let nameStyles: [(String, PersonNameComponents.FormatStyle.Style)] = [
        ("Short", .short), ("Medium", .medium), ("Long", .long), ("Abbreviated", .abbreviated)
    ]
    private let sampleName = PersonNameComponents(
        namePrefix: "Dr.",
        givenName: "Doyeong",
        familyName: "Yeom",
        nickname: "Nathan"
    )
    // Native script goes straight in the component strings — FormatStyle still orders per locale.
    private let hangulName: PersonNameComponents = {
        var name = PersonNameComponents(givenName: "도영", familyName: "염")
        name.phoneticRepresentation = PersonNameComponents(givenName: "Doyeong", familyName: "Yeom")
        return name
    }()

    static func getRandomColor() -> Color {
        Color(hue: .random(in: 0...1), saturation: .random(in: 0.4...0.8), brightness: .random(in: 0.6...0.8))
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    infoCard

                    section("Format styles (units)") {
                        Grid(alignment: .leading, verticalSpacing: 12) {
                            formatRow("Number – 1234.5", Text(1234.5, format: .number))
                            Divider()
                            formatRow("Currency – 29.99", Text(29.99, format: .currency(code: "USD")))
                            Divider()
                            formatRow("Percent – 0.87", Text(0.87, format: .percent))
                            Divider()
                            formatRow("Distance – 5", Text(Measurement(value: 5, unit: UnitLength.kilometers), format: .measurement(width: .abbreviated)))
                            Divider()
                            formatRow("Byte count – 1500000", Text(1_500_000, format: .byteCount(style: .file)))
                            Divider()
                            formatRow("Date", Text(sampleDate, format: .dateTime.day().month().year()))
                            Divider()
                            formatRow("Date – Two Digits", Text(sampleDate, format: .dateTime.day().month(.twoDigits).year(.twoDigits)))
                        }
                        caption("`Text(_, format:)` turns raw values into localized, unit-aware strings — no manual string interpolation.")
                    }

                    section("Naming") {
                        Picker("Locale", selection: $displayedLocale) {
                            ForEach(NameLocaleOption.allCases) { Text($0.label).tag($0) }
                        }
                        .pickerStyle(.segmented)

                        Text("Swift can display Doyeong Yeom in different configurations")
                            .font(.caption).bold()
                            .foregroundStyle(.secondary)
                        ForEach(nameStyles, id: \.0) {
                            label,
                            style in
                            LabeledContent(label) {
                                Text(
                                    sampleName
                                        .formatted(
                                            .name(style: style)
                                            .locale(displayedLocale.locale)
                                        )
                                )
                            }
                        }

                        Divider()

                        LabeledContent("Native script — Hangul") {
                            Text(hangulName.formatted(.name(style: .long).locale(displayedLocale.locale)))
                                .accessibilityLabel(
                                    hangulName.phoneticRepresentation.map {
                                        $0.formatted(.name(style: .long).locale(displayedLocale.locale))
                                    } ?? ""
                                )
                        }
                        
                        Button("Play Korean pronunciation", systemImage: "speaker.wave.2.fill") {
                            speak(hangulName.formatted(.name(style: .long).locale(Locale(identifier: "ko_KR"))),
                                  language: "ko-KR")
                        }
                        
                        if let phonetic = hangulName.phoneticRepresentation {
                            LabeledContent("Phonetic (romanized)") {
                                Text(phonetic.formatted(.name(style: .long).locale(Locale(identifier: "en_US"))))
                            }
                        }
                        
                        if let phonetic = hangulName.phoneticRepresentation {
                            Button("Play romanized (en-US voice)", systemImage: "speaker.wave.2") {
                                speak(phonetic.formatted(.name(style: .long).locale(Locale(identifier: "en_US"))),
                                      language: "en-US")
                            }
                        }

                        caption("Use `AccessibilityLabel` to determine what VoiceOver reads. Hangul will be read in Korean accent, Phonetic will be read in English accent")
                    }
                }
                .padding(.vertical)
            }
            .contentMargins(16)
            .navigationTitle("Text Formatting")
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
                tint = TextFormatting.getRandomColor()
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Toggle("Dark Mode", systemImage: "moon.fill", isOn: $darkModeOn)
        }
    }

    func formatRow(_ title: String, _ value: Text) -> some View {
        GridRow {
            Text(title).foregroundStyle(.secondary)
            value.gridColumnAlignment(.trailing).frame(maxWidth: .infinity, alignment: .trailing)
        }
    }

    func speak(_ text: String, language: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        speechSynthesizer.speak(utterance)
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
    TextFormatting()
}

// MARK: - Variant Pickers
enum NameLocaleOption: String, CaseIterable, Identifiable {
    case enUS, koKR
    var id: Self { self }
    var label: String {
        switch self {
        case .enUS: "en_US"
        case .koKR: "ko_KR"
        }
    }
    var locale: Locale { Locale(identifier: label) }
}
