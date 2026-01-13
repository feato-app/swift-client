import Foundation

@available(iOS 15.0, macOS 12.0, *)
@MainActor
final class FeatoStore {
    private let _api: FeatoAPIClient
    private let _storage: FeatureFlagsStore
    
    private var _flags: FeatureFlags
    
    init(api: FeatoAPIClient, storage: FeatureFlagsStore) {
        self._api = api
        self._storage = storage
        self._flags = storage.load()
    }
    
    func flag(_ key: String) -> Bool {
        _flags[key] ?? false
    }
    
    func flags() -> FeatureFlags {
        _flags
    }
    
    func refresh() async {
        do {
            let newFlags = try await _api.fetchFlags()
            _flags = newFlags
            _storage.save(newFlags)
        } catch {
            // silent fail - keep last known state
        }
    }
}
