//
//  EmployeeHttpError.swift
//  CombinePractice
//
//  Created by Alok Subedi on 10/10/20.
//  Copyright © 2020 Alok Subedi. All rights reserved.
//

import Foundation

enum EmployeeHttpError: Error, LocalizedError{
    case error(String)
    
    var description: String{
        switch self {
            
        case let .error(description):
            return description
        }
    }
}
