//
//  Day3Tests.swift
//  AOC2018Tests
//
//  Created by Philipp Wallrich on 16.12.18.
//  Copyright © 2018 FIStudios. All rights reserved.
//

import Foundation

import XCTest
@testable import AOC2018

class Day3Tests: XCTestCase {

    var sut: Day3!

    override func setUp() {
        let testStrings = ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"]

        sut = Day3(with: testStrings.joined(separator: "\n"))
    }

    func testPart1() {
        XCTAssertEqual(sut.part1(), "4")
    }

    func testPart2() {
        XCTAssertEqual(sut.part2(), "3")
    }

}
