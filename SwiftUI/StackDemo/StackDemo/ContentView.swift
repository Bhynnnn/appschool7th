//
//  ContentView.swift
//  StackDemo
//
//  Created by 강보현 on 1/14/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(spacing: 20, content: {
            Text("This is some text")
                .font(.largeTitle)
            Text("This is some much longer text")
                .font(.body)
            Text("This is short")
                .font(.headline)
        })
        VStack(alignment: .leading) {
                Rectangle()
                        .fill(Color.green)
                        .frame(width: 120, height: 50)
                Rectangle()
                        .fill(Color.red)
                        .alignmentGuide(.leading, computeValue: { dimensions in dimensions.width / 3 })
                        .frame(width: 200, height: 50)
                Rectangle()
                        .fill(Color.blue)
                        .alignmentGuide(.leading, computeValue: { dimensions in
                                dimensions[.trailing] + 20
                        })
                        .frame(width: 180, height: 50)
            }
    }
}

#Preview {
    ContentView()
}


