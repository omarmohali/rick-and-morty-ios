import SwiftUI
import RickAndMortyService

@main
struct RickAndMortyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init(charactersLoader: RickAndMortyService.Service()))
        }
    }
}
