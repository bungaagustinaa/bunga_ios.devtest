//
//  EmployeeListViewController.swift
//  CRUD_TEST
//
//  Created by Bunga Agustina on 10/05/23.
//

import UIKit

class EmployeeListViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    private var employees: [DataList] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        tableview.delegate = self
        tableview.dataSource = self
        
        self.fetchEmployee()
    }
    
    private func fetchEmployee() {
        APIManager.shared.fetchEmployees { [weak self] (fetchedEmployees, error) in
            if let error = error {
                // Handle the error, e.g., show an alert
                print("Error fetching employees: \(error)")
            } else if let fetchedEmployees = fetchedEmployees {
                // Update the employees array and reload the table view on the main queue
                DispatchQueue.main.async {
                    self?.employees = fetchedEmployees
                    self?.tableview.reloadData()
                }
            }
        }
    }
    
    
    static func getViewController() -> EmployeeListViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "employeeListViewController") as! EmployeeListViewController
        return vc
    }
    
}

extension EmployeeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeListTableViewCell", for: indexPath) as! EmployeeListTableViewCell
        cell.selectionStyle = .none
        
        let employee = employees[indexPath.row]
        cell.configureCell(employee: employee)
        
        return cell
    }
    
    
}
