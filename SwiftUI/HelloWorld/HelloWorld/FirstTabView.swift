import SwiftUI

struct FirstTabView: View {
    @State var title = "View One"
    var body: some View {
            Text(title) // 첫 번째 텍스트
                .onAppear(perform: {
                    print("text 1 onAppear triggered")
                })
                .onDisappear(perform: {
                    print("text 1 onDisappeared triggered")
                })
                .task(priority: .background) {
                    print("text 1 task executed")
                    title = await changetitle()
                }
            
//            Text("This is another text!")  두 번째 텍스트
    }
    
    func changetitle() async -> String {
        do {
            try await Task.sleep(nanoseconds: 5_000_000_000)
        } catch {
            print("Error: \(error)")
            return "View One"
        }
        return "Async task complete"
    }
}
