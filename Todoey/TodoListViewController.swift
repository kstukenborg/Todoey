//
//  ViewController.swift
//  Todoey
//
//  Created by Kathleen Stukenborg on 11/27/18.
//  Copyright © 2018 Kathleen Stukenborg. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Grocery Store", "Target", "PTA"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = UserDefaults.standard.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
    }

//MARK -Tableview Datasource Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        print("In tableView Number of Rows in Section")
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("In tableView cellForRowAt indexPath")

        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    // MARK - TableView Delegate Methods    override func tableVi
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if
            tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    //MARK - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert
        )
        let action = UIAlertAction(title: "Add Item", style: .default) { (action ) in
            // what will happen when the user clicks the add item button on UIAlert
            print(textField.text)
            if textField.text != ""
            {
                print("field isn't empty")
            self.itemArray.append(textField.text ?? "")
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

