//
//  main.swift
//  AdventOfCode
//
//  Created by Philipp Wallrich on 15.12.18.
//

import AOC2018

let day = Year2018().getDay(number: 5)!
let (p1, p2) = day.run()
print("\(String(describing: day)) part 1: \(p1)")
print("\(String(describing: day)) part 2: \(p2)")

//for day in Year2018().getAllDays() {
//    let (p1, p2) = day.run()
//    print("\(String(describing: day)) part 1: \(p1)")
//    print("\(String(describing: day)) part 2: \(p2)")
//}
