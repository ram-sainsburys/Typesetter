import XCTest
import Typesetter

class TypesetterConfigurationTests: XCTestCase {

    func testSizeDefinitionsPath() {
        let configuration = TypesetterConfiguration(sizeDefinitionsPath: "PATH")
        XCTAssertEqual(configuration.sizeDefinitionsPath, "PATH")
    }
    
    func testDefaultFontSize() {
        let configuration = TypesetterConfiguration(sizeDefinitionsPath: "PATH", defaultFontSize: 14.0)
        XCTAssertEqual(configuration.defaultFontSize, 14.0)
    }

}
