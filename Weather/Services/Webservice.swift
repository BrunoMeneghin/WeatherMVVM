//
//  Webservice.swift
//  Weather
//
//  Created by Bruno Meneghin on 31/07/20.
//  Copyright © 2020 Bruno Meneghin. All rights reserved.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class Webservice {
    func carryingCityTemperature<T>(resource: Resource<T>, completion: @escaping (Result<T?, HTTPClient>) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            guard error == nil,
                  let data = data,
                  let response = response else {
                
                if let err = error {
                    #if DEBUG
                    print(err.localizedDescription)
                    #endif
                }
                return
            }
            
            guard let httpURLResponse = response as? HTTPURLResponse else { return }
            
            switch httpURLResponse.statusCode {
            case 200...299:
                completion(.success(resource.parse(data)))
                
            case 400...499:
                completion(.failure(HTTPClient.clientError))
                
            case 500...599:
                completion(.failure((HTTPClient.internalServerError)))
        
            default:
                break
            }
            
            #if DEBUG
            print("Response status:", httpURLResponse.statusCode)
            #endif
            
        }.resume()
    }
}


