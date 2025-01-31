//
//  ContentView.swift
//  MacTimer
//
//  Created by 강보현 on 1/24/25.
//

import SwiftUI

struct AlwaysOnTopView: NSViewRepresentable {
    let window: NSWindow
    let isAlwaysOnTop: Bool
    
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            // 초기 크기 설정
            let screenFrame = NSScreen.main?.visibleFrame ?? .zero
            let initialSize = CGSize(width: 300, height: 200)
            let newOrigin = CGPoint(x: screenFrame.midX - initialSize.width / 2,
                                    y: screenFrame.midY - initialSize.height / 2)
            window.setFrame(CGRect(origin: newOrigin, size: initialSize), display: true)
        }
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        DispatchQueue.main.async {
            if isAlwaysOnTop {
                window.level = .floating
            } else {
                window.level = .normal
            }
            // 좌상단에 위치시키기
            let screenFrame = NSScreen.main?.visibleFrame ?? .zero
            let windowSize = window.frame.size
            let newOrigin = CGPoint(x: screenFrame.minX, y: screenFrame.maxY - windowSize.height)
            window.setFrameOrigin(newOrigin)
        }
        
    }
}

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme // 현재 색상 모드 감지
    @State private var timeRemaining : Int = 10 // 초 단위
    @State private var isRunning: Bool = false
    @State private var totalTime: Int = 10
    @State private var isOnTop = true
    @State var hourSelection = 0
    @State var minuteSelection = 0
    @State var secondSelection = 0
    
    var hours = [Int](0..<24)
    var minutes = [Int](0..<60)
    var seconds = [Int](0..<60)
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 30) {
            
            HStack {
                Picker(selection: $hourSelection, label: Text("")) {
                    ForEach(0..<24) { index in
                        Text("\(hours[index]) 시간").tag(index)
                    }
                }
                .frame(width: 100)
                
                Picker(selection: $minuteSelection, label: Text("")) {
                    ForEach(0..<60) { index in
                        Text("\(minutes[index]) 분").tag(index)
                    }
                }
                .frame(width: 100)
                
                Picker(selection: $secondSelection, label: Text("")) {
                    ForEach(0..<60) { index in
                        Text("\(seconds[index]) 초").tag(index)
                    }
                }
                .frame(width: 100)
                
                Button(){
                    isOnTop.toggle()
                } label: {
                    Image(systemName: isOnTop ? "pin.fill" : "pin.slash")
                        .foregroundColor(colorScheme == .dark ? .yellow : .black)
                    
                }.buttonStyle(PlainButtonStyle())
            }
            .pickerStyle(.automatic)
            .onChange (of: [hourSelection, minuteSelection, secondSelection]){
                timeRemaining = (hourSelection * 3600) + (minuteSelection * 60) + secondSelection
                totalTime = (hourSelection * 3600) + (minuteSelection * 60) + secondSelection
            }
            
            Text("\(String(format: "%02d", timeRemaining / 60)):\(String(format: "%02d", timeRemaining % 60))")
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(colorScheme == .dark ? .white : .black) // 텍스트 색상
            
            ProgressView(value: Float(timeRemaining), total: Float(totalTime))
                .progressViewStyle(MyCustomProgressViewStyle())
            HStack {
                Button(action: {
                    isRunning.toggle()
                }, label: {
                    Image(systemName: isRunning ? "pause.fill" : "play.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:10, height:10)
                        .padding()
                })
                
                Button(action: {
                    timeRemaining = (hourSelection * 3600) + (minuteSelection * 60) + secondSelection
                    if isRunning {
                        isRunning.toggle()
                    }
                    
                }, label: {
                    Image(systemName: "arrow.clockwise")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:10,height:10)
                        .padding()
                })
            }
        }
        .padding()
        .background(AlwaysOnTopView(window: NSApplication.shared.windows.first!, isAlwaysOnTop: isOnTop))
        .onReceive(timer) { t in
            print("timer tick \(t)")
            if isRunning && timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isRunning = false
                isOnTop = isRunning
            }
            if timeRemaining == 0 {
                NSSound.beep()
            }
        }
        
        
    }
    
    
    //    let workoutDateRange = Date()...Date().addingTimeInterval(100)
    
    //            ProgressView(timerInterval: workoutDateRange) {
    //                Text("Workout")
    //
    //            }
}

#Preview {
    ContentView()
}


struct MyCustomProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0 // 현재 진행률
        // 여백을 제외한 ProgressBar 너비
        VStack {// 마라톤 주자
            Image(systemName: "figure.walk")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .offset(x: -1 * progress * 300 + 160) // 진행률에 따라 화면 안에서 이동
                .animation(.easeInOut(duration: 0.5), value: progress) // 애니메이션 추가
            
            ZStack(alignment: .leading) {
                // 진행률에 따른 색상 채우기
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.yellow) // 색상 설정
                    .frame(width: -1 * 300 * CGFloat(progress), height: 2)
                    .animation(.easeInOut(duration: 0.5), value: -1 * progress)
                // ProgressBar 배경
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 300, height: 2)
                
                
                
            }
        }
    }
}
