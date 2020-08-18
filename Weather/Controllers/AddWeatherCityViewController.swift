//
//  AddWeatherCityViewController.swift
//  Weather
//
//  Created by Bruno Meneghin on 31/07/20.
//  Copyright © 2020 Bruno Meneghin. All rights reserved.
//

import Foundation
import UIKit

protocol AddWeatherDelegate {
    
    func addWeatherDidSave(vm: WeatherViewModel);
}

class AddWeatherCityViewController: UIViewController, UITextFieldDelegate {
    
    private var addCityViewModel = AddCityViewModel()
    
    @IBOutlet weak var AddWeatherCityButton: UIButton!
    
    @IBOutlet weak var cityNameTextField: BindingTextFields! {
        didSet {
            cityNameTextField.bind { self.addCityViewModel.city = $0 }
        }
    }
    
    @IBOutlet weak var stateTextField: BindingTextFields! {
        didSet {
            stateTextField.bind { self.addCityViewModel.state = $0 }
        }
    }
    
    @IBOutlet weak var zipCodeTextField: BindingTextFields! {
        didSet {
            zipCodeTextField.bind { self.addCityViewModel.zipCode = $0 }
        }
    }
    
    var delegate: AddWeatherDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        AddWeatherCityButton.layer.cornerRadius = 8
       
        cityNameTextField.becomeFirstResponder()
    }
    
    @IBAction func saveCityButtonPressedEvent(_ sender: Any) {
        
        if let city = cityNameTextField.text {
            
            /// The URL below don't have the Key. Insert yours API Key after &appid= 
            guard let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=&units=metric") else {
                
                print(NetworkError.urlDomain.localizedDescription)
                
                return
            }
            
            let weatherResource = Resource<WeatherViewModel>(url: weatherURL) { data in
                let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
                
                return weatherVM
            }
            
            Webservice().load(resource: weatherResource) { [weak self] result in
                if let weatherVM = result {
                    
                    if let delegate = self?.delegate {
                        delegate.addWeatherDidSave(vm: weatherVM)
                        print(weatherVM.currentTemperature.temperature.value)
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func closeChooseCityName(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
