//
//  ViewController.swift
//  ProjectShoppingList
//
//  Created by Eduardo Maestri Righes on 24/05/2021.
//

import UIKit

extension UITableViewCell {
    func toggleAccessory(state: Bool) {
        accessoryType = state ? .checkmark : .none
    }
}

class ViewController: UITableViewController {

    struct Product {
        var product = ""
        var checked = false
    }
    
    var shoppingList = [Product]() {
        didSet {
            if shoppingList.isEmpty {
                clearShoppingListBtn.isEnabled = false
                shareShoppingListBtn.isEnabled = false
            } else {
                clearShoppingListBtn.isEnabled = true
                shareShoppingListBtn.isEnabled = true
            }
        }
    }
    
    var addShoppingListBtn: UIBarButtonItem!
    var clearShoppingListBtn: UIBarButtonItem!
    var shareShoppingListBtn: UIBarButtonItem!

    override func loadView() {
        super.loadView()
        
        addShoppingListBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProduct))
        
        clearShoppingListBtn = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearProducts))
        clearShoppingListBtn.isEnabled = false
        
        shareShoppingListBtn = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareShoppingList))
        shareShoppingListBtn.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isToolbarHidden = false
        navigationItem.rightBarButtonItem = shareShoppingListBtn
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [ clearShoppingListBtn, spacer, addShoppingListBtn ]
    }
    
    @objc func shareShoppingList() {
        var text = ""
        for item in shoppingList {
            text.append("[\(item.checked ? "X" : " ")] \(item.product)\n")
        }
        let activity = UIActivityViewController(activityItems: [text], applicationActivities: [])
        activity.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activity, animated: true, completion: nil)
    }
    
    @objc func clearProducts() {
        let ac = UIAlertController(title: "Delete Shopping List?", message: nil, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Delete", style: .default) { [weak self] _ in
            self?.shoppingList = []
            self?.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(confirm)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    @objc func addProduct() {
        let ac = UIAlertController(title: "New Product", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let newProduct = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
            guard let product = ac?.textFields?[0].text else { return }
            self?.addProductToList(product: product)
        }
        ac.addAction(newProduct)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func addProductToList(product: String) {
        shoppingList.insert(Product(product: product, checked: false), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Table View Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row].product
        cell.toggleAccessory(state: shoppingList[indexPath.row].checked)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        shoppingList[indexPath.row].checked = !shoppingList[indexPath.row].checked
        cell.toggleAccessory(state: shoppingList[indexPath.row].checked)
    }

}

