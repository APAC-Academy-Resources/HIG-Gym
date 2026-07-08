//
//  SwiftUIView.swift
//  HIG Camp
//
//  Created by George Ananda on 30/06/26.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        NavigationStack {
            Text("Hello")
                .navigationTitle("Bali")
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Add", systemImage: "plus", role: .confirm) {
                        }
                        .tint(.brown)
                    }
                }
        }
    }
}

#Preview {
    SwiftUIView()
}
