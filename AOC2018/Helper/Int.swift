//
//  Int.swift
//  AOC2018
//
//  Created by Philipp Wallrich on 16.12.18.
//  Copyright © 2018 FIStudios. All rights reserved.
//

import Foundation

extension Int {
    static func initFrom(bool val: Bool) -> Int {
        return val ? 1 : 0
    }

    init?(withRegex regex:String, from: String) {
        guard let range = from.range(of: regex, options: .regularExpression) else {
            return nil
        }
        self.init(String(from[range]))
    }
}
