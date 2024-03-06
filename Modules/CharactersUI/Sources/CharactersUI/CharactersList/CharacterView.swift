import SwiftUI


struct CharacterView: View {
    
    let character: Character
    private let imageDimension: CGFloat = 100
    var body: some View {
        HStack {
//            AsyncImage(url: character.image) { phase in
//                switch phase {
//                case let .success(image):
//                    image
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: self.imageDimension, height: self.imageDimension)
//                        .cornerRadius(self.imageDimension / 2)
//                    
//                default:
//                    Text("Hello")
//                }
//                
//            }
            
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
            
            Image(systemName: "chevron.right")
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
