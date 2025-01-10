//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by 강보현 on 1/9/25.
//

import SwiftUI

//struct ContentView: View {
//    var colors: [Color] = [.black, .red, .green, .blue]
//    var colornames = ["Black", "Red", "Green", "Blue"]
//
//    @State private var colorIndex = 0
//    @State private var rotation: Double = 0
//    @State private var text: String = "Welcome to SwiftUI"
//    var body: some View {
//        VStack {
//            VStack {
//                Spacer()
//                Text(text)
//                    .font(.largeTitle)
//                    .fontWeight(.heavy)
//                    .rotationEffect(.degrees(rotation))
//                    .animation(.easeInOut(duration: 5), value: rotation)
//                    .foregroundStyle(colors[colorIndex])
//                Spacer()
//                Divider()
//                Slider(value: $rotation, in: 0 ... 360, step: 5.0)
//                    .padding()
//                TextField("Enter text here", text: $text).textFieldStyle(RoundedBorderTextFieldStyle())
////                Picker(selection: $colorIndex, label: Text("Color")) {
////                    ForEach (0 ..< colornames.count, id: \.self) { color in
////                        Text(colornames[color]).foregroundStyle(colors[color])
////
////                    }
////                }.pickerStyle(.wheel)
//
//                Picker(selection: $colorIndex, label: Text("Color")) {
//                    ForEach (0 ..< colornames.count, id: \.self) {
//                        Text(colornames[$0]).foregroundStyle(colors[$0])
//
//                    }
//                }.pickerStyle(.wheel)
//                    .padding()
//
//            }
//        }
//    }
//}
//
//struct ContentView: View {
//    @State private var isTapped = false
//    var body: some View {
//        Text("Tap me")
//            .font(.largeTitle)
//            .padding()
//            .background(isTapped ? Color.green: Color.red)
//            .animation(.default, value: isTapped)
//            .onTapGesture(count: 3) {
//                isTapped.toggle()
//            }
//    }
//
//}
//
//struct ContentView: View {
//    var body: some View {
//        Button(action: {
//            Task {
//                await doSomething()
//            }){
//                Text("Do something")
//            }
//        }
//               
//               
//               func doSomething() async {
//            print("Start \(Date())")
//            await takesTooLong()
//            print("End \(Date())")
//            
//        }
//               
//               func takesTooLong() async {
//            sleep(5)
//            print("Async task complete")
//        }
//               
//               }
//               }
//               
//               
//               
//               #Preview {
//            ContentView()
//        }
