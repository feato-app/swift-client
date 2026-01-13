import Foundation

@available(iOS 15.0, macOS 12.0, *)
@MainActor
final class FeatoAPIClient {
    private let _config: FeatoConfig
    private let _session: URLSession
    
    init(config: FeatoConfig, session: URLSession = .shared) {
        self._config = config
        self._session = session
    }
    
    func fetchFlags() async throws -> FeatureFlags {
        let url = URL(string: "https://hub.feato.io")!
            .appendingPathComponent("v1")
            .appendingPathComponent("feature-flag")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            .init(name: "secret", value: _config.projectKey),
            .init(name: "environment", value: _config.environment.rawValue)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let (data, response) = try await _session.data(for: request)
        
        guard let http = response as? HTTPURLResponse,
              200..<300 ~= http.statusCode
        else {
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(GetFlagsResponse.self, from: data)
        
        return decoded.flags
    }
}
