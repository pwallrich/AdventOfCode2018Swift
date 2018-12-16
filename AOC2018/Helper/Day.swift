//
//  Day.swift
//  AdventOfCode
//
//  Created by Philipp Wallrich on 15.12.18.
//

import Foundation

open class Day {
    var input: String

    init(file: String) {
        let url = URL(fileURLWithPath: file).deletingLastPathComponent().appendingPathComponent("/input.txt")
        do {
            input = try String(contentsOf: url, encoding: String.Encoding.utf8)
        } catch {
            fatalError("Error getting input: \(error)")
        }
    }

    init(input: String) {
        self.input = input
    }

    public func run() -> (String, String) {
        return (part1(), part2())
    }

    public func part1() -> String { fatalError("Implement \(#function)") }
    public func part2() -> String { fatalError("Implement \(#function)") }
}
