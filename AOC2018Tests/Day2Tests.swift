//
//  Day2Tests.swift
//  AOC2018Tests
//
//  Created by Philipp Wallrich on 16.12.18.
//  Copyright © 2018 FIStudios. All rights reserved.
//

import XCTest
@testable import AOC2018

class Day2Tests: XCTestCase {

    var sut: Day2!

    override func setUp() {

    }

    func testPart1() {
        sut = Day2(with: "abcdef\nbababc\nabbcde\nabcccd\naabcdd\nabcdee\nababab\n")
        XCTAssertEqual(sut.part1(), "12")
    }

    func testPart2First() {
        let testStrings = ["abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz"]
        sut = Day2(with: testStrings.joined(separator: "\n"))
        XCTAssertEqual(sut.part2(), "fgij")
    }

}
