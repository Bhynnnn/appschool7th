//
//  Item.swift
//  TodoList
//
//  Created by 강보현 on 1/17/25.
//

import Foundation
import SwiftData

@Model
final class TodoItem {
    var title: String?
    var isCompleted: Bool = false
    var date: Date = Date()
    
    init(title: String) {
        self.title = title
    }
}
