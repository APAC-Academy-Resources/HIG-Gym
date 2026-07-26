//
//  DemoRowView.swift
//  HIG Camp
//

import SwiftUI

/// One placeholder row, used by ``DemoScrollView`` and ``DemoSearchView``.
struct DemoRowView: View {
    /// The row's primary text.
    let label: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .foregroundStyle(.primary)
                .font(.title3)
            HStack {
                Text("Secondary Info")
                    .foregroundStyle(.secondary)
                Spacer()
            }
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    DemoRowView(label: "Item 1")
        .padding()
        .background(.tint.secondary)
}
