//
//  ViewController.swift
//  TableCellData
//
//  Created by PARMJIT SINGH KHATTRA on 30/5/20.
//  Copyright © 2020 PARMJIT SINGH KHATTRA. All rights reserved.
//

import UIKit
class customCell: UITableViewCell {
    
    
    @IBOutlet weak var customCategoryCell: UIView!
    
    
    @IBAction func colourButtonPressed(_ sender: UIButton) {
        customCategoryCell.backgroundColor = .systemGreen
    }
    
    @IBAction func ClearColourButtonPressed(_ sender: UIButton) {
        customCategoryCell.backgroundColor = .none
    }
    
}


class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var category = [Category]()
    let constant = Constant()
    
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("category.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constant.categoryCell , for: indexPath)
        cell.textLabel?.text = category[indexPath.row].name
        return cell
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

