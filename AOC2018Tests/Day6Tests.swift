//
//  Day6Tests.swift
//  AOC2018Tests
//
//  Created by Philipp Wallrich on 16.12.18.
//  Copyright © 2018 FIStudios. All rights reserved.
//

import Foundation

import XCTest
@testable import AOC2018

class Day6Tests: XCTestCase {

    var sut: Day6!

    override func setUp() {
        let testInput = [
            "1, 1",
            "1, 6",
            "8, 3",
            "3, 4",
            "5, 5",
            "8, 9"
        ]

        sut = Day6(with: testInput.joined(separator: "\n"))
    }

    func testPart1() {
        XCTAssertEqual(sut.part1(), "17")
    }

    func testPart2() {
        XCTAssertEqual(sut.part2(), "4455")
    }

}
