//
//  String.swift
//  AOC2018
//
//  Created by Philipp Wallrich on 16.12.18.
//  Copyright © 2018 FIStudios. All rights reserved.
//

import Foundation

extension String {
    func getEqualElements(with second: String) -> String {
        return zip(self, second).filter { $0 == $1 }.reduce("", { $0 + "\($1.0)" })
    }

    func getDiffChars(from second: String) -> [(Character, Character)] {
        return zip(self, second).filter { $0 != $1 }
    }

    func almostEqual(to second: String) -> Bool {
        let difference = getDiffChars(from: second)
        return difference.count == 1
    }
}
