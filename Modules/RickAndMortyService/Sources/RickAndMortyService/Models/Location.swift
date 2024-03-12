import Foundation

public struct Location: Decodable {
    public let id: Int
    public let name: String
    public let type: String
    public let dimension: String
    public let residents: [URL]
    public let url: URL
}
