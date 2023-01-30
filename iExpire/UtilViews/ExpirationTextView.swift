//
//  ExpirationTextView.swift
//  iExpire
//
//  Created by Andy Wu on 1/23/23.
//

import SwiftUI

struct ExpirationTextView: View {
    var expirationDate: Date
    
    var expired: Bool {
        expirationDate < Date.now
    }
    
    var body: some View {
        Text(expired ? "EXPIRED" : dateToFormatString(date: expirationDate))
            .foregroundColor(
                expired ? Color(red: 0.9, green: 0.1, blue: 0.3) :
                    expirationDate == Date.now ? .yellow : .secondary
            )
            
    }
}

struct ExpirationTextView_Previews: PreviewProvider {
    static var previews: some View {
        ExpirationTextView(expirationDate: Date.now)
    }
}
