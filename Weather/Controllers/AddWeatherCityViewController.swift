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
    
    // MARK: Variables & Instances
    
    var delegate: AddWeatherDelegate?
    @IBOutlet weak var AddWeatherCityButton: UIButton!
    private lazy var addCityViewModel = AddCityViewModel()
  
    // MARK: - Observable Properties
    
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
    
    // MARK: - Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private funcs
    
    private func setupUI() {
        AddWeatherCityButton.layer.cornerRadius = 8
        cityNameTextField.becomeFirstResponder()
    }
    
    @IBAction private func saveCityButtonPressedEvent(_ sender: Any) {
        if let typedCity = cityNameTextField.text {
            guard let url = URL(string: APIURLViewModel.URL.base
                                        + APIURLViewModel.Path.path
                                        + typedCity
                                        + APIURLViewModel.key
                                        + APIURLViewModel.Path.unit) else {
                return
            }
            serviceAPIURL(url: url)
        }
    }
        
    private final func serviceAPIURL(url: URL) {
        let weatherResource = Resource<WeatherViewModel>(url: url) { data in
            let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
            return weatherVM
        }
        
        Webservice().serviceRequest(resource: weatherResource) { [weak self] result in
            switch result {
            case .success(let resource):
                guard let weatherVM = resource,
                      let delegate = self?.delegate else { return }
                
                DispatchQueue.main.async { [weak self] in
                    delegate.addWeatherDidSave(vm: weatherVM)
                    self?.dismiss(animated: true, completion: nil)
                }
                
            case .failure(let error):
                #if DEBUG
                print(error.identifier)
                #endif
            }
        }
    }
    
    @IBAction private func closeChooseCityName(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

