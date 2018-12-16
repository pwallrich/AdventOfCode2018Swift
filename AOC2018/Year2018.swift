//
//  Year.swift
//  AOC2018
//
//  Created by Philipp Wallrich on 16.12.18.
//

import Foundation

open class Year2018 {

    public init() { }

    private lazy var days: [Int: Day] = {
        return [
            1: Day1(),
            2: Day2(),
            3: Day3(),
            4: Day4(),
            5: Day5()
        ]
    }()

    public func getAllDays() -> [Day] {
        return days.sorted(by: { $0.0 < $1.0 }).map { $0.value }
    }

    public func getDay(number: Int) -> Day? {
        return days[number]
    }

}
