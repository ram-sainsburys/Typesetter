import XCTest
//import Nimble

@testable import Typesetter

class TypesetterFontSizeTests: XCTestCase {
    
    func testSizeMapping() {
        let mapping: [TypesetterFontSize: UIContentSizeCategory] = [
            .Small: UIContentSizeCategory.small,
            .Medium: UIContentSizeCategory.medium,
            .Large: UIContentSizeCategory.large,
            .ExtraSmall: UIContentSizeCategory.extraSmall,
            .ExtraLarge: UIContentSizeCategory.extraLarge,
            .ExtraExtraLarge: UIContentSizeCategory.extraExtraLarge,
            .ExtraExtraExtraLarge: UIContentSizeCategory.extraExtraExtraLarge,
            .AccessibilityMedium: UIContentSizeCategory.accessibilityMedium,
            .AccessibilityLarge: UIContentSizeCategory.accessibilityLarge,
            .AccessibilityExtraLarge: UIContentSizeCategory.accessibilityExtraLarge,
            .AccessibilityExtraExtraLarge: UIContentSizeCategory.accessibilityExtraExtraLarge,
            .AccessibilityExtraExtraExtraLarge: UIContentSizeCategory.accessibilityExtraExtraExtraLarge
        ]
        
        for (expectedFontSize, inputContentSize) in mapping {
            XCTAssertEqual(TypesetterFontSize(contentSize: inputContentSize.rawValue), expectedFontSize)
        }
    }
    
    func testSizeCount() {
        XCTAssertEqual(TypesetterFontSize.count, 12)
    }
    
    
}
