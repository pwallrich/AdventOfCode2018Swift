//
//  Day1Tests.swift
//  AOC2018Tests
//
//  Created by Philipp Wallrich on 16.12.18.
//

import XCTest
@testable import AOC2018

class Day1Tests: XCTestCase {

    var sut: Day1!

    override func setUp() {

    }

    func testPart1first() {
        sut = Day1(with: "+1\n-2\n+3\n+1")
        XCTAssertEqual(sut.part1(), "3")
    }

    func testPart1Second() {
        sut = Day1(with: "+1\n+1\n+1")
        XCTAssertEqual(sut.part1(), "3")
    }

    func testPart1Third() {
        sut = Day1(with: "+1\n+1\n-2")
        XCTAssertEqual(sut.part1(), "0")
    }

    func testPart1Fourth() {
        sut = Day1(with: "-1\n-2\n-3")
        XCTAssertEqual(sut.part1(), "-6")
    }

    func testPart2First() {
        sut = Day1(with: "+3\n+3\n+4\n-2\n-4")
        XCTAssertEqual(sut.part2(), "10")
    }

    func testPart2Second() {
        sut = Day1(with: "+1\n-1")
        XCTAssertEqual(sut.part2(), "0")
    }

    func testPart2Third() {
        sut = Day1(with: "+7\n+7\n-2\n-7\n-4")
        XCTAssertEqual(sut.part2(), "14")
    }

    func testPart2Fourth() {
        sut = Day1(with: "-6\n+3\n+8\n+5\n-6")
        XCTAssertEqual(sut.part2(), "5")
    }

}
