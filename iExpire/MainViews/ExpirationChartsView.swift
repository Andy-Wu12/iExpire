//
//  ExpirationChartsView.swift
//  iExpire
//
//  Created by Andy Wu on 2/23/23.
//

import SwiftUI
import Charts

// Potentially add multiple chart types here
struct ExpirationChartsView: View {
    var groupedItems: Dictionary<String, [Item]>
    
    var body: some View {
        NavigationLink {
            ItemBarChart(groupedItems: groupedItems)
        } label: {
            Text("Expiration Date Data")
        }
    }
}

struct ItemBarChart: View {
    var groupedItems: Dictionary<String, [Item]>
    
    var body: some View {
        List {
            ForEach(Array(groupedItems.keys), id: \.self) { sectionKey in
                Section {
                    ForEach(groupedItems[sectionKey]!) { item in
                        Text(item.wrappedName)
                            .font(.system(size: 32).italic())
                    }
                } header: {
                    Text(sectionKey)
                }
            }
        }
    }
}

struct ExpirationBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        Chart {
            BarMark(
                x: .value("Shape Type", "adc"),
                y: .value("Total Count", 2)
            )
            BarMark(
                 x: .value("Shape Type", "ade"),
                 y: .value("Total Count", 10)
            )
            BarMark(
                 x: .value("Shape Type", "bcd"),
                 y: .value("Total Count", 0)
            )
        }
    }
}
