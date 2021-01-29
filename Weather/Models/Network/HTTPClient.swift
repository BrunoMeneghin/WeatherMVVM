//
//  HTTPError.swift
//  Weather
//
//  Created by Bruno Meneghin on 29/01/21.
//  Copyright © 2021 Bruno Meneghin. All rights reserved.
//

import Foundation

enum HTTPClient: Error {
    case success
    case clientError
    case internalServerError

    var identifier: String {
        get {
            switch self {
            case .success:
                return "Success"
                
            case .clientError:
                return "Client error: API KEY is required if the Response status error is 401\n"
                
            case .internalServerError:
                return "Internal server error"
            }
        }
    }
}


extension HTTPClient: Equatable {
    static func ==(lhs: HTTPClient, rhs: HTTPClient) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
