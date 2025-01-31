//
//  ContentView.swift
//  UIViewControllerDemo
//
//  Created by 강보현 on 1/23/25.
//

import SwiftUI

struct ContentView: View {
    @State var selectedImage: Image? = Image(systemName: "photo")
    @State var imagePickerVisiable: Bool = false
    
    var body: some View {
        VStack {
            selectedImage?
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button(action: {
                withAnimation{
                    self.imagePickerVisiable.toggle()
                    
                }
            }, label: {
                Text("select an image")
            })
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .sheet(isPresented: $imagePickerVisiable) { MyImagePicker(imagePickerVisiable: $imagePickerVisiable, selectedImage: $selectedImage)
        }
    }
    
}

#Preview {
    ContentView()
}
