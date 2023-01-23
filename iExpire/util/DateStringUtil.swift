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
