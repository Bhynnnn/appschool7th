import SwiftUI
import SwiftData

struct ResultView: View {
    var searchTitle: String // 검색 키워드
    @Environment(\.modelContext) var modelContext
    @State private var matches: [TodoItem] = [] // 검색된 결과
    
    var body: some View {
        NavigationStack {
            VStack {
                if matches.isEmpty {
                    Text("No results found")
                        .font(.headline)
                        .padding()
                } else {
                    List(matches) { todo in
                        HStack {
                            Text(todo.title ?? "nothing")
                                .font(.headline)
                            Spacer()
                            Text(todo.date, format: Date.FormatStyle(date: .numeric, time: .shortened))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Search Results")
            .task {
                fetchResults() // 검색 결과 가져오기
            }
        }
    }
    
    private func fetchResults() {
        let descriptor = FetchDescriptor<TodoItem>(predicate: #Predicate<TodoItem> { todo in
            todo.title?.contains(searchTitle) ?? false
        })
        do {
            matches = try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching products: \(error)")
            matches = []
        }
    }
}

#Preview {
    ResultView(searchTitle: "test")
        .modelContainer(for: TodoItem.self, inMemory: true)
}
