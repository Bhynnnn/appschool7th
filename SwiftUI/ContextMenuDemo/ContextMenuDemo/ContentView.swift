//
//  ContentView.swift
//  ContextMenuDemo
//
//  Created by 강보현 on 1/15/25.
//

import SwiftUI

struct ContentView: View {
    @State private var foregroundColor: Color = Color.black
    @State private var backgroundColor: Color = Color.white
    var body: some View {
        Text("Hello, World!")
            .padding()
            .font(.largeTitle)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .contextMenu {
                Button(action: {
                    self.backgroundColor = .white
                    self.foregroundColor = .black
                }, label: {
                    Text("Normal Colors")
                        
                    Image(systemName: "paintbrush")
                })
                Button(action: {
                    self.foregroundColor = .white
                    self.backgroundColor = .black
                }, label: {
                    Text("Inverted Colors")
                    Image(systemName: "paintbrush.fill")
                })
            }
    }
}

#Preview {
    ContentView()
}
