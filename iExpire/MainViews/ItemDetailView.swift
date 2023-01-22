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
    
    private let cornerRadius: CGFloat = 20
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(item.wrappedName)
                    .font(.largeTitle)
                
                ConditionalSpacer(isOn: item.image == nil)
                
                LoadedImageView(imageData: item.image)
                    .cornerRadius(cornerRadius)
                    .overlay(
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(Color("UniversalPurple"), lineWidth: 4)
                        )
                    .shadow(color: Color("UniversalPurple"), radius: 10)
                    .padding()
                
                Section {
                    Text(item.wrappedExpiration)
                        .font(.custom("San Francisco", size: 50, relativeTo: .largeTitle))
                } header: {
                    Text("Expiration Date")
                }
                
                ConditionalSpacer(isOn: item.image == nil)
            }
            .frame(maxWidth: .infinity)
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
