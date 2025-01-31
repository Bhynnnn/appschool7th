import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FirstTabView()
                .tabItem {
                    Image(systemName: "airplane")
                    Text("First")
                }
            SecondTabView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Person")
                }
        }

    }
}

#Preview {
    ContentView()
}



