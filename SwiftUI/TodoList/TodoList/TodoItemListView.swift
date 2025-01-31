import SwiftUI

struct TodoItemListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var title = ""
    @State private var searchText = "" // 검색어
    let selectedGroup: TodoGroup
    @State private var selectedTask: TodoItem?
    
    var body: some View {
        // 검색 및 추가 필드
        VStack {
            HStack {
                Text("Todo List")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }.padding([.top, .leading], 10)
            // 검색 필드
            HStack {
                
                
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.black)
            }.padding()
            
            
            // 입력 필드와 추가 버튼
            HStack {
                TextField("New Task", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    addTask()
                }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
        }
        .background(Color(UIColor.clear)) // 배경색 추가
        .padding(.vertical)
        .zIndex(1) // 상단 고정
        
        // 검색된 Todo 목록
        List {
            ForEach(filteredTasks) { task in
                HStack {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .onTapGesture {
                            toggleTodoCompletion(task)
                        }
                    Spacer()
                    Text(task.title ?? "Unnamed Task")
                    Spacer()
                    Text(task.date, format: Date.FormatStyle(date: .numeric, time: .shortened))
                }
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                    Button("Edit") {
                        editTask(task: task)
                    }
                }
            }
            .onDelete(perform: deleteTask)
            
        }
        .scrollContentBackground(.hidden)
        .background(Color.white)
        .sheet(item: $selectedTask) { task in
            EditTaskView(
                task: task,
                onSave: { updatedTitle in
                    updateTaskTitle(task: task, newTitle: updatedTitle)
                    selectedTask = nil // 닫기
                },
                onCancel: {
                    selectedTask = nil // 닫기
                }
            )
            .presentationDetents([.medium, .fraction(0.3)])

        }
        
    }
    
    // 필터링된 Task 리스트
    private var filteredTasks: [TodoItem] {
        if searchText.isEmpty {
            return selectedGroup.tasks
        } else {
            return selectedGroup.tasks.filter { task in
                task.title?.localizedCaseInsensitiveContains(searchText) ?? false
            }
        }
    }
    
    // Task 추가
    private func addTask() {
        guard !title.isEmpty else { return }
        let newTodo = TodoItem(title: title)
        selectedGroup.tasks.append(newTodo)
        modelContext.insert(newTodo)
        title = ""
    }
    
    // Task 삭제
    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(selectedGroup.tasks[index])
        }
    }
    
    // Task 완료 상태 토글
    private func toggleTodoCompletion(_ task: TodoItem) {
        task.isCompleted.toggle()
    }
    
    private func editTask(task: TodoItem) {
        selectedTask = task
    }
    
    private func updateTaskTitle(task: TodoItem, newTitle: String) {
        task.title = newTitle
        task.date = Date()
    }
}

#Preview {
    TodoItemListView(selectedGroup: TodoGroup(gTitle: "test"))
}

struct EditTaskView: View {
    @State private var updatedTitle: String
    var task: TodoItem
    var onSave: (String) -> Void
    var onCancel: () -> Void
    
    init(task: TodoItem, onSave: @escaping (String) -> Void, onCancel: @escaping () -> Void) {
        self.task = task
        self.onSave = onSave
        self.onCancel = onCancel
        _updatedTitle = State(initialValue: task.title ?? "")
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Edit Task Title", text: $updatedTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .navigationTitle("Edit Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        onCancel()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(updatedTitle)
                    }
                }
            }
        }
    }
}
