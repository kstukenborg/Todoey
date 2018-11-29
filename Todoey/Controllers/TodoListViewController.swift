//
//  ViewController.swift
//  Todoey
//
//  Created by Kathleen Stukenborg on 11/27/18.
//  Copyright © 2018 Kathleen Stukenborg. All rights reserved.
//

import UIKit
import CoreData


class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   //let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
       print(dataFilePath)
        loadItems()
        
      // loadItems()
      //  let newItem = Item()
      //  newItem.title = "PTSA"
      //  newItem.done = true
      //  itemArray.append(newItem)
        
     /*   if let items = defaults.array(forKey: "ToDoListArray") as? [Item]
        {
            itemArray = items
        }
        */
        
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
        self.saveItems()
        
       
        
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
                
                
                let newItem = Item(context: self.context)
                newItem.title = textField.text ?? ""
                newItem.done = false
                
            self.itemArray.append(newItem)
                self.saveItems()
                
                
                
               // self.defaults.set(self.itemArray, forKey: "ToDoListArray")
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
    
    //MARK - Model Manipulation Methods
    
    func saveItems() {
        
        do {
           try context.save()
            
        } catch {
            print("error saving context array, \(error)")
        }
        self.tableView.reloadData()
    }
    
    /* func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode( [Item].self, from: data)
            } catch {
                print("Error decoding item \(error)")
            }
    }
    } */
    
    func loadItems() {
        let request : NSFetchRequest<Item> =  Item.fetchRequest()
        do {
            try itemArray = context.fetch(request) //blank and so it will bring it all back
            print("Fetching items")
    }
        catch {
            print("error fetching data from context \(error)")
        }
    }
    // try and allow swipe for delete
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            print("ready to delete")
            // handle delete (by removing the data from your array and updating the tableview)
            
            
            context.delete(itemArray[indexPath.row])
            itemArray.remove(at: indexPath.row)
            saveItems() 
           // self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
        }
    }
    
}

