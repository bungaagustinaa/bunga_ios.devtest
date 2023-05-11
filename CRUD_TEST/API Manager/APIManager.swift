//
//  APIManager.swift
//  CRUD_TEST
//
//  Created by Bunga Agustina on 10/05/23.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    private let baseURL = "http://dummy.restapiexample.com/api/v1"
    
    func createEmployee(name: String, salary: String, age: String, completion: @escaping (Employee?, Error?) -> Void) {
        let url = URL(string: "\(baseURL)/create")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let employeeData = ["name": name, "salary": salary, "age": age]
        let jsonData = try? JSONSerialization.data(withJSONObject: employeeData)
        
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, NSError(domain: "APIManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"]))
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                completion(nil, NSError(domain: "APIManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "HTTP Error \(httpResponse.statusCode)"]))
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "APIManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            do {
                let responseJSON = try JSONDecoder().decode(EmployeeResponse.self, from: data)
                
                if responseJSON.status == "success" {
                    let employee = responseJSON.data
                    completion(employee, nil)
                } else {
                    let errorDescription = responseJSON.message
                    completion(nil, NSError(domain: "APIManager", code: -1, userInfo: [NSLocalizedDescriptionKey: errorDescription]))
                }
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    func fetchEmployees(completion: @escaping ([DataList]?, Error?) -> Void) {
        let url = URL(string: "\(baseURL)/employees")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "APIManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(EmployedList.self, from: data)
                completion(response.data, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    func updateEmployee(id: String, name: String, salary: String, age: String, completion: @escaping (Employee?, Error?) -> Void) {
        let url = URL(string: "\(baseURL)/update/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        let employeeData = ["name": name, "salary": salary, "age": age]
        let jsonData = try? JSONSerialization.data(withJSONObject: employeeData)
        
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                do {
                    let employee = try JSONDecoder().decode(Employee.self, from: data)
                    completion(employee, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    func deleteEmployee(id: String, completion: @escaping (Bool, Error?) -> Void) {
        let url = URL(string: "\(baseURL)/delete/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                completion(response.statusCode == 200, nil)
            }
        }.resume()
    }
}
