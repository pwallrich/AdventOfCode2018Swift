//
//  Character.swift
//  AdventOfCode
//
//  Created by Philipp Wallrich on 15.12.18.
//

import Foundation

public extension Character {

    public static let alphabet = Array("abcdefghijklmnopqrstuvwxyz")

    public var uppercased: Character {
        return "\(self)".uppercased().first!
    }

    public var lowercased: Character {
        return "\(self)".lowercased().first!
    }

    public var isUppercase: Bool {
        return uppercased == self
    }

}
