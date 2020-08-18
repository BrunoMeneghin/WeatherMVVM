//
//  WetherDetailsViewController.swift
//  Weather
//
//  Created by Bruno Meneghin on 10/08/20.
//  Copyright © 2020 Bruno Meneghin. All rights reserved.
//

import Foundation
import UIKit

class WeatherDetailsViewController: UIViewController {
    
    @IBOutlet weak var temperatureDetailsView: UIView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    
    var weatherViewModel: WeatherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupVMBindings()
    }
    
    private func setupUI() {
        
        let gradientColor = CAGradientLayer()
        gradientColor.frame = self.view.frame
        gradientColor.colors = [UIColor.clear.cgColor, UIColor.blue.cgColor]
        
        self.view.layer.addSublayer(gradientColor)
        
        self.temperatureDetailsView.layer.cornerRadius = 12
    }
    
    private func setupVMBindings() {
        
        if let weatherVM = self.weatherViewModel {
            
            weatherVM.name.bind { self.cityNameLabel.text = $0 }
            
            weatherVM.currentTemperature.temperatureMin.bind {
                self.minTemperatureLabel.text = "min \($0.formatAsDegree)"
            }
            
            weatherVM.currentTemperature.temperatureMax.bind {
                self.maxTemperatureLabel.text = "max \($0.formatAsDegree)"
            }
            
            weatherVM.currentTemperature.temperature.bind { self.currentTemperatureLabel.text = "Current \($0.formatAsDegree)"}
        }
    }
}
