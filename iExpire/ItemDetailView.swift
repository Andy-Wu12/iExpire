//
//  ItemDetailView.swift
//  iExpire
//
//  Created by Andy Wu on 1/21/23.
//

import SwiftUI
import CoreData

struct ItemDetailView: View {
    var item: Item
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(item.wrappedName)
                    .font(.largeTitle)
                Text("Expires on \(item.wrappedExpiration)")
                    .font(.headline)
                LoadedImageView(imageData: item.image)
                    .frame(width: geometry.size.width * 0.90)
                    .border(.white)
                    .padding()
            }
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let item = Item(context: moc)
        item.name = "Bananas"
        item.expirationDate = Date.now.formatted(.dateTime.month().day().year())
        
        return ItemDetailView(item: item)
    }
}
