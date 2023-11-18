import SwiftUI

@main
struct Slide_Number_PuzzleApp: App {
    var body: some Scene {
        WindowGroup {
            @StateObject var game = SlideNumberPuzzleViewModel()
            SlideNumberPuzzleView(viewModel: game)
        }
    }
}
