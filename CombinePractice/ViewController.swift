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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = employees[indexPath.row].name
        cell.detailTextLabel?.text = "salary: $\(employees[indexPath.row].salary)\t age: \(employees[indexPath.row].age)"
        return cell
    }
    
    private var employees = [Employee](){
        didSet{
            DispatchQueue.main.async {[weak self] in
                
                self?.tableView.reloadData()
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let employeeSubscriber = Subscribers.Assign(object: self, keyPath: \.employees)
        
        let _ = EmployeesModel(subscriber: employeeSubscriber)
    }

}

