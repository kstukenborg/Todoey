//
//  ViewController.swift
//  Todoey
//
//  Created by Kathleen Stukenborg on 11/27/18.
//  Copyright © 2018 Kathleen Stukenborg. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let newItem = Item()
        newItem.title = "PTSA"
        newItem.done = true
        itemArray.append(newItem)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]
        {
            itemArray = items
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
      //  if let items = UserDefaults.standard.array(forKey: "ToDoListArray") as? [String] {
       //     itemArray = items
      //  }
    }

//MARK -Tableview Datasource Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
       /* if item.done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        
        }
 */
        
        return cell
    }
    // MARK - TableView Delegate Methods    override func tableVi
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
       
        
    }
    //MARK - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert
        )
        let action = UIAlertAction(title: "Add Item", style: .default) { (action ) in
            // what will happen when the user clicks the add item button on UIAlert
            
            if textField.text != ""
            {
                let newItem1 = Item()
                newItem1.title = textField.text ?? ""
                newItem1.done = false
                print(newItem1)
            self.itemArray.append(newItem1)
                
                self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
            alert.addAction(action)
        
            present(alert, animated: true, completion: nil)
        
        
    }
    
    // try and allow swipe for delete
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            print("ready to delete")
            // handle delete (by removing the data from your array and updating the tableview)
            itemArray.remove(at: indexPath.row)
            tableView.reloadData()
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
        }
    }
    
}

