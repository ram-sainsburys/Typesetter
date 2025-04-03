//
//  TypesetterTests.swift
//  TypesetterTests
//
//  Created by Beat Richartz on 30/01/2016.
//  Copyright © 2016 Beat Richartz. All rights reserved.
//

import XCTest

import Typesetter

class TypesetterTests: XCTestCase {
    
    enum Font: String, TypesetterFont {
        case Regular = "Georgia"
        case Bold = "Courier"
        
        var name: String {
            return rawValue
        }
    }
    
    var typesetter: Typesetter!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        
        
        // Locate the path for the CSV file from the Resources folder
        guard let csvPath = Bundle.module.url(forResource: "FontSizes", withExtension: "csv") else {
            print("Failed to find resource")
            return
        }
        
        // If the file is found, load its content
        do {
            let csvData = try Data(contentsOf: csvPath)
            
            // Convert the data into a string (assuming it's a text-based CSV file)
            if let csvContent = String(data: csvData, encoding: .utf8) {
                print("CSV Content:\n\(csvContent)")
            } else {
                print("Failed to decode CSV content as a string.")
            }
            // Process the CSV data...
            print("CSV Data Loaded:CSV Data Loaded: \(csvData.count) bytes")
            typesetter = Typesetter(configuration: TypesetterConfiguration(sizeDefinitionsPath: csvPath.path))
        } catch {
            print("Error loading CSV file: \(error)")
            XCTFail("Failed to read file content: \(error.localizedDescription)")
        }
    }
    
    override func tearDown() {
        typesetter = nil
        super.tearDown()
    }
    
    func testConvenienceInitWithNoPath() {
        let convenienceTypesetter = Typesetter(bundle: Bundle())
        XCTAssertFalse(convenienceTypesetter.hasSizes)
    }
    
    func testFontForWithoutSizes() {
        typesetter = Typesetter(bundle: Bundle())
        let font = typesetter.sizedFontFor(.Body, font: Font.Bold)
        XCTAssertEqual(font.pointSize, 12.0)
    }
    
    
    func testFontFor() {
        let font = typesetter.sizedFontFor(.Subheadline, font: Font.Regular)
        XCTAssertEqual(font.pointSize, 11.0)
        XCTAssertEqual(font.fontName,Font.Regular.name)
        XCTAssertEqual(font.familyName, "Georgia")
    }
    
    func testFontForWithDifferentCut() {
        let font = typesetter.sizedFontFor(TypesetterTextStyle.Headline.rawValue, font: Font.Bold)
        XCTAssertEqual(font.pointSize, 15.0)
        XCTAssertEqual(font.fontName, Font.Bold.name)
        XCTAssertEqual(font.familyName, "Courier")
    }
    
    func testFontForWithInvalidValue() {
        let font = typesetter.sizedFontFor("Garbage", font: Font.Regular)
        XCTAssertEqual(font.pointSize, 11.0)
        XCTAssertEqual(font.fontName, Font.Regular.name)
        XCTAssertEqual(font.familyName, "Georgia")
    }
    
    func testConvenienceInitPerformance() {
        self.measure {
            for _ in 1..<10000 {
                let _ = Typesetter(bundle: Bundle(for: type(of: self)))
            }
        }
    }
    
}
