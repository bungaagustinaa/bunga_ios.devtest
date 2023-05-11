//
//  EmployeeResponse.swift
//  CRUD_TEST
//
//  Created by Bunga Agustina on 10/05/23.
//

import Foundation

struct EmployeeResponse: Codable {
    let status: String
    let data: Employee
    let message: String
}

