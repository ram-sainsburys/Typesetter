import XCTest
//import Nimble

@testable import Typesetter

class TypesetterTextStyleTests: XCTestCase {

    func testStyleMapping() {
        var mapping: [TypesetterTextStyle: UIFont.TextStyle] = [
            .Body: UIFont.TextStyle.body,
            .Caption1: UIFont.TextStyle.caption1,
            .Caption2: UIFont.TextStyle.caption2,
            .Footnote: UIFont.TextStyle.footnote,
            .Headline: UIFont.TextStyle.headline,
            .Subheadline: UIFont.TextStyle.subheadline,
        ]
        
        if #available(iOS 9.0, *) {
            let additionals: [TypesetterTextStyle: UIFont.TextStyle] = [
                .Callout: UIFont.TextStyle.callout,
                .Title1: UIFont.TextStyle.title1,
                .Title2: UIFont.TextStyle.title2,
                .Title3: UIFont.TextStyle.title3
            ]
            
            for (textStyle, uiTextStyle) in additionals {
                mapping[textStyle] = uiTextStyle
            }
        }
        
        
        for (expectedFontTextStyle, inputFontTextStyle) in mapping {
            XCTAssertEqual(TypesetterTextStyle(textStyle: inputFontTextStyle.rawValue), expectedFontTextStyle)
        }
        
        XCTAssertEqual(TypesetterTextStyle(textStyle: "Garbage"),TypesetterTextStyle.Body)
    }
    
    func testStyleCount() {
        XCTAssertEqual(TypesetterTextStyle.count, 10)
    }

}
