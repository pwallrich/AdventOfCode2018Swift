//
//  2018-Day4.swift
//  AOC2018
//
//  Created by Philipp Wallrich on 16.12.18.
//

import Foundation

/*:
 ## Day 4 Part 1
 As you search the closet for anything that might help, you discover that you're not the first person to want to sneak in. Covering the walls, someone has spent an hour starting every midnight for the past few months secretly observing this guard post! They've been writing down the ID of the one guard on duty that night - the Elves seem to have decided that one guard was enough for the overnight shift - as well as when they fall asleep or wake up while at their post (your puzzle input).

 For example, consider the following records, which have already been organized into chronological order:
 ```
 [1518-11-01 00:00] Guard #10 begins shift
 [1518-11-01 00:05] falls asleep
 [1518-11-01 00:25] wakes up
 [1518-11-01 00:30] falls asleep
 [1518-11-01 00:55] wakes up
 [1518-11-01 23:58] Guard #99 begins shift
 [1518-11-02 00:40] falls asleep
 [1518-11-02 00:50] wakes up
 [1518-11-03 00:05] Guard #10 begins shift
 [1518-11-03 00:24] falls asleep
 [1518-11-03 00:29] wakes up
 [1518-11-04 00:02] Guard #99 begins shift
 [1518-11-04 00:36] falls asleep
 [1518-11-04 00:46] wakes up
 [1518-11-05 00:03] Guard #99 begins shift
 [1518-11-05 00:45] falls asleep
 [1518-11-05 00:55] wakes up
 ```
 Timestamps are written using `year-month-day hour:minute` format. The guard falling asleep or waking up is always the one whose shift most recently started. Because all asleep/awake times are during the midnight hour (`00:00 - 00:59`), only the minute portion (`00 - 59`) is relevant for those events.

 Visually, these records show that the guards are asleep at these times:
 ```
 Date   ID   Minute
 000000000011111111112222222222333333333344444444445555555555
 012345678901234567890123456789012345678901234567890123456789
 11-01  #10  .....####################.....#########################.....
 11-02  #99  ........................................##########..........
 11-03  #10  ........................#####...............................
 11-04  #99  ....................................##########..............
 11-05  #99  .............................................##########.....
 ```
 The columns are Date, which shows the month-day portion of the relevant day; ID, which shows the guard on duty that day; and Minute, which shows the minutes during which the guard was asleep within the midnight hour. (The Minute column's header shows the minute's ten's digit in the first row and the one's digit in the second row.) Awake is shown as `.`, and asleep is shown as `#`.

 Note that guards count as asleep on the minute they fall asleep, and they count as awake on the minute they wake up. For example, because Guard `#10` wakes up at `00:25` on `1518-11-01`, minute `25` is marked as awake.

 If you can figure out the guard most likely to be asleep at a specific time, you might be able to trick that guard into working tonight so you can have the best chance of sneaking in. You have two strategies for choosing the best guard/minute combination.

 Strategy 1: Find the guard that has the most minutes asleep. What minute does that guard spend asleep the most?

 In the example above, Guard #10 spent the most minutes asleep, a total of 50 minutes (20+25+5), while Guard #99 only slept for a total of 30 minutes (10+10+10). Guard #10 was asleep most during minute 24 (on two days, whereas any other minute the guard was asleep was only seen on one day).

 While this example listed the entries in chronological order, your entries are in the order you found them. You'll need to organize them before they can be analyzed.

 What is the ID of the guard you chose multiplied by the minute you chose? (In the above example, the answer would be `10 * 24 = 240`.)
 */

/*:
 ## Day 4 Part 2
 Strategy 2: Of all guards, which guard is most frequently asleep on the same minute?

 In the example above, Guard #99 spent minute 45 asleep more than any other guard or minute - three times in total. (In all other cases, any guard spent any minute asleep at most twice.)

 What is the ID of the guard you chose multiplied by the minute you chose? (In the above example, the answer would be 99 * 45 = 4455.)
 */

