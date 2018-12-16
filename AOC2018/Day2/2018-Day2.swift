//
//  2018-Day2.swift
//  AOC2018
//
//  Created by Philipp Wallrich on 16.12.18.
//

/*:
 ## Day 2 Part 1
 To make sure you didn't miss any, you scan the likely candidate boxes again, counting the number that have an ID containing exactly two of any letter and then separately counting those with exactly three of any letter. You can multiply those two counts together to get a rudimentary checksum and compare it to what your device predicts.

 For example, if you see the following box IDs:

 - `abcdef` contains no letters that appear exactly two or three times. `( 2 Letters: 0, 3 Letters: 0)`
 - `bababc` contains two a and three b, so it counts for both. `( 2 Letters: 1, 3 Letters: 1)`
 - `abbcde` contains two b, but no letter appears exactly three times. `( 2 Letters: 2, 3 Letters: 1)`
 - `abcccd` contains three c, but no letter appears exactly two times. `( 2 Letters: 2, 3 Letters: 2)`
 - `aabcdd` contains two a and two d, but it only counts once. `( 2 Letters: 3, 3 Letters: 2)`
 - `abcdee` contains two e. `( 2 Letters: 4, 3 Letters: 2)`
 - `ababab` contains three a and three b, but it only counts once. `( 2 Letters: 4, 3 Letters: 4)`

 Of these box IDs, four of them contain a letter which appears exactly twice, and three of them contain a letter which appears exactly three times. Multiplying these together produces a checksum of  `4 * 3 = 12.`

 What is the checksum for your list of box IDs?
 */

/*:
 ## Day 2 Part 2
 The boxes will have IDs which differ by exactly one character at the same position in both strings. For example, given the following box IDs:
 ```
 abcde
 fghij
 klmno
 pqrst
 fguij
 axcye
 wvxyz
 ```
 The IDs `abcde` and `axcye` are close, but they differ by two characters (the second and fourth). However, the IDs `fghij` and `fguij` differ by exactly one character, the third (h and u). Those must be the correct boxes.

 What letters are common between the two correct box IDs? (In the example above, this is found by removing the differing character from either ID, producing `fgij`.)
 */

import Foundation

open class Day2: Day {

    func findOccurences(input: String) -> (two: Bool, three: Bool) {
        let counts = input.reduce([Character: Int]()) { res, val in
            var new = res
            if let count = new[val] {
                new[val] = count + 1
            } else {
                new[val] = 1
            }
            return new
        }
        return counts.reduce((two: false, three: false)) { res, val in
            if val.value == 2 {
                return (two: true, three: res.three)
            }
            if val.value == 3 {
                return (two: res.two, three: true)
            }
            return res
        }
    }

    func getChecksum(input: [(two: Bool, three: Bool)]) -> Int {
        let vals = input
            .reduce((0,0)) { res, val in
                return (res.0 + Int.initFrom(bool: val.two), res.1 + Int.initFrom(bool: val.three))
        }
        return vals.0 * vals.1
    }

    func getStringsDifferingByOneChar(with data: [String]) -> (String, String) {
        for idx in 0..<data.count {
            let first = data[idx]
            for idx2 in (idx + 1)..<data.count {
                let second = data[idx2]
                if first.almostEqual(to: second) {
                    return (first, second)
                }
            }
        }
        return ("", "")
    }


    public init() {
        super.init(file: #file)
    }

    public init(with input: String) {
        super.init(input: input)
    }

    override public func part1() -> String {
        let values = input
            .split(separator: "\n")
            .map { findOccurences(input: String($0)) }
        return "\(getChecksum(input: values))"
    }

    override public func part2() -> String {
        let values = input.split(separator: "\n").map { String($0) }
        let almostEquals = getStringsDifferingByOneChar(with: values)
        return almostEquals.0.getEqualElements(with: almostEquals.1)
    }
}


