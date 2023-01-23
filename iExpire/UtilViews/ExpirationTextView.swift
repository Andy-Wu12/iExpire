//
//  ExpirationTextView.swift
//  iExpire
//
//  Created by Andy Wu on 1/23/23.
//

import SwiftUI

struct ExpirationTextView: View {
    var expirationDate: String
    
    var body: some View {
        Text(expirationDate < dateToFormatString(date: Date.now) ? "EXPIRED" : expirationDate)
            .foregroundColor(
                expirationDate < dateToFormatString(date: Date.now) ? Color(red: 0.9, green: 0.1, blue: 0.3) :
                    expirationDate == dateToFormatString(date: Date.now) ? .yellow : .black
            )
            
    }
}

struct ExpirationTextView_Previews: PreviewProvider {
    static var previews: some View {
        ExpirationTextView(expirationDate: dateToFormatString(date: Date.now))
    }
}
