//
//  SettingsViewModel.swift
//  Weather
//
//  Created by Bruno Meneghin on 04/08/20.
//  Copyright © 2020 Bruno Meneghin. All rights reserved.
//

import Foundation

enum Unit: String, CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

struct SettingsViewModel {
    let units = Unit.allCases
    private var _selectedUnit: Unit = Unit.fahrenheit
    
    var selectedUnit: Unit {
        get {
            let userDefaults = UserDefaults.standard
            
            if let value = userDefaults.value(forKey: "unit") as? String {
                return Unit(rawValue: value)!
            }
            
            return _selectedUnit
        }
        
        set {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newValue.rawValue, forKey: "unit")
        }
    }
}

extension Unit {
    var displayName: String {
        get {
            switch (self) {
            case .celsius:
                return "Celsius"
                
            case .fahrenheit:
                return "Fahrenheit"
            }
        }
    }
}


