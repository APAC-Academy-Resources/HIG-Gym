//
//  04 Pickers.swift
//  HIG Camp
//

import SwiftUI

struct PickersDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Pickers & DatePicker",
        description: "A Picker presents a set of mutually exclusive options; its picker style decides the presentation — segmented, menu, wheel or inline. DatePicker is a specialized picker for dates.",
        systemImage: "checklist"
    )

    // MARK: - State
    @State private var segment: Int = 0
    @State private var menuSelection: Int = 0
    @State private var wheelSelection: Int = 0
    @State private var inlineSelection: Int = 0
    @State private var date: Date = .distantPast

    private let options = ["All", "Unread", "Flagged", "Drafts"]

    // MARK: - Body
    var body: some View {
        DemoPage("Pickers", info: infoCard) { _ in
            DemoSection("Segmented") {
                DemoPickerView(selectedSegment: $segment)
                    .pickerStyle(.segmented)
                caption("`.segmented` lays every option out at once — best for two to five short labels.")
            }

            DemoSection("Menu") {
                Picker("Filter", selection: $menuSelection) {
                    ForEach(options.indices, id: \.self) { index in
                        Text(options[index]).tag(index)
                    }
                }
                .pickerStyle(.menu)
                caption("`.menu` shows only the current choice and reveals the rest on tap, so it stays compact.")
            }

            DemoSection("Wheel") {
                Picker("Filter", selection: $wheelSelection) {
                    ForEach(options.indices, id: \.self) { index in
                        Text(options[index]).tag(index)
                    }
                }
                .pickerStyle(.wheel)
                caption("`.wheel` is a scrolling drum — it hides the picker's own label, so give it surrounding context.")
            }

            DemoSection("Inline") {
                Picker("Filter", selection: $inlineSelection) {
                    ForEach(options.indices, id: \.self) { index in
                        Text(options[index]).tag(index)
                    }
                }
                .pickerStyle(.inline)
                caption("`.inline` lists every option in place with a checkmark on the selection.")
            }

            DemoSection("DatePicker — Compact") {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.compact)
                caption("`displayedComponents:` chooses date, time or both; `.compact` opens a popover on tap.")
            }

            DemoSection("DatePicker — Graphical") {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                caption("`.graphical` renders the full calendar inline — both pickers share one `Date` binding.")
            }
        }
    }
}

#Preview {
    PickersDemo()
}
