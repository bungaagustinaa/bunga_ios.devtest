//
//  EmployedList.swift
//  CRUD_TEST
//
//  Created by Bunga Agustina on 10/05/23.
//

import Foundation

struct EmployedList: Codable {
    let status: String
    let data: [DataList]
    let message: String
}
