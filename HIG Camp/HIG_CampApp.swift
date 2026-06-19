import SwiftUI

@main
struct HIG_CampApp: App {
    var body: some Scene {
        WindowGroup {
            // No root or index view
            // If you need to run it on the simulator,
            // change the below view to the view you'd like to preview
            PresentationDetentsDemoView(detents: [.height(200)], interactable: true)
                .tint(.purple)
        }
    }
}
