//
//  AddCityDelegate.swift
//  PSAWeatherAPP
//
//  Created by Mohamed Lamine Belfekih on 19/01/2021.
//

import Foundation
import PSAWeatherSDK

protocol CurrentCityWeatherAdd: AnyObject {
    func currentCityWeatherAdded(cityWeatherVM: CityWeatherViewModel)
}
