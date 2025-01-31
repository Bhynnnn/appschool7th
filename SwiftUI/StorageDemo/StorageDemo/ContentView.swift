//
//  ContentView.swift
//  StorageDemo
//
//  Created by 강보현 on 1/13/25.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("city") var city: String = ""
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            TextEditor(text: $city).padding().border(Color.blue)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
