import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .font(.largeTitle)
            .border(Color.black)
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity, alignment: .center)
            .background(Color.blue)
            .ignoresSafeArea()

    }
}

#Preview {
    ContentView()
}
