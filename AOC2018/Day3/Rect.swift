//
//  Rect.swift
//  AOC2018
//
//  Created by Philipp Wallrich on 16.12.18.
//  Copyright © 2018 FIStudios. All rights reserved.
//

import Foundation

struct Rect: Equatable {
    let id: Int
    let width: Int
    let height: Int
    let x: Int
    let y: Int

    init?(from string: String) {
        let xRegEx = "(?<=\\@.)[0-9]+(?=,)"
        let yRegEx = "(?<=,)[0-9]+(?=:)"
        let widthRegEx = "(?<=: )[0-9]+(?=x)"
        let heightRegEx = "(?<=x)[0-9]+"
        let idRegEx = "(?<=^#)[0-9.]+(?= )"
        if let x = Int(withRegex: xRegEx, from: string),
            let y = Int(withRegex: yRegEx, from: string),
            let width = Int(withRegex: widthRegEx, from: string),
            let height = Int(withRegex: heightRegEx, from: string),
            let id = Int(withRegex: idRegEx, from: string) {
            self.init(width: width, height: height, x: x, y: y, id: id)
        } else {
            return nil
        }
    }

    var xRange: Range<Int> {
        return x..<(x + width)
    }

    var yRange: Range<Int> {
        return y..<(y + height)
    }

    var cgRect: CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }

    init(width: Int, height: Int, x: Int, y: Int, id: Int) {
        self.width = width
        self.height = height
        self.x = x
        self.y = y
        self.id = id
    }

    func overlaps(with rect: Rect) -> Bool {
        return rect.xRange.overlaps(xRange) &&
            rect.yRange.overlaps(yRange)
    }
}
