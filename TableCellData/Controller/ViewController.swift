//
//  ViewController.swift
//  TableCellData
//
//  Created by PARMJIT SINGH KHATTRA on 30/5/20.
//  Copyright © 2020 PARMJIT SINGH KHATTRA. All rights reserved.
//

import UIKit
import SwipeCellKit
//protocol CellDelegate {
//
//}
//class customCell: UITableViewCell {
//    
//    
//    @IBOutlet weak var customCategoryCell: UIView!
//    
//    
//    @IBAction func colourButtonPressed(_ sender: UIButton) {
//        customCategoryCell.backgroundColor = .systemGreen
//        
//        
//    }
//    
//    @IBAction func ClearColourButtonPressed(_ sender: UIButton) {
//        customCategoryCell.backgroundColor = .none
//    }
//}


class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var category = [Category]()
    let constant = Constant()
    
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("category.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: constant.categoryCell)
        
        //print("just cheking branch operations")
        tableView.rowHeight = 70.00
        loadCategory()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: constant.categoryCell , for: indexPath) as! CustomCell
        
        //cell.delegate = self
//        let button = UIButton()
//
//        cell.accessoryView = button
//        button.addTarget(self, action: #selector(didButtonPressed(_ :)), for: .touchUpInside)
//        //mySwitch.addTarget(self, action: #selector(didChangeSwitch(_ :)), for: .valueChanged)
        cell.textLabel?.text = category[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "add category", message: "name", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.done = false
            self.category.append(newCategory)
            self.saveCategory()
            
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Category"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
        
    }
    func loadCategory() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                category = try decoder.decode([Category].self, from: data)
            }
            catch {
                print("error indecoding\(error)")
            }
        }
        
    }
    func saveCategory() {
        let encodable = PropertyListEncoder()
        do {
            let data = try encodable.encode(category)
        try data.write(to: dataFilePath!)
        } catch {
            print("error in encoding\(error)")
        }
        
        tableView.reloadData()
    }
    
    
}
// MARK:- swipe cell delegate method
extension ViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.category.remove(at: indexPath.row)
            print("item deleted")
         //tableView.reloadData()
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")

        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        //options.transitionStyle = .border
        return options
    }
}
