//
//  ExpirationChartsView.swift
//  iExpire
//
//  Created by Andy Wu on 2/23/23.
//

import SwiftUI
import Charts
import OrderedCollections

// Potentially add multiple chart types here
struct ExpirationChartsView: View {
    var groupedItems: OrderedDictionary<String, [Item]>
    
    var body: some View {
        NavigationLink {
            ItemBarChart(groupedItems: groupedItems)
        } label: {
            Text("Expiration Date Data")
        }
    }
}

struct ItemBarChart: View {
    var groupedItems: OrderedDictionary<String, [Item]>
    
    var body: some View {
        Section {
            Chart {
                ForEach(Array(groupedItems.keys), id: \.self) { sectionKey in
                    BarMark(
                        x: .value("Expiration Date", sectionKey),
                        y: .value("Total Count", groupedItems[sectionKey]!.count)
                    )
                    // Expired section should use red
                    .foregroundStyle(groupedItems[sectionKey]!.first!.wrappedDateTime.comesBefore(Date.now) ? .red : .blue)
                }
            }
        } header: {
            Text("# of Tracked Items By Expiration Date")
                .accessibilityLabel("Number of tracked items grouped by expiration date")
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
