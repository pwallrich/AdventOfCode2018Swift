//
//  2018-Day5.swift
//  AdventOfCode
//
//  Created by Philipp Wallrich on 15.12.18.
//

import Foundation

open class Day5: Day {
    public init() {
        super.init(file: #file)
    }

    public init(with input: String) {
        super.init(input: input)
    }

    private func reduce(_ chars: Array<Character>, skipping: Set<Character> = []) -> Array<Character> {
        let uppers = Array(String(chars).uppercased())

        var final = Array<Character>()
        var upperFinal = Array<Character>()
        for i in 0 ..< chars.count {
            if skipping.contains(chars[i]) { continue }
            if upperFinal.last == uppers[i], final.last != chars[i] {
                final.removeLast()
                upperFinal.removeLast()
            } else {
                final.append(chars[i])
                upperFinal.append(uppers[i])
            }
        }
        return final
    }

    override public func part1() -> String {
        let characters = reduce(input.compactMap { $0 == "\n" ? nil : $0 })
        return "\(characters.count)"
    }

    override public func part2() -> String {
        let source = input.compactMap { $0 == "\n" ? nil : $0 }
        let lengths = Character.alphabet.map { reduce(source, skipping: [$0, $0.uppercased]).count }
        let shortest = lengths.min()!
        return "\(shortest)"
    }

}

