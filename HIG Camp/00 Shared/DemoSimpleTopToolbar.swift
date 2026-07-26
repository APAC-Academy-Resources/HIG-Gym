//
//  DemoSimpleTopToolbar.swift
//  HIG Camp
//

import SwiftUI

/// Undo/redo on the leading side, a prominent Add on the trailing side —
/// the most common top-toolbar arrangement.
struct DemoSimpleTopToolbar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarLeading) {
            Button("Undo", systemImage: "arrow.uturn.backward") { }
            Button("Redo", systemImage: "arrow.uturn.forward") { }
        }
        ToolbarItem(placement: .primaryAction) {
            Button("Add", systemImage: "plus") { }
                .buttonStyle(.borderedProminent)
        }
    }
}
