//
//  DemoMixedTopToolbar.swift
//  HIG Camp
//
//  Created by George Ananda on 20/06/26.
//

import SwiftUI

struct DemoMixedTopToolbar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            profileImageButton()
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button("Search", systemImage: "sparkle.magnifyingglass") { }
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button("Pen", systemImage: "scribble") { }
        }
        ToolbarSpacer(placement: .topBarTrailing)
        ToolbarItem(placement: .topBarTrailing) {
            Button("Files", systemImage: "folder") { }
        }
    }

    // ponytail: duplicated from ToolbarItemsDemoView; extract a shared
    // ProfileImageButton view only if a 3rd caller appears.
    private func profileImageButton(size: CGFloat = 32) -> some View {
        Button { } label: {
            Image("g")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(.circle)
        }
        .accessibilityLabel("Profile")
    }
}
