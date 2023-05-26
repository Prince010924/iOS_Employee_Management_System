//
//  Model.swift
//  EmployeeListProject
//
//  Created by DA MAC M1 124 on 2023/05/25.
//

import Foundation

// MARK: - EmployeeElement
struct Employee: Codable {
    let employeeNumber: Int
    let firstName, middleName, surname, email: String
    let department: String
}


