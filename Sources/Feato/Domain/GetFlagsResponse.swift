struct GetFlagsResponse: Codable {
    let environment: Environment
    let flags: FeatureFlags
}
