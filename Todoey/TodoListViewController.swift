//
//  ViewController.swift
//  Todoey
//
//  Created by Lee Jordan Bernardo on 10/27/18.
//  Copyright © 2018 Lee Jordan Bernardo. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Item 1", "Item 2", "Item 3"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
            //
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item..."
            textField = alertTextField
        }
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}


