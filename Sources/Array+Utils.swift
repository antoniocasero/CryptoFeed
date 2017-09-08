//
//  Array+Utils.swift
//  CryptoFeed
//
//  Created by Antonio Casero Palmero on 31.08.17.
//  Copyright © 2017 Uttopia. All rights reserved.
//

import Foundation
public extension Array where Element: FloatingPoint {
    
    /// SwifterSwift: Average of all elements in array.
    ///
    ///		[1.2, 2.3, 4.5, 3.4, 4.5].average = 3.18
    ///
    /// - Returns: average of the array's elements.
    public func average() -> Element {
        guard isEmpty == false else { return 0 }
        var total: Element = 0
        forEach { total += $0 }
        return total / Element(count)
    }
}

public extension Array {

    /// SwifterSwift: Reduces an array while returning each interim combination.
    ///
    ///     [1, 2, 3].accumulate(initial: 0, next: +) -> [1, 3, 6]
    ///
    /// - Parameters:
    ///   - initial: initial value.
    ///   - next: closure that combines the accumulating value and next element of the array.
    /// - Returns: an array of the final accumulated value and each interim combination.
    public func accumulate<U>(initial: U, next: (U, Element) throws -> U) rethrows -> [U] {
        var runningTotal = initial
        return try map { element in
            runningTotal = try next(runningTotal, element)
            return runningTotal
        }
    }
    
    public func iterateWithPrevious(_ elements:(_ previous: Element, _ current: Element) throws -> Void) rethrows  {
        var previous: Element? = nil
        for element in self {
            if let previous = previous {
                try elements(previous, element)
            }
            previous = element
        }
    }
}

extension Dictionary where Value : RangeReplaceableCollection & ExpressibleByArrayLiteral, Value.Iterator.Element == Value.Element {
    mutating func appending(_ key: Key, _ value: Value.Element) {
        if self[key] != nil {
            self[key]!.append(value)
        } else {
            self[key] = [value]
        }
    }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}

