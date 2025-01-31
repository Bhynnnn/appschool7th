//
//  SecondTabView.swift
//  HelloWorld
//
//  Created by 강보현 on 1/13/25.
//

import SwiftUI

struct SecondTabView: View {
    @State private var text: String = ""
    var body: some View {
        TextEditor(text: $text)
            .padding()
            .onChange(of: text, perform: { value in
                print("onChange triggered")
            })
        
    }
}
