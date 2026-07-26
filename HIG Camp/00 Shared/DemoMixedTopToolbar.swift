//
//  DemoMixedTopToolbar.swift
//  HIG Camp
//

import SwiftUI

/// A profile avatar leading, three actions trailing with a `ToolbarSpacer`
/// splitting them into two clusters.
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

    // ponytail: near-duplicate of ToolbarItemsDemo.profileImage(size:) — that
    // one is a bare Image, this one wraps it in a Button. Extract a shared
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
