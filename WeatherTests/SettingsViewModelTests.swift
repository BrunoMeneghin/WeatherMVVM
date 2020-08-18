//
//  SettingsViewModelTests.swift
//  WeatherTests
//
//  Created by Bruno Meneghin on 11/08/20.
//  Copyright © 2020 Bruno Meneghin. All rights reserved.
//

import XCTest
@testable import Weather

class SettingsViewModelTests: XCTestCase {

    private var settingsVM: SettingsViewModel!
    
    override func setUp() {
        super.setUp()
        
        self.settingsVM = SettingsViewModel()
    }
    
    func test_should_return_correct_display_name_for_celsius() {
        XCTAssertEqual(self.settingsVM.selectedUnit.displayName, "Celsius")
    }
        
    func test_should_make_sure_that_selected_unit_is_celsius() {
        XCTAssertEqual(self.settingsVM.selectedUnit, .celsius)
    }
    
    func test_should_be_able_to_save_user_unit_selection() {
        
        self.settingsVM.selectedUnit = .celsius
        let userDefaults = UserDefaults.standard
        XCTAssertNotNil(userDefaults.value(forKey: "unit"))
    }
    
    override class func tearDown() {
        super.tearDown()
        
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "unit")
    }
}
