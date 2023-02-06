//
//  StringUtil.swift
//  iExpire
//
//  Created by Andy Wu on 2/4/23.
//

import Foundation

extension String {
    func isTrimmedEmpty() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

}
