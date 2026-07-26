//
//  DemoMenuView.swift
//  HIG Camp
//

import SwiftUI

/// A menu exercising every kind of item a `Menu` can hold: a `ControlGroup`
/// row, a submenu, an inline `Picker`, plain buttons and a destructive one.
///
/// Shared by the menu, toolbar and context-menu demos.
struct DemoMenuView: View {
    @State private var choice = 1

    var body: some View {
        Menu {
            ControlGroup {
                Button {
                } label: {
                    Label("Draw", systemImage: "scribble")
                }
                Button {
                } label: {
                    Label("Profile", systemImage: "person")
                }
                Button {
                } label: {
                    Label("Map", systemImage: "map")
                }
            }
            Divider()
            
            Menu {
                Button {
                } label: {
                    Label("Third", systemImage: "3.circle")
                }

                Button {
                } label: {
                    Label("Second", systemImage: "2.circle")
                }
                
                Button {
                } label: {
                    Label("First", systemImage: "1.circle")
                }
            } label: {
                Text("Submenu")
            }
            
            Divider()
            
            Picker("Choice", selection: $choice) {
                Label("Third", systemImage: "3.circle")
                    .tag(3)

                Label("Second", systemImage: "2.circle")
                    .tag(2)

                Label("First", systemImage: "1.circle")
                    .tag(1)
            }
            Divider()
            Button {
            } label: {
                Label("Add", systemImage: "plus")
            }
            Button {
            } label: {
                Label("Multiply", systemImage: "multiply")
            }
            Divider()
            Button(role: .destructive) {
            } label: {
                Label("Delete", systemImage: "trash")
            }
        } label: {
            Text("Menu")
        }
    }
}

#Preview {
    DemoMenuView()
}
