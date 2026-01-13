import Foundation

final class FeatureFlagsStore {
    private let _storageKey = "feato.featureFlags"
    private let _defaults = UserDefaults.standard
    
    func load() -> FeatureFlags {
        guard let data = _defaults.data(forKey: _storageKey),
              let flags = try? JSONDecoder().decode(FeatureFlags.self, from: data)
        else {
            return [:]
        }
        
        return flags
    }
    
    func save(_ flags: FeatureFlags) {
        guard let data = try? JSONEncoder().encode(flags) else {
            return
        }
        
        _defaults.set(data, forKey: _storageKey)
    }
}
