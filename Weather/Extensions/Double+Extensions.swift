//
//  Double+Extensions.swift
//  Weather
//
//  Created by Bruno Meneghin on 03/08/20.
//  Copyright © 2020 Bruno Meneghin. All rights reserved.
//

import Foundation

extension Double {
    var formatAsDegree: String {
        return String(format: "%.0f°", self) // self instance of Double
    }
}
