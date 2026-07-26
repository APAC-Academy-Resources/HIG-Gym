//
//  DemoPickerView.swift
//  HIG Camp
//

import SwiftUI

/// A three-segment picker of mail-style filters.
///
/// Carries no style of its own — apply `.pickerStyle` at the call site, which
/// is the point when demoing picker styles.
struct DemoPickerView: View {
    /// The selected tag: 0 = All, 1 = Unread, 2 = Flagged.
    @Binding var selectedSegment: Int

    var body: some View {
        Picker("View", selection: $selectedSegment) {
            Text("All").tag(0)
            Text("Unread").tag(1)
            Text("Flagged").tag(2)
        }
    }
}

#Preview {
    DemoPickerView(selectedSegment: .constant(1))
        .pickerStyle(.segmented)
        .padding()
}
