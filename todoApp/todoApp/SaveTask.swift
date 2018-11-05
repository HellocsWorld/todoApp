//
//  SaveTask.swift
//  todoApp
//
//  Created by Raul Serrano on 10/28/18.
//  Copyright © 2018 Raul Serrano. All rights reserved.
//

import Foundation

class SaveTask {
    
    //this array will store the task
    var notCompletedTasks:[TodoTaskModel] = []//for todo tasks
    var completedTasks:[DoneTaskModel] = []//for done tasks
    
    //add tasks from user input
    func addFromTableView(task: TodoTaskModel) {
        notCompletedTasks.append(task)
        updateSavedData()
    
    }
    
    //add task from data saved in phone
    func addFromSavedData(task: TodoTaskModel) {
        notCompletedTasks.append(task)
        updateSavedData()
    }
    
    //function to edit the tasks
    func updateEditedTask(index: Int, task: TodoTaskModel){
        if(task.todoTask == ""){
            return
        }else{
            notCompletedTasks[index] = task
            updateSavedData()
        }
    
    }
    
    //remove tasks
    @discardableResult func removeTask(at index: Int) -> TodoTaskModel {
      let removedTask = notCompletedTasks.remove(at: index)
        updateSavedData()
        return removedTask
    }
    
    //this fucntion saves the data when new data is added or changed in the arrays
    func updateSavedData(){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(notCompletedTasks), forKey: "todoTask")
    }
    //this fucntion saves the data when new data is added or changed in the arrays
    func updateSavedDoneData(){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(completedTasks), forKey: "doneTask")
    }
   
    //add tasks to completed tasks array
    func addDone(task2: DoneTaskModel) {
        completedTasks.append(task2)
        updateSavedDoneData()       
    }
    
    //add tasks to completed task array from saved data
   func addSavedDone(task2: DoneTaskModel) {
        completedTasks.append(task2)
        updateSavedDoneData()
    }
    
    //remove tasks on completed array
    @discardableResult func removeDoneTask(at index: Int) -> DoneTaskModel {
       let removeDone = completedTasks.remove(at: index)
        updateSavedDoneData()
        return removeDone
    }
    
}
