//
//  CSVTests.swift
//  Typesetter
//
//  Created by Beat Richartz on 06/02/2016.
//  Copyright © 2016 Beat Richartz. All rights reserved.
//

import XCTest
//import Nimble

@testable import Typesetter

class CSVTests: XCTestCase {

    func testParseHeaders() {
        guard let csvPath = Bundle.module.url(forResource: "CSV", withExtension: "csv") else {
            print("Failed to find resource")
            return
        }
        let parsed = CSV(contentsOfFile: csvPath.path)
        XCTAssertEqual(parsed?.headers, ["a", "b", "cd"])
       
    }
    
    func testParseColumns() {
        guard let csvPath = Bundle.module.url(forResource: "CSV", withExtension: "csv") else {
            print("Failed to find resource")
            return
        }
        let parsed = CSV(contentsOfFile: csvPath.path)
        XCTAssertEqual(parsed?.columns["a"], ["1", "5"])
        XCTAssertEqual(parsed?.columns["b"], ["2", "6"])
        XCTAssertEqual(parsed?.columns["cd"], ["34", "78"])
    }
    
    func testParseCorrupt() {
        let parsed = CSV(contentsOfFile: csvPath("CorruptFile"))
        XCTAssertNil(parsed)
    }
    
    fileprivate func csvPath(_ fileName: String) -> String {
        guard let csvPath = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "csv") else {
            return ""
        }
        return csvPath
    }

}
