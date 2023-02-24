//
//  StringUtil.swift
//  iExpire
//
//  Created by Andy Wu on 1/23/23.
//

import Foundation

func dateToFormatString(date: Date) -> String {
    return date.formatted(.dateTime.day().month().year())
}

func createDateAtMidnight(month: Int, day: Int, year: Int) -> Date {
    var components = DateComponents()
    components.month = month
    components.day = day
    components.year = year
    components.hour = 0
    components.minute = 0
    components.second = 0
    
    return Calendar.current.date(from: components)!
}

func createDateAtMidnight(date: Date) -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    
    return Calendar.current.date(from: components)!
}

extension Date {
    func comesBefore(_ date: Date) -> Bool {
        let result = self.compare(createDateAtMidnight(date: date))
        switch result {
        case(.orderedSame):
            return false
        case(.orderedAscending):
            return true
        case(.orderedDescending):
            return false
        }
    }
}

let monthIntDict = [
    "Jan" : 1,
    "Feb" : 2,
    "Mar" : 3,
    "Apr" : 4,
    "May" : 5,
    "Jun" : 6,
    "Jul" : 7,
    "Aug" : 8,
    "Sep" : 9,
    "Oct" : 10,
    "Nov" : 11,
    "Dec" : 12
]
