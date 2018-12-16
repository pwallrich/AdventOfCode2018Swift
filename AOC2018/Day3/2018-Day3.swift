//
//  2018-Day3.swift
//  AOC2018
//
//  Created by Philipp Wallrich on 16.12.18.
//

/*:
 ## Day 3 Part 1
 The whole piece of fabric they're working on is a very large square - at least `1000` inches on each side.

 Each Elf has made a claim about which area of fabric would be ideal for Santa's suit. All claims have an ID and consist of a single rectangle with edges parallel to the edges of the fabric. Each claim's rectangle is defined as follows:

 The number of inches between the left edge of the fabric and the left edge of the rectangle.
 The number of inches between the top edge of the fabric and the top edge of the rectangle.
 The width of the rectangle in inches.
 The height of the rectangle in inches.

 A claim like `#123 @ 3,2: 5x4` means that claim ID `123` specifies a rectangle `3` inches from the left edge, `2` inches from the top edge, `5` inches wide, and `4` inches tall. Visually, it claims the square inches of fabric represented by `#` (and ignores the square inches of fabric represented by `.`) in the diagram below:
 ```
 ...........
 ...........
 ...#####...
 ...#####...
 ...#####...
 ...#####...
 ...........
 ...........
 ...........
 ```
 The problem is that many of the claims overlap, causing two or more claims to cover part of the same areas. For example, consider the following claims:
 ```
 #1 @ 1,3: 4x4
 #2 @ 3,1: 4x4
 #3 @ 5,5: 2x2
 ```
 Visually, these claim the following areas:
 ```
 ........
 ...2222.
 ...2222.
 .11XX22.
 .11XX22.
 .111133.
 .111133.
 ........
 ```
 The four square inches marked with X are claimed by both `1` and `2`. (Claim `3`, while adjacent to the others, does not overlap either of them.)

 If the Elves all proceed with their own plans, none of them will have enough fabric. How many square inches of fabric are within two or more claims?
 */

/*:
 ## Day 3 Part 2
 Amidst the chaos, you notice that exactly one claim doesn't overlap by even a single square inch of fabric with any other claim. If you can somehow draw attention to it, maybe the Elves will be able to make Santa's suit after all!

 For example, in the claims above, only claim 3 is intact after all claims are made.

 What is the ID of the only claim that doesn't overlap?

 The current solution isn't really quick yet, so smth else should be used. Maybe creating a Matrix upfront and checking with the matrix if the regions overlap
 */

import Foundation

open class Day3: Day {

    public init() {
        super.init(file: #file)
    }

    public init(with input: String) {
        super.init(input: input)
    }

    override public func part1() -> String {
        var matrix = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)
        let res = input.split(separator: "\n")
            .reduce(0) { res, str in
                var newRes = res
                let rect = Rect(from: String(str))!
                for x in rect.x..<(rect.x + rect.width) {
                    for y in rect.y..<(rect.y + rect.height) {
                        matrix[x][y] += 1
                        if matrix[x][y] == 2 {
                            // if the value is 2 after increasing
                            // there was allready 1 item at that slot before
                            // therfore increasing counter. 3rd, 4th.. occurences won't increment
                            newRes += 1
                        }
                    }
                }
                return newRes
            }
        return "\(res)"
    }

    override public func part2() -> String {
        let values = getRects(from: input)
        for (idx, rect) in values.enumerated() {
            var overlaps = false
            for i in 0..<values.count {
                if i == idx {
                    continue
                }
                if rect.overlaps(with: values[i]) {
                    overlaps = true
                    break
                }
            }
            if !overlaps {
                return "\(rect.id)"
            }
        }
        return ""
    }

    func getRects(from data: String) -> [Rect] {
        return data
            .split(separator: "\n")
            .map { Rect(from: String($0))! }
    }
}