open class Day4: Day {
    public init() {
        super.init(file: #file)
    }

    public init(with input: String) {
        super.init(input: input)
    }

    override public func part1() -> String {
        let parsedArray = parse(inputs: input.split(separator: "\n").map { String($0) })
        let minutesAsleep = parsedArray.map { ($0, $0.minutesAsleep) }
        let longestGuard = minutesAsleep.max(by: { $0.1 < $1.1 })!
        if let maxMinute = longestGuard.0.asleepMost {
            return "\(longestGuard.0.id * maxMinute.0)"
        } else {
            return ""
        }
    }

    override public func part2() -> String {
        let parsedArray = parse(inputs: input.split(separator: "\n").map { String($0) })
        let minutesAsleep = parsedArray
            .compactMap { arg -> (Int, Int, Int)? in
                if let most = arg.asleepMost {
                    return (arg.id, most.0, most.1)
                }
                return nil
        }
        let longestGuard = minutesAsleep.max(by: { $0.2 < $1.2 })!
        return "\(longestGuard.0 * longestGuard.1)"
    }

    func parse(inputs: [String]) -> [Guard] {
        var lastGuard: Int = 0
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        var allActions = [Action]()
        var actions = [Int: [Action]]()

        inputs.forEach { input in
            let start = input.index(input.startIndex, offsetBy: 1)
            let end = input.index(input.startIndex, offsetBy: 17)
            let dateString = input[start..<end]
            let description = input[end...]
            guard let time = dateFormatter.date(from: String(dateString)) else {
                return
            }
            let numberRegEx = "(?<=\\#)[0-9]+"
            if let x = Int(withRegex: numberRegEx, from: String(description)) {
                lastGuard = x
            }
            guard let action = Action(description: String(description),
                                      time: time) else {
                                        return
            }
            allActions.append(action)
        }
        allActions.sort()
        allActions.forEach { action in
            if case let .beginsShift(id) = action.command {
                lastGuard = id
            }
            if actions[lastGuard] == nil {
                actions[lastGuard] = []
            }
            if let index = actions[lastGuard]!.firstIndex(where: { $0 > action }) {
                actions[lastGuard]!.insert(action, at: index)
            } else {
                actions[lastGuard]?.append(action)
            }
        }
        return actions.map { (key, value) in
            Guard(id: key, actions: value)
        }
    }

    func parse_v2(inputs: [String]) -> [Guard] {
        var lastGuard: Int = 0
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        var allActions = [Action]()
        var actions = [Int: [Action]]()

        inputs.forEach { input in
            let start = input.index(input.startIndex, offsetBy: 1)
            let end = input.index(input.startIndex, offsetBy: 17)
            let dateString = input[start..<end]
            let description = input[end...]
            guard let time = dateFormatter.date(from: String(dateString)) else {
                return
            }
            let numberRegEx = "(?<=\\#)[0-9]+"
            if let x = Int(withRegex: numberRegEx, from: String(description)) {
                lastGuard = x
            }
            guard let action = Action(description: String(description),
                                      time: time) else {
                                        return
            }
            allActions.append(action)
        }
        allActions.sort()
        allActions.forEach { action in
            if case let .beginsShift(id) = action.command {
                lastGuard = id
            }
            if actions[lastGuard] == nil {
                actions[lastGuard] = []
            }
            if let index = actions[lastGuard]!.firstIndex(where: { $0 > action }) {
                actions[lastGuard]!.insert(action, at: index)
            } else {
                actions[lastGuard]?.append(action)
            }
        }
        return actions.map { (key, value) in
            Guard(id: key, actions: value)
        }
    }
}

enum Command: Equatable {
    case asleep
    case wake
    case beginsShift(id: Int)
}

struct Action: Comparable {

    let command: Command
    let time: Date

    init?(description: String, time: Date) {
        // Check if string contains 'carrousel'
        if description.contains("falls asleep") {
            self.command = .asleep
            self.time = time
        } else if description.contains("wakes up") {
            self.command = .wake
            self.time = time
        } else if description.contains("begins shift") {
            let numberRegEx = "(?<=\\#)[0-9]+"
            if let id = Int(withRegex: numberRegEx, from: String(description)) {
                self.command = .beginsShift(id: id)
            } else {
                return nil
            }
            self.time = time
        } else {
            return nil
        }
    }

    static func < (lhs: Action, rhs: Action) -> Bool {
        return lhs.time < rhs.time
    }
}

struct Guard {
    let id: Int
    let actions: [Action]

    var minutesAsleep: Int {
        var fellAsleep: Date?
        var res = 0

        for action in actions {
            if let date = fellAsleep {

                res += Int(action.time.timeIntervalSince1970 - date.timeIntervalSince1970)
                fellAsleep = nil
            }
            if action.command == .asleep {
                fellAsleep = action.time
            }
        }
        return res / 60
    }

    var asleepMost: (Int, Int)? {
        var calendar = Calendar(identifier: .gregorian)
        if let timeZone = TimeZone(secondsFromGMT: 0) {
            calendar.timeZone = timeZone
        }
        var fellAsleep: Date?
        var dict = [Int: Int]()
        for action in actions {
            if let date = fellAsleep {
                let first = calendar.component(.minute, from: date)
                let second = calendar.component(.minute, from: action.time)
                var minutes: [Int]
                if second > first {
                    minutes = Array(first..<second)
                } else {
                    minutes = Array(0..<second)
                    minutes += Array(first..<60)
                }
                for i in minutes {
                    if dict[i] == nil {
                        dict[i] = 0
                    }
                    dict[i]! += 1
                }
                fellAsleep = nil
            }
            if action.command == .asleep {
                fellAsleep = action.time
            }
        }
        if let max = dict.max(by: { $0.value < $1.value }) {
            return (max.key, max.value)
        } else {
            return nil
        }
    }

}
