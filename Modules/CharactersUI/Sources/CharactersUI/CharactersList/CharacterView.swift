import SwiftUI


struct CharacterView: View {
    
    let character: Character
    private let imageDimension: CGFloat = 100
    var body: some View {
        HStack {
            AsyncImage(url: character.image) { phase in
                
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: self.imageDimension, height: self.imageDimension)
                        .cornerRadius(self.imageDimension / 2)
                } else if let error = phase.error {
                    Text("Error")
                } else {
                    ProgressView()
                        .frame(width: self.imageDimension, height: self.imageDimension)
                }
                
            }
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(character.name)
                        .foregroundStyle(.primary)
                        .font(.headline)
                    
                    Text(character.species)
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    CharacterView(character: .init(
        id: 1,
        name: "Rick Sanchez",
        species: "Human",
        image: .init(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
    ))
}
