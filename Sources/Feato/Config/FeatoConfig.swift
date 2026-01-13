struct FeatoConfig {
    let projectKey: String
    let environment: Environment
    
    static func `default`(projectKey: String, environment: Environment) -> FeatoConfig {
        FeatoConfig(projectKey: projectKey, environment: environment)
    }
}
