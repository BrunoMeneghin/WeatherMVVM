//
//  WeatherListTableViewController.swift
//  Weather
//
//  Created by Bruno Meneghin on 31/07/20.
//  Copyright © 2020 Bruno Meneghin. All rights reserved.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController, AddWeatherDelegate {
    
    private var weatherListViewModel = WeatherListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupIU()
    }
    
    private func setupIU() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weatherListViewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        let weatherListVM = self.weatherListViewModel.modelCellForRowAt(indexPath.row)
        
        cell.configureCell(weatherListVM)
        
        return cell
    }
    
    func addWeatherDidSave(vm: WeatherViewModel) {
        
        self.weatherListViewModel.addWeatherListViewModel(vm)
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case "AddCityViewController":
            prepareForSegueAddWeatherCityViewController(segue: segue)
            
        case "SettingsTableViewController":
            prepareForSegueSettingTableViewController(segue: segue)
            
        case "WeatherDetailsViewController":
            prepareForSegueWeatherDetailsViewController(segue: segue)
            
        default:
            return prepareForSegueAddWeatherCityViewController(segue: segue)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if (weatherListViewModel.numberOfRows(section)) == 0 {
            return "You don't have any Weathers"
        }
        
        return ""
    }
    
    private func prepareForSegueAddWeatherCityViewController(segue: UIStoryboardSegue) {
        
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("Navigation controller not found")
        }
        
        guard let addWeatherCityVC = nav.viewControllers.first as? AddWeatherCityViewController else {
            fatalError("AddWeatherVC is not found")
        }
        
        addWeatherCityVC.delegate = self
    }
    
    private func prepareForSegueSettingTableViewController(segue: UIStoryboardSegue) {
        
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("Navigation controller not found")
        }
        
        guard let settingsTVC = nav.viewControllers.first as? SettingsTableViewController else {
            fatalError("settingsTVC is not found")
        }
        
        settingsTVC.delegate = self
    }
    
    private func prepareForSegueWeatherDetailsViewController(segue: UIStoryboardSegue) {
        
        guard let weatherDetailsVC = segue.destination as? WeatherDetailsViewController, let indexPath = self.tableView.indexPathForSelectedRow else {
            
            return
        }
        
        let weatherVM = self.weatherListViewModel.modelCellForRowAt(indexPath.row)
        
        weatherDetailsVC.weatherViewModel = weatherVM
    }
    
}

extension WeatherListTableViewController: SettingsDelegate {
    func settingsDone(vm: SettingsViewModel) {
        
        self.weatherListViewModel.updateUnit(to: vm.selectedUnit)
        self.tableView.reloadData()
    }
}

