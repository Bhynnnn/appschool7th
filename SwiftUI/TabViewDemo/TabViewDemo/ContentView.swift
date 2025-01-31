//
//  ContentView.swift
//  TabViewDemo
//
//  Created by 강보현 on 1/15/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("First Content View")
                .tabItem{
                    Image(systemName: "1.circle")
                    Text("Screen One")
                }
                .tag(0)
            Text("Second Content View")
                .tabItem{
                    Image(systemName: "2.circle")
                    Text("Screen Two")
                }.tag(1)
            Text("Third Content View")
                .tabItem{
                    Image(systemName: "3.circle")
                    Text("Screen Three")
                }.tag(2)
                .font(.largeTitle)
                .tabViewStyle(PageTabViewStyle())
        }
    }
}

#Preview {
    ContentView()
}
