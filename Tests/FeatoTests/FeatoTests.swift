import XCTest
@testable import Feato

final class FeatoTests: XCTestCase {
    @MainActor
    func testDefaultFlagIsFalse() {
        Feato.configure(projectKey: "test", environment: .dev)
        XCTAssertFalse(Feato.flag("unknown"))
    }
}
