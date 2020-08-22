//
//  TodoDataSource.swift
//  TodoList
//
//  Created by Petrus Souza on 11/08/20.
//  Copyright © 2020 Petrus Souza. All rights reserved.
//

import Foundation

class TodoDataSource{
    
    static let shared = TodoDataSource()
    
    private init(){}
    
    var todos: [TodoModel] = [
//        TodoModel(type: .onPriority, todoDescription: "Today we rock!!!", date: Date()),
//        TodoModel(type: .daily, todoDescription: "Today daily rock!!!", date: Date()),
//        TodoModel(type: .home, todoDescription: "Today rock at home!!!", date: Date()),
//        TodoModel(type: .daily, todoDescription: "Today daily rock!!!", date: Date()),
//        TodoModel(type: .onPriority, todoDescription: "Today we rock!!!", date: Date()),
//        TodoModel(type: .home, todoDescription: "Today rock at home!!!", date: Date())
    ]
    
    func getLastsTodoTypeModel(type: TodoModel.ModelType) -> [TodoModel] {
        var lastsTodosType: [TodoModel] = []
        for todo in todos{
            if(type == todo.type){
                lastsTodosType.append(todo)
            }
        }
        if(lastsTodosType.count > 1){
            lastsTodosType.sort {
                $0.date > $1.date
            }
        }
        if lastsTodosType.count > 3 {
            lastsTodosType = Array(lastsTodosType[0 ..< 3])
        }
        return lastsTodosType
    }
}
