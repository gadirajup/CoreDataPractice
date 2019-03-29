//
//  ViewController.swift
//  CoreDataPractice
//
//  Created by Prudhvi Gadiraju on 3/27/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class CompaniesVC: UITableViewController, CreateCompanyControllerDelegate {
    var companies = [Company]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        setupCompanies()
        setupNavigationBar()
        setupTableView()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .white
    }
    
    fileprivate func setupCompanies() {
        companies.append(Company(name: "Google", founded: Date()))
        companies.append(Company(name: "Facebook", founded: Date()))
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
    
    @objc
    fileprivate func handleAddCompanyButtonTapped() {
        let createCompanyVC = CreateCompanyVC()
        let navController = CustomNavigationController(rootViewController: createCompanyVC)
        
        createCompanyVC.delegate = self
        
        present(navController, animated: true, completion: nil)
    }
    
    fileprivate func add(Company company: Company) {
        companies.append(company)
        
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    func didAddCompany(company: Company) {
        add(Company: company)
    }
    
}

// MARK:- Table View Functions
extension CompaniesVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(companies[indexPath.row].name)"
        cell.detailTextLabel?.text = "\(companies[indexPath.row].founded)"
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
}
