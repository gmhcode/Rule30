//
//  Rule30CellTests.swift
//  Rule30Tests
//
//  Created by Greg Hughes on 12/15/20.
//

import XCTest
@testable import Rule30
class Rule30CellTests: XCTestCase {

    let cell = Rule30CollectionViewCell()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cell.colorIsActive = false
    }



    func testActivateTrueByColor() throws {
        cell.backgroundColor = .white
        XCTAssertTrue(cell.colorIsActive)
    }
    func testActivateFalseByColor() throws {
        cell.backgroundColor = .black
        XCTAssertFalse(cell.colorIsActive)
    }
    func testActivateBlackByFalse() throws {
        cell.colorIsActive = false
        XCTAssertTrue(cell.backgroundColor == .black)
    }
    func testActivateWhiteByTrue() throws {
        cell.colorIsActive = true
        XCTAssertTrue(cell.backgroundColor == .white)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
