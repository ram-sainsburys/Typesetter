import XCTest
//import Nimble

@testable import Typesetter

class TypesetterTextStyleFontSizeMatrixLoaderTests: XCTestCase {
    
    var fileManager: FileManager!
    
    override func setUp() {
        fileManager = FileManager.default
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCache() {
        let testPath = copyCSVFixtureToTestPath(csvPath("FontSizes"))
        TypesetterTextStyleFontSizeMatrixLoader(path: testPath).load()
        removeCSVFixtureAtPath(testPath)
        
        let cacheLoader = TypesetterTextStyleFontSizeMatrixLoader(path: testPath)
        
        let cachedResult = cacheLoader.load()
        XCTAssertEqual(cachedResult?.keys.count, 10)
        XCTAssertEqual(cachedResult?[.Body]?.keys.count, 12)
        
        cacheLoader.clear()
        
        let deletedResult = cacheLoader.load()
        XCTAssertNil(deletedResult)
    }
    
    fileprivate func copyCSVFixtureToTestPath(_ path: String) -> String {
        let newPath = path.replacingOccurrences(of: "FontSizes", with: "CorrectFontSizes-CacheTest")
        do {
            try fileManager.copyItem(atPath: path, toPath: newPath)
        } catch _ {
            assertionFailure("Could not copy file for cache test")
        }
        
        return newPath
    }
    
    fileprivate func removeCSVFixtureAtPath(_ path: String) {
        do {
            try fileManager.removeItem(atPath: path)
        } catch _ {
            assertionFailure("Could not remove file for cache test")
        }
    }
    
    func testWithIncorrectPath() {
        let incorrectPath = "Something/Something"
        let sizeMatrix = TypesetterTextStyleFontSizeMatrixLoader(path: incorrectPath).load()
        XCTAssertNil(sizeMatrix)
    }
    
    func testWithCorrectCSV() {

        let loader = TypesetterTextStyleFontSizeMatrixLoader(path: csvPath("FontSizes"))
        let sizeMatrix = loader.load()
        XCTAssertEqual(sizeMatrix?.keys.count, 10)
        XCTAssertEqual(sizeMatrix?[.Body]?.keys.count, 12)
        XCTAssertEqual(sizeMatrix?[.Body]?[.Small], 9.0)
        loader.clear()
    }
    
    func testWithIncompleteCSV() {
        let sizeMatrix = TypesetterTextStyleFontSizeMatrixLoader(path: csvPath("IncompleteFontSizes")).load()
        XCTAssertNil(sizeMatrix)
    }
    
    func testWithCSVWithMissingSizeHeader() {
        let sizeMatrix = TypesetterTextStyleFontSizeMatrixLoader(path: csvPath("MissingSizeHeader")).load()
        XCTAssertNil(sizeMatrix)
    }
    
    func testWithCorruptCSV() {
        let sizeMatrix = TypesetterTextStyleFontSizeMatrixLoader(path: csvPath("CorruptFontSizes")).load()
        XCTAssertNil(sizeMatrix)
    }
    
    func testWithCorruptFile() {
        let sizeMatrix = TypesetterTextStyleFontSizeMatrixLoader(path: csvPath("CorruptFile")).load()
        XCTAssertNil(sizeMatrix)
    }
    
    fileprivate func csvPath(_ fileName: String) -> String {
        guard let csvPath = Bundle.module.url(forResource: fileName, withExtension: "csv") else {
            print("Failed to find resource")
            return ""
        }
        return csvPath.path
    }
}
