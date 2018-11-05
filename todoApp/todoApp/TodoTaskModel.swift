//
//  TaskModel.swift
//  todoApp
//
//  Created by Raul Serrano on 10/27/18.
//  Copyright © 2018 Raul Serrano. All rights reserved.
//

import Foundation

class TodoTaskModel: Codable {
    var todoTask: String
    
    init(todoTask: String){
        self.todoTask = todoTask
    }
    
}

class DoneTaskModel: Codable {
    var doneTask: String
    
    init(doneTask: String){
        self.doneTask = doneTask
    }
    
}
