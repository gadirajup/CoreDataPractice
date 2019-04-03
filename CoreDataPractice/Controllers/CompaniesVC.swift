//
//  ViewController.swift
//  CoreDataPractice
//
//  Created by Prudhvi Gadiraju on 3/27/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit
import CoreData

class CompaniesVC: UITableViewController, CreateCompanyControllerDelegate {
    var companies = [Company]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        setupNavigationBar()
        setupTableView()
        fetchCompanies()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .white
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddCompanyButtonTapped))
        
        //navigationController?.customNavSetup()
    }
    
    fileprivate func setupTableView() {
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
    }
    
    fileprivate func fetchCompanies() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        do {
            let companies = try context.fetch(fetchRequest)
            self.companies = companies
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc
    fileprivate func handleAddCompanyButtonTapped() {
        let createCompanyVC = CreateCompanyVC()
        let navController = CustomNavigationController(rootViewController: createCompanyVC)
        createCompanyVC.delegate = self
        present(navController, animated: true, completion: nil)
    }
    
    fileprivate func add(company: Company) {
        companies.append(company)
        
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    fileprivate func edit(company: Company) {
        let row = companies.firstIndex(of: company)
        let indexPath = IndexPath(row: row!, section: 0)
        
        tableView.reloadRows(at: [indexPath], with: .middle)
    }
    
    func didAddCompany(company: Company) {
        add(company: company)
    }
    
    func didEditCompany(company: Company) {
        edit(company: company)
    }
    
}

// MARK:- Table View Functions
extension CompaniesVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let company = companies[indexPath.row]
        
        if let name = company.name, let founded = company.founded {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let foundedCustomDate = dateFormatter.string(from: founded)
            
            cell.textLabel?.text = "\(name) - \(foundedCustomDate)"
        } else {
            cell.textLabel?.text = company.name
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let company = self.companies[indexPath.row]
            self.companies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // Delete from Core Data Also
            
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(company)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: handleEdit)
        
        deleteAction.backgroundColor = UIColor.lightRed
        
        return [deleteAction, editAction]
    }
    
    fileprivate func handleEdit(action: UITableViewRowAction, indexPath: IndexPath) {
        let editCompanyController = CreateCompanyVC()
        let navController = CustomNavigationController(rootViewController: editCompanyController)
        editCompanyController.company = companies[indexPath.row]
        editCompanyController.delegate = self
        present(navController, animated: true, completion: nil)
    }
}
