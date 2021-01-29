//
//  APIURLViewModel.swift
//  Weather
//
//  Created by Bruno Meneghin on 29/01/21.
//  Copyright © 2021 Bruno Meneghin. All rights reserved.
//

import Foundation

struct APIURLViewModel {
    static let key = "&appid=" // API KEY
  
    enum URL {
        static let base = "https://api.openweathermap.org"
    }
    
    enum Path {
        static let path = "/data/2.5/weather?q="
        static let unit = "&units=metric"
    }
}

