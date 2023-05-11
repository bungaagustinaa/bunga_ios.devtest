//
//  EmployeeViewModel.swift
//  CRUD_TEST
//
//  Created by Bunga Agustina on 10/05/23.
//

import Foundation

class EmployeeViewModel {
    private let apiManager = APIManager.shared
    
    func createEmployee(name: String, salary: String, age: String, completion: @escaping (Employee?, Error?) -> Void) {
        apiManager.createEmployee(name: name, salary: salary, age: age) { employee, error in
            if let error = error {
                completion(nil, error)
            } else if let employee = employee {
                completion(employee, nil)
            } else {
                let error = NSError(domain: "EmployeeViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create employee"])
                completion(nil, error)
            }
        }
    }
    
    func fetchEmployees(completion: @escaping ([DataList]?, Error?) -> Void) {
        apiManager.fetchEmployees(completion: completion)
    }
    
    func updateEmployee(id: String, name: String, salary: String, age: String, completion: @escaping (Employee?, Error?) -> Void) {
        apiManager.updateEmployee(id: id, name: name, salary: salary, age: age, completion: completion)
    }
    
    func deleteEmployee(id: String, completion: @escaping (Bool, Error?) -> Void) {
        apiManager.deleteEmployee(id: id, completion: completion)
    }
}
