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
