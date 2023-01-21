//
//  util.swift
//  iExpire
//
//  Created by Andy Wu on 1/21/23.
//

import SwiftUI
import PhotosUI

struct PhotoSelectorView: View {
    @State private var selectedImageData: Data? = nil
    
    @Binding var selectedItem: PhotosPickerItem?
    
    // Optionally provide Binding to get Data of image for the calling View
    var imageData: Binding<Data?>? = nil
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            Text("Select Photo")
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                // Retrieve selected asset in the form of Data
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    selectedImageData = data
                    imageData?.wrappedValue = selectedImageData
                }
            }
        }
        
        if selectedImageData != nil {
            LoadedImageView(imageData: selectedImageData)
                .frame(width: 250, height: 250)
        }
    }
}

struct LoadedImageView: View {
    var imageData: Data?
    
    var body: some View {
        if let imageData,
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        }
    }
}
