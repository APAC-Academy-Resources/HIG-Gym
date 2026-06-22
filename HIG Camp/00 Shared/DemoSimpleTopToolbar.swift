//
//  DemoSimpleTopToolbar.swift
//  HIG Camp
//
//  Created by George Ananda on 20/06/26.
//
import SwiftUI

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
