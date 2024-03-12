import SwiftUI

struct BeerBuddyScreen: View {
    
    @ObservedObject private var viewModel: BeerBuddyViewModel
    
    
    init(viewModel: BeerBuddyViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case let .loaded(info):
                BeerBuddyView(info: info)
            case .error:
                Button("Retry") {
                    self.viewModel.getBeerBuddy()
                }
            }
        }
        .onAppear {
            self.viewModel.getBeerBuddy()
        }
        
    }
}

struct BeerBuddyView: View {
    
    private let info: BeerBuddyViewModel.ScreenInfo
    private let imageDimension: CGFloat = 100
    
    init(info: BeerBuddyViewModel.ScreenInfo) {
        self.info = info
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 50) {
            HStack {
                VStack {
                    self.image(info.firstCharacterImage)
                    Text(info.firstCharacterName)
                }

                VStack {
                    self.image(info.secondCharacterImage)
                    Text(info.secondCharacterName)
                }
            }
            
            VStack {
                List {
                    ForEach(self.info.extraInfo, id: \.self) { string in
                        Text(string)
                    }
                }
            }
        }
    }
    
    private func image(_ imageURL: URL) -> some View {
        AsyncImage(url: imageURL) { phase in
            
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: self.imageDimension, height: self.imageDimension)
                    .cornerRadius(self.imageDimension / 2)
            } else if let error = phase.error {
                Circle()
                    .background(Color.secondary)
                    .frame(width: self.imageDimension, height: self.imageDimension)
                    .cornerRadius(self.imageDimension / 2)
            } else {
                ProgressView()
                    .frame(width: self.imageDimension, height: self.imageDimension)
            }
            
        }
    }
}
