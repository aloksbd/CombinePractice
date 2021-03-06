//
//  EmployeeLoader.swift
//  CombinePractice
//
//  Created by Alok Subedi on 10/10/20.
//  Copyright © 2020 Alok Subedi. All rights reserved.
//

import Foundation
import Combine

typealias EmployeeLoaderResult = Result<[Employee], Error>

protocol EmployeeLoader {
    func load(publisher: Publishers.Map<NotificationCenter.Publisher, [Employee]>)
}

class RemoteEmployeeLoader: EmployeeLoader{
    private struct Root: Decodable{
        let data: [Employee]
    }
    
    private var client: HttpClient?
    private var cancellable: AnyCancellable?
    
    init(client: HttpClient){
        self.client = client
    }
    
    func load(publisher: Publishers.Map<NotificationCenter.Publisher, [Employee]>){
        cancellable = client?.getEmployees()
            .sink(receiveCompletion: { completion in
                switch completion{
                case let .failure(error):
                    NotificationCenter.default.post(name: .getEmployees, object: EmployeeLoaderResult.failure(error))
                default:
                    break
                }
                
            }, receiveValue: {result in
                    let employees = try? self.map(data: result.data)
                NotificationCenter.default.post(name: .getEmployees, object: EmployeeLoaderResult.success(employees ?? []))
                
            })
    }
    
    private func map(data: Data) throws -> [Employee]{
        guard let root = try? JSONDecoder().decode(Root.self, from: data) else{
            throw NSError()
        }
        return root.data
    }
}
