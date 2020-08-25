//
//  WeatherCell.swift
//  Weather
//
//  Created by Bruno Meneghin on 31/07/20.
//  Copyright © 2020 Bruno Meneghin. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configureCell(_ vm: WeatherViewModel) {
        self.cityNameLabel.text = vm.name.value
        self.temperatureLabel.text = String(vm.currentTemperature.temperature.value.formatAsDegree)
    }
}
