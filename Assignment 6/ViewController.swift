//
//  ViewController.swift
//  assingment 6
//
//  Created by mohak on 18/02/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,
                      UITableViewDataSource {
    @IBOutlet weak var nameTableView: UITableView!
    
    var customDataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTableView.delegate = self
        nameTableView.dataSource = self
        getAllData()
    }
    
    
    @IBAction func plusclicked(_ sender: Any) {let avc = UIAlertController(title: "Add Your Task", message: nil, preferredStyle: .alert)
        
                avc.addTextField { (textField) in
                    textField.placeholder = "Write the task you want to do"
                }
        
                let addAction = UIAlertAction(title: "OKAY", style: .default) { (action) in
                    if let textField = avc.textFields?.first,
                       let enteredText = textField.text,
                       enteredText != "" {
                        self.customDataSource.append(enteredText)
                        UserDefaults.standard.set(self.customDataSource, forKey: "SavedData")
                        self.nameTableView.reloadData()
                    }
        
                }
                avc.addAction(addAction)
                let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
        
                avc.addAction(cancelAction)
                self.present(avc, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MohakTableView", for: indexPath)
        cell.textLabel?.text = customDataSource[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteanItem = customDataSource[indexPath.row]
            delete(data: deleteanItem)
            customDataSource.remove(at: indexPath.row)
            nameTableView.reloadData()
        }
    }
    func delete(data: String) {
        let defaults = UserDefaults.standard
        if var savedData = defaults.object(forKey: "SavedData") as? [String] {
            savedData.removeAll { $0 == data }
            defaults.set(savedData, forKey: "SavedData")
        }
    }
    
    func getAllData()  {
        let defaults = UserDefaults.standard
        if let value = defaults.object(forKey: "SavedData") as? [String] {
            customDataSource = value
        }
        nameTableView.reloadData()
    }
}

