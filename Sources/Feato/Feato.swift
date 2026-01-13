@available(iOS 15.0, macOS 12.0, *)
@MainActor
public enum Feato {
    private static var _store: FeatoStore?
    
    public static func configure(projectKey: String, environment: Environment) {
        let config = FeatoConfig.default(projectKey: projectKey, environment: environment)
        
        let api = FeatoAPIClient(config: config)
        let storage = FeatureFlagsStore()
        
        _store = FeatoStore(api: api, storage: storage)
        
        Task {
            await _store?.refresh()
        }
    }
    
    public static func flag(_ key: String) -> Bool {
        _store?.flag(key) ?? false
    }
    
    public static func flags() -> [String: Bool] {
        _store?.flags() ?? [:]
    }
    
    public static func refresh() async {
        await _store?.refresh()
    }
}
