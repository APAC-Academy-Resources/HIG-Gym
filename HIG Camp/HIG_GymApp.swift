import SwiftUI

@main
struct HIG_GymApp: App {
    var body: some Scene {
        WindowGroup {
            // No root or index view
            // If you need to run it on the simulator,
            // change the below view to the view you'd like to preview
            PourOverExperimentView(feel: .pastel)
        }
    }
}
