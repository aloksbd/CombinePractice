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
    private var loader: EmployeeLoader?
    private var employees = [Employee](){
        didSet{
            print(employees)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let employeePublisher = NotificationCenter.Publisher(center: .default, name: .getEmployees, object: nil)
        .map { (notification) -> [Employee] in
            return (notification.object as? [Employee]) ?? []
        }
        
        let client = EmployeeHttpClient()
        loader = RemoteEmployeeLoader(client: client)
        
        let employeeSubscriber = Subscribers.Assign(object: self, keyPath: \.employees)
        employeePublisher.subscribe(employeeSubscriber)
        
        loader?.load(publisher: employeePublisher)
    }


}

