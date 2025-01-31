//
//  TodoGroup.swift
//  TodoList
//
//  Created by 강보현 on 1/17/25.
//

import Foundation
import SwiftData

@Model
final class TodoGroup: Identifiable{
    var id = UUID()
    var gTitle: String
    var tasks: [TodoItem] = []
    
    init(gTitle: String) {
        self.gTitle = gTitle
    }
}
