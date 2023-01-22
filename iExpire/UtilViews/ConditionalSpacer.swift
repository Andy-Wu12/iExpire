//
//  ConditionalSpacer.swift
//  iExpire
//
//  Created by Andy Wu on 1/21/23.
//

import SwiftUI

struct ConditionalSpacer: View {
    var isOn: Bool
    
    var body: some View {
        if isOn {
            Spacer()
        }
    }
}
