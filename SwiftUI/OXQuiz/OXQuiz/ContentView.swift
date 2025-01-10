import SwiftUI

struct ContentView: View {
    @State var number1: Int = 0
    @State var number2: Int = 0
    @State var resultNumber: Int = 0
    
    @State var countCorrect: Int = 0
    @State var countWrong: Int = 0
    
    var body: some View {
        
        // UI 구성 및 로직
        ZStack {
            LinearGradient(colors: [Color.purple.opacity(0.1), Color.white.opacity(0.1), Color.yellow.opacity(0.1)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("다음 수식은 맞을까요?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Text("\(number1) * \(number2) = \(resultNumber)")
                    .font(.largeTitle)
                    .shadow(radius: 5)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20, style: .circular).fill(Color.yellow.opacity(0.6)))
                Spacer()
                
                HStack {
                    Button(action: {
                        selectCorrect()
                    }, label: {
                        Text("⭕️")
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity)
                    })
                    Button(action: {
                        selectWrong()
                    }, label: {
                        Text("❌")
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity)
                    })
                }
                Spacer()
                HStack{
                    Text("\(countCorrect)개 맞춤")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity)
                    
                    Text("\(countWrong)개 틀림")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity)
                }
                Spacer()
                Button(action: {
                    countCorrect = 0
                    countWrong = 0
                    reloadGame()
                }) {
                    Text("초기화")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.purple.opacity(0.7))
                        )
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
    
    func reloadGame() {
        // 게임 재시작 로직
        number1 = Int.random(in: 0..<10)
        number2 = Int.random(in: 0..<10)
        resultNumber = Int.random(in: 0..<100)
        print("num1: \(number1), num2: \(number2)")
    }
    
    func selectCorrect() {
        // 정답 선택 시 로직
        print("o 눌림")
        if number1 * number2 == resultNumber {
            countCorrect += 1
        }
        else {
            countWrong += 1
        }
        reloadGame()
    }
    
    func selectWrong() {
        // 오답 선택 시 로직
        print("x 눌림")
        if number1 * number2 == resultNumber {
            countWrong += 1
        }
        else {
            countCorrect += 1
        }
        reloadGame()
    }
}

#Preview {
    ContentView()
}
