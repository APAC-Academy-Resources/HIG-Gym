//
//  VibrancyView.swift
//  HIG Gym
//
//  Created by George Ananda on 18/06/26.
//

import SwiftUI

enum TitleModeOption: String, CaseIterable, Identifiable {
    case automatic, inline, inlineLarge, large
    var id: Self { self }

    var label: String {
        switch self {
        case .automatic: "Automatic"
        case .inline: "Inline"
        case .inlineLarge: "Inline Large"
        case .large: "Large"
        }
    }

    var displayMode: ToolbarTitleDisplayMode {
        switch self {
        case .automatic: .automatic
        case .inline: .inline
        case .inlineLarge: .inlineLarge
        case .large: .large
        }
    }
}

struct SampleInterface: View {
    @State var pickerColor: Color = .red
    @State var sheetOpen: Bool = true
    @State var navigationTitle: String = "Demo"
    @State var titleMode: TitleModeOption = .inlineLarge

    var sheet: some View {
        NavigationStack {
            Form {
                LabeledContent("Navigation Title") {
                    TextField("Demo", text: $navigationTitle)
                        .multilineTextAlignment(.trailing)
                }
                Picker("Title Mode", selection: $titleMode) {
                    ForEach(TitleModeOption.allCases) { mode in
                        Text(mode.label).tag(mode)
                    }
                }
                ColorPicker("Tint Color", selection: $pickerColor)
            }
            .presentationDetents([.height(200)])
            .presentationBackgroundInteraction(.enabled)
            .interactiveDismissDisabled()
            .navigationTitle("Configure View")
            .toolbarTitleDisplayMode(.inline)
        }
    }

    var body: some View {
        NavigationStack {
            DemoScrollView(count: 24, tint: pickerColor, scrollResetToken: titleMode)
                .navigationTitle(navigationTitle)
                .toolbarTitleDisplayMode(titleMode.displayMode)
                .sheet(isPresented: $sheetOpen) {
                    sheet
                }
        }
        .tint(pickerColor)
    }
}

#Preview {
    SampleInterface()
}
