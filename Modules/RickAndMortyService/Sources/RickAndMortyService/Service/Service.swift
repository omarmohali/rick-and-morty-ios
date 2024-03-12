import Foundation

public class Service {
    
    private(set) var baseURL: URL
    private(set) var session: URLSession
    public init(
        session: URLSession = .shared,
        baseURL: URL
    ) {
        self.session = session
        self.baseURL = baseURL
    }
    
}
