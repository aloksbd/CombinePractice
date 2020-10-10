//
//  ViewController.swift
//  CombinePractice
//
//  Created by Alok Subedi on 10/9/20.
//  Copyright © 2020 Alok Subedi. All rights reserved.
//

import UIKit
import Combine

extension Notification.Name {
    static let getEmployees = Notification.Name("get_employees")
}

class ViewController: UIViewController {
    private var employees = [Employee](){
        didSet{
            print(employees)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let employeeSubscriber = Subscribers.Assign(object: self, keyPath: \.employees)
        
        let _ = EmployeesModel(subscriber: employeeSubscriber)
    }

}

