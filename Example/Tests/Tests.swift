import UIKit
import XCTest
import Yashin

class Tests: XCTestCase {

    var radarChart = Yashin()

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testValidateMinAndMax() {

        radarChart.set(
            ["aaa", "bbb", "ccc",],
            [
                ([4, 5, 8], UIColor.greenColor().colorWithAlphaComponent(0.40)),
                ([10, 3, 6], UIColor.darkGrayColor().colorWithAlphaComponent(0.40))
            ]
        )

        XCTAssert(radarChart.validateMinAndMax() == true, "when default minValue and maxValue")

        radarChart.minValue = 10
        radarChart.maxValue = 0

        XCTAssert(radarChart.validateMinAndMax() == false, "when minValue is more than maxValue")

        radarChart.maxValue = 10

        XCTAssert(radarChart.validateMinAndMax() == false, "when minValue equals maxValue")

        radarChart.maxValue = 100

        XCTAssert(radarChart.validateMinAndMax() == true, "when minValue is less than maxValue")
    }

    func testValidateKeyCount() {

        radarChart.set(
            ["aaa", "bbb"],
            [
                ([4, 5], UIColor.greenColor().colorWithAlphaComponent(0.40)),
                ([10, 3], UIColor.darkGrayColor().colorWithAlphaComponent(0.40))
            ]
        )

        XCTAssert(radarChart.validateKeyCount() == false, "when key count is less than 3")

        radarChart.set(
            ["aaa", "bbb", "ccc"],
            [
                ([4, 5, 8], UIColor.greenColor().colorWithAlphaComponent(0.40)),
                ([10, 3, 6], UIColor.darkGrayColor().colorWithAlphaComponent(0.40))
            ]
        )

        XCTAssert(radarChart.validateMinAndMax() == true, "when key count is more than 2")
    }

    func testValidateIntegrityKeyAndValue() {

        radarChart.set(
            ["aaa", "bbb", "ccc"],
            [
                ([4, 5], UIColor.greenColor().colorWithAlphaComponent(0.40))
            ]
        )

        XCTAssert(radarChart.validateIntegrityKeyAndValue() == false, "when key and value integrity is wrong (single data) [1]")

        radarChart.set(
            ["aaa", "bbb"],
            [
                ([4, 5, 8], UIColor.greenColor().colorWithAlphaComponent(0.40))
            ]
        )

        XCTAssert(radarChart.validateIntegrityKeyAndValue() == false, "when key and value integrity is wrong (single data) [2]")

        radarChart.set(
            ["aaa", "bbb", "ccc"],
            [
                ([4, 5, 8], UIColor.greenColor().colorWithAlphaComponent(0.40)),
                ([10, 3], UIColor.darkGrayColor().colorWithAlphaComponent(0.40))
            ]
        )

        XCTAssert(radarChart.validateIntegrityKeyAndValue() == false, "when key and value integrity is wrong (multi data)")

        radarChart.set(
            ["aaa", "bbb", "ccc"],
            [
                ([4, 5, 8], UIColor.greenColor().colorWithAlphaComponent(0.40)),
                ([10, 3, 6], UIColor.darkGrayColor().colorWithAlphaComponent(0.40))
            ]
        )

        XCTAssert(radarChart.validateIntegrityKeyAndValue() == true, "when key and value integrity is correct")
    }

    func testValidateSufficientFrame() {

        radarChart = Yashin(frame: CGRectMake(0, 0, 100, 100))

        radarChart.set(
            ["aaa", "bbb"],
            [
                ([4, 5], UIColor.greenColor().colorWithAlphaComponent(0.40)),
                ([10, 3], UIColor.darkGrayColor().colorWithAlphaComponent(0.40))
            ]
        )

        XCTAssert(radarChart.validateSufficientFrame() == false, "when frame is smaller than expected")

        radarChart.frame = CGRectMake(0, 0, 180, 180)

        XCTAssert(radarChart.validateSufficientFrame() == true, "when frame is big enough [1]")

        radarChart.padding = 100

        XCTAssert(radarChart.validateSufficientFrame() == false, "when frame is smaller than expected (after padding is changed)")

        radarChart.frame = CGRectMake(0, 0, 260, 260)

        XCTAssert(radarChart.validateSufficientFrame() == true, "when frame is big enough [2]")
    }
    
    func testPerformanceDraw() {
        self.measureBlock() {
            //
        }
    }
    
}
