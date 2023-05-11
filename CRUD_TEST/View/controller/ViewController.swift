//
//  ViewController.swift
//  CRUD_TEST
//
//  Created by Bunga Agustina on 10/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var salaryTextfield: UITextField!
    @IBOutlet weak var ageTextfield: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let employeeViewModel = EmployeeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        submitButton.layer.cornerRadius = 6
    }
    
    @IBAction func submitAct(_ sender: Any) {
        guard let name = nameTextfield.text, let salary = salaryTextfield.text, let age = ageTextfield.text else { return }
        
        employeeViewModel.createEmployee(name: name, salary: salary, age: age) { employee, error in
            if let error = error {
                print("Error creating employee: \(error.localizedDescription)")
            } else if let employee = employee {
                print("Successfully created employee: \(employee)")
            }
        }

    }
    
    @IBAction func showAllEmployeesAct(_ sender: Any) {
        self.navigationController?.pushViewController(EmployeeListViewController.getViewController(), animated: true)
    }
}

