//
//  EmployeHttpClient.swift
//  CombinePractice
//
//  Created by Alok Subedi on 10/9/20.
//  Copyright © 2020 Alok Subedi. All rights reserved.
//

import Foundation
import Combine

protocol HttpClient{
    func getEmployees() -> AnyPublisher<(data: Data, response: URLResponse), EmployeeHttpError>
}

class EmployeeHttpClient: HttpClient{
    func getEmployees() -> AnyPublisher<(data: Data, response: URLResponse), EmployeeHttpError>{
        let EMPLOYEE_URL = "http://dummy.restapiexample.com/api/v1/employees"
        
        let url = URL(string: EMPLOYEE_URL)!
        
        let session = URLSession.shared
        return session.dataTaskPublisher(for: URLRequest(url:url))
            .mapError({ (error) in
                return EmployeeHttpError.error(error.localizedDescription)
            })
            .flatMap({ (result) -> AnyPublisher<(data: Data, response: URLResponse),EmployeeHttpError> in
                let (_,response) = result
                guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                    return Fail(error: EmployeeHttpError.error("Server Failure")).eraseToAnyPublisher()
                }
                return Just(result)
                    .setFailureType(to: EmployeeHttpError.self)
                    .eraseToAnyPublisher()
            })
        .eraseToAnyPublisher()
    }
}
