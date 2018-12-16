//
//  AOCTests.swift
//  AOCTests
//
//  Created by Philipp Wallrich on 16.12.18.
//

import XCTest
@testable import AOC2018

class Day5Tests: XCTestCase {

    var sut: Day5!

    override func setUp() {
        sut = Day5(with: "dabAcCaCBAcCcaDA")
    }

    func testPart1() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(sut.part1(), "10")
    }

    func testPart2() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(sut.part2(), "4")
    }

//    func testPerformance() {
//        sut = Day5()
//        self.measure {
//            sut.part2()
//        }
//    }

}
