//
//  TodoViewController.swift
//  todoApp
//
//  Created by Raul Serrano on 10/27/18.
//  Copyright © 2018 Raul Serrano. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //reload date saved for todo tasks table
        if let dataFromTask = UserDefaults.standard.value(forKey: "todoTask") as? Data {
            let decoded = try? PropertyListDecoder().decode(Array<TodoTaskModel>.self, from: dataFromTask )
            UserDefaults.standard.removeObject(forKey: "todoTask")
            for deco in decoded!{
               self.saveTasks.addFromTableView(task: deco)
            }
        }
        
        //reload data saved for done task table
        if let dataFromTask = UserDefaults.standard.value(forKey: "doneTask") as? Data {
            let decoded = try? PropertyListDecoder().decode(Array<DoneTaskModel>.self, from: dataFromTask )
            UserDefaults.standard.removeObject(forKey: "doneTask")
            for deco in decoded!{
                self.saveTasks.addDone(task2: deco)
            }
        }
        
    }
    
    //Mark: ~Segue for doneview
    var saveTasks = SaveTask()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let data = saveTasks
        if let destinationViewController = segue.destination as? DoneViewController {
            destinationViewController.tasks = data
        }
    }
    
    //Mark: ~add task
    //button to get the user's input
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add new Task", message: nil, preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "add", style: .default) { _ in
            
            //get the text field
            guard let task = alertController.textFields?.first?.text else  {return}
            
            //create a new task
           let newTask = TodoTaskModel(todoTask: task)
            
            //add the task
            self.saveTasks.addFromTableView(task: newTask)
            
            //reload the table
            self.tableView.reloadData()
            
        }
        
        addAction.isEnabled = false
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        
        //add the txt field
        alertController.addTextField { textField in
            textField.placeholder = "Enter task name..."
            textField.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
            
        }
        //add the actions
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        //present makes the add box pop when plus is pushed
        present(alertController, animated: true)
    }
    
    @objc private func handleTextChanged(_ sender: UITextField) {
        // grab the alert controller and add action
        guard let alertController = presentedViewController as? UIAlertController,
            let addAction = alertController.actions.first,
            let text = sender.text
            else{return}
        
        //enable add action based on if text is empty or contains whitespace
        addAction.isEnabled = !text.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

//Mark: ~create table
//the function gets the array and creates the table with the values in the array
extension TodoViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saveTasks.notCompletedTasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = saveTasks.notCompletedTasks[indexPath.row].todoTask
        return cell

    }
  }

//MARK: -swipe action
extension TodoViewController {
    //this is a righ side app action to delete or edit a task
   override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, sourceView, completionHandler) in
         //remove the task from the apropiate array
         self.saveTasks.removeTask(at: indexPath.row)
        
         //reload table view
         self.tableView.reloadData()
        
         //indicate that the action was performed
         completionHandler(true)
      }
      deleteAction.image = UIImage(named: "del")
      deleteAction.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0.1450980392, blue: 0.168627451, alpha: 1)
        
      let editAction = UIContextualAction(style: .destructive, title: nil) { (action, sourceView, completionHandler) in
        //create a pop up alert to edit the task
        let alert = UIAlertController(title: "Edit Task", message: nil, preferredStyle: .alert)
                alert.addTextField(configurationHandler: { (textField) in
                   textField.text = self.saveTasks.notCompletedTasks[indexPath.row].todoTask
                })
                alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
                    guard let updatedTask = alert.textFields?.first?.text else { return}
                    let updated = TodoTaskModel(todoTask: updatedTask)
                    self.saveTasks.updateEditedTask(index: indexPath.row, task: updated)
                    self.tableView.reloadData()
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: false)
        
            //indicate that the action was performed
            completionHandler(true)
        }
        editAction.image = UIImage(named: "edit")
        editAction.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    //this is the left swipe action to mark the task as done
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let doneAction = UIContextualAction(style: .normal, title: nil) {(action, sourceView, completionHandler) in
            //remove the task from array containing todo tasks
            let doneTask = self.saveTasks.removeTask(at: indexPath.row).todoTask
            
            //reload table view
            self.tableView.reloadData()
            
            //add the task from the array containing done tasks
            let newTask = DoneTaskModel(doneTask: doneTask)
            self.saveTasks.addSavedDone(task2: newTask)
           
            //indicate the action was performed
            completionHandler(true)
            
        }
        
        doneAction.image = UIImage(named: "done")
        // to add a background color use Color literal
        doneAction.backgroundColor = #colorLiteral(red: 0.4128166437, green: 0.9977981448, blue: 0, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [doneAction])
    }
}
