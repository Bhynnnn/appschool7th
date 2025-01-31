import SwiftUI
import SwiftData

struct GroupListView: View {
    @State private var gTitle: String = ""
    @Environment(\.modelContext) private var modelContext
    @Query private var todoGroups: [TodoGroup]
    @State private var selectedGroup: TodoGroup?

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Todo Group", text: $gTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: .infinity)
                    Button(action: {
                        addGroup()
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                }
                .padding()

                List {
                    ForEach(todoGroups) { group in
                        NavigationLink(value: group) {
                            ListCell(group: group)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button("Edit") {
                                editGroup(group: group)
                            }
                        }
                    }
                    .onDelete(perform: deleteGroup)
                }
                .scrollContentBackground(.hidden)
                .background(Color.white)
            }
            
            .navigationTitle("Todo Groups")
            .navigationDestination(for: TodoGroup.self) { group in
                TodoItemListView(selectedGroup: group)
            }
            .sheet(item: $selectedGroup) { group in
                EditGroupView(
                    group: group,
                    onSave: { updatedTitle in
                        updateGroupTitle(group: group, newTitle: updatedTitle)
                        selectedGroup = nil // 저장 후 sheet 닫기
                    },
                    onCancel: {
                        selectedGroup = nil // 취소 후 sheet 닫기
                    }
                )
                .presentationDetents([.medium, .fraction(0.3)])
            }
            
            .padding()
        }
    }

    private func addGroup() {
        guard !gTitle.isEmpty else { return }
        let newGroup = TodoGroup(gTitle: gTitle)
        modelContext.insert(newGroup)
        gTitle = ""
    }

    private func deleteGroup(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(todoGroups[index])
        }
    }

    private func editGroup(group: TodoGroup) {
        selectedGroup = group
    }

    private func updateGroupTitle(group: TodoGroup, newTitle: String) {
        group.gTitle = newTitle
    }
}

struct ListCell: View {
    var group: TodoGroup

    var body: some View {
        Text(group.gTitle)
            .font(.headline)
    }
}

struct EditGroupView: View {
    var group: TodoGroup
    var onSave: (String) -> Void
    var onCancel: () -> Void // 취소 동작 추가

    @State private var updatedTitle: String

    init(group: TodoGroup, onSave: @escaping (String) -> Void, onCancel: @escaping () -> Void) {
        self.group = group
        self.onSave = onSave
        self.onCancel = onCancel
        _updatedTitle = State(initialValue: group.gTitle)
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Group Title", text: $updatedTitle)
            }
            .navigationTitle("Edit Group")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(updatedTitle)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        onCancel()
                    }
                }
            }
        }
    }
}

#Preview {
    GroupListView()
        .modelContainer(for: [TodoGroup.self, TodoItem.self], inMemory: true)
}
