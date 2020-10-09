//
//  Employee.swift
//  CombinePractice
//
//  Created by Alok Subedi on 10/9/20.
//  Copyright © 2020 Alok Subedi. All rights reserved.
//

struct Employee : Codable {
    var name: String
    var age: String
    var salary: String

    private enum CodingKeys : String, CodingKey {
        case name = "employee_name", age = "employee_age", salary = "employee_salary"
    }
}
