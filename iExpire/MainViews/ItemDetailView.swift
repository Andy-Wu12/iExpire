//
//  ItemDetailView.swift
//  iExpire
//
//  Created by Andy Wu on 1/21/23.
//

import SwiftUI
import CoreData

struct ItemDetailView: View {
    @Environment(\.verticalSizeClass) var vsc
    
    @ObservedObject var item: Item
    
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    if vsc == .regular {
                        ItemDetailPortrait(item: item)
                    }
                    else {
                        ItemDetailLandscape(item: item)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isEditing = true
                } label: {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            ItemEditView(item: item)
        }
    }
}

struct ItemDetailPortrait: View {
    @ObservedObject var item: Item

    private let cornerRadius: CGFloat = 20
    
    var body: some View {
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
            
            if !item.wrappedNotes.isEmpty {
                Section {
                    Text(item.wrappedNotes)
                } header: {
                    Text("Notes")
                        .fontWeight(.heavy)
                        .padding(.top)
                }
            }
            
            Section {
                ExpirationTextView(expirationDate: item.wrappedDateTime)
                    .font(.custom("San Francisco", size: 50, relativeTo: .largeTitle))
            } header: {
                Text("Expiration Date")
                    .fontWeight(.heavy)
                    .padding(.top)
            }
            
            ConditionalSpacer(isOn: item.image == nil)
        }
        .padding([.trailing, .leading])
        .frame(maxWidth: .infinity)
    }
}

struct ItemDetailLandscape: View {
    @ObservedObject var item: Item
    
    private let cornerRadius: CGFloat = 20
    
    var body: some View {
        VStack {
            Text(item.wrappedName)
                .font(.largeTitle)
            
            HStack {
                LoadedImageView(imageData: item.image)
                    .cornerRadius(cornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color("UniversalPurple"), lineWidth: 4)
                    )
                    .shadow(color: Color("UniversalPurple"), radius: 10)
                    .padding()
                
                VStack {
                    if !item.wrappedNotes.isEmpty {
                        Section {
                            Text(item.wrappedNotes)
                        } header: {
                            Text("Notes")
                                .fontWeight(.heavy)
                                .padding(.top)
                        }
                    }
                    
                    Section {
                        ExpirationTextView(expirationDate: item.wrappedDateTime)
                            .font(.custom("San Francisco", size: 50, relativeTo: .largeTitle))
                    } header: {
                        Text("Expiration Date")
                            .fontWeight(.heavy)
                            .padding(.top)
                    }
                }
            }
        }
        .padding([.trailing, .leading])
        .frame(maxWidth: .infinity)
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let item = Item(context: moc)
        item.name = "Bananas"
        item.expirationDate = dateToFormatString(date: Date.now)
        
        return ItemDetailView(item: item)
    }
}
