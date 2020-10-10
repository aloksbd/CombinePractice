//
//  EmployeesModel.swift
//  CombinePractice
//
//  Created by Alok Subedi on 10/10/20.
//  Copyright © 2020 Alok Subedi. All rights reserved.
//

import Foundation
import Combine

class EmployeesModel{
    init(subscriber: Subscribers.Assign<ViewController, [Employee]>){
        let client = EmployeeHttpClient()
        let loader: EmployeeLoader = RemoteEmployeeLoader(client: client)
        
        let employeePublisher = NotificationCenter.Publisher(center: .default, name: .getEmployees, object: nil)
        .map { (notification) -> [Employee] in
            return self.mapEmployees(from: notification)
        }
        
        employeePublisher.subscribe(subscriber)
        
        loader.load(publisher: employeePublisher)
    }
    
    private func mapEmployees(from notification: NotificationCenter.Publisher.Output) -> [Employee]{
        guard let result = notification.object as? EmployeeLoaderResult else {
            print("type error")
            return []
        }
        switch result{
            
        case let .success(employees):
            return employees
        case .failure(_):
            print("failed to load employees")
            return []
        }
    }
}
