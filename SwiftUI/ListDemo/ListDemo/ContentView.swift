//
//  ContentView.swift
//  ListDemo
//
//  Created by 강보현 on 1/14/25.

import SwiftUI

// Identifiable 프로토콜을 준수하는 ToDoItem 구조체 정의
// UUID를 통해 각 항목을 고유하게 식별
struct ToDoItem: Identifiable, Hashable {
    let id: UUID = UUID()  // 자동으로 생성되는 고유 식별자
    var task: String       // 할 일 텍스트
    var imageName: String  // SF Symbols 이미지 이름
}

struct ContentView: View {
    // 토글 상태를 저장하는 State 변수
    @State var toggleStatus: Bool = false
    
    // ToDo 항목들을 저장하는 State 배열
    @State var listData: [ToDoItem] = [
        ToDoItem(task: "Take out trash", imageName: "trash.circle.fill"),
        ToDoItem(task: "Pick up the kids", imageName: "person.2.fill"),
        ToDoItem(task: "Wash the car", imageName: "car.fill")
    ]
    
    var body: some View {
        NavigationStack {
            List {
                // 설정 섹션
                Section(header: Text("Settings")) {
                    // 알림 허용 토글 스위치
                    Toggle(isOn: $toggleStatus) {
                        Text("Allow Notifications")
                    }
                    
                    NavigationLink(value: listData.count) {
                        Text("View Task Count")
                    }
                }
                
                // ToDo 태스크 섹션
                Section(header: Text("To Do Tasks")) {
                    // listData 배열의 각 항목을 순회하며 표시
                    ForEach(listData) { item in
                        HStack {
                            Image(systemName: item.imageName)  // SF Symbols 이미지
                            Text(item.task)                    // 할 일 텍스트
                        }
                    }.onDelete(perform: deleteItem)
                        .onMove(perform: moveItem)
                }
            }
            // 네비 바 타이틀 지정
            .navigationTitle(Text("Todo List"))
            //        .navigationBarItems(trailing: Button("Add", action: {}))
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading, content: {
                    EditButton()
                })
                ToolbarItem(placement: .primaryAction, content: {
                    Button("Add", action: {})
                })
            })
            
            // 네이 바 스타일 변경
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: ToDoItem.self) { item in
                // GET ToDoItem
                Text("Number of tasks \(item.task) \(item.id)" )
            }
            .navigationDestination(for: Int.self) { count in
                Text("Number of tasks: \(count)")
            }
            .navigationDestination(for: String.self) { task in
                VStack {
                    Text("Selected Task: \(task)")
                }
            }
            
            // 당겨서 새로고침 기능 추가
            .refreshable {
                // 새로운 ToDo 항목들로 리스트 갱신
                listData = [
                    ToDoItem(task: "Order sddddd", imageName: "dollarsign.circle.fill"),
                    ToDoItem(task: "Call financial advisor", imageName: "phone.fill"),
                    ToDoItem(task: "Sell the kids", imageName: "person.2.fill")
                ]
            }
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        print("delete item: \(offsets)")
        listData.remove(atOffsets: offsets)
        
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        print("source: \(source), destination: \(destination)")
        listData.move(fromOffsets: source, toOffset: destination)
    }
}

#Preview {
    ContentView()
}
