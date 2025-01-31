//
//  ContentView.swift
//  GestureDemo
//
//  Created by 강보현 on 1/15/25.
//

import SwiftUI

struct ContentView: View {
    let tap = TapGesture(count: 2)
        .onEnded({ _ in
            print("Double Tap")
        })
    let longPress = LongPressGesture()
        .onEnded({_ in
            print("Long Press")
        })
    @GestureState var magnificationScale: CGFloat = 2
    
    var body: some View {
        let magnification = MagnificationGesture(minimumScaleDelta: 1)
            .updating($magnificationScale) { value, state, transaction in
                state = value
                print("Magnifying")
            }
//            .onChanged({value in
//                print("Magnifying Change: \(value)")
//                self.magnificationScale = value
//            })
            .onEnded{ _ in
                print("Magnifying End")
            }
        
        Image(systemName: "hand.point.right.fill")
            .gesture(tap)
            .gesture(longPress)
            .scaleEffect(magnificationScale)
            .gesture(magnification)
            .frame(width: 100, height: 90)
    }
}

#Preview {
    ContentView()
}
