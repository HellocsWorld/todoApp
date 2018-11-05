//
//  doneViewController.swift
//  todoApp
//
//  Created by Raul Serrano on 10/27/18.
//  Copyright © 2018 Raul Serrano. All rights reserved.
//

import UIKit

class DoneViewController: UITableViewController{
    
    var tasks: SaveTask?
    

    //here we access the view for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//Mark: ~create table
extension DoneViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tasks?.completedTasks.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks?.completedTasks[indexPath.row].doneTask
        return cell
        
    }
}

//MARK: -Delegate
extension DoneViewController {
    //swipe action to delete done task
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, sourceView, completionHandler) in
            
            //remove the task from the apropiate array
            self.tasks!.removeDoneTask(at: indexPath.row)
            
            //reload table view
            self.tableView.reloadData()
            
            //indicate that the action was performed
            completionHandler(true)
        }
        deleteAction.image = UIImage(named: "del")
        deleteAction.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0.1450980392, blue: 0.168627451, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
   }
}
