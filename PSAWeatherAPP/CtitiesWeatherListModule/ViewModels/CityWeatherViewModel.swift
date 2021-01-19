//
//  CityWeatherViewModel.swift
//  PSAWeatherAPP
//
//  Created by Mohamed Lamine Belfekih on 19/01/2021.
//

import Foundation
import PSAWeatherSDK

struct CityWeatherViewModel {
    
    var currentWeather: CurrentCityWeather
    
    init(currentCityWeather: CurrentCityWeather) {
        self.currentWeather = currentCityWeather
    }
    
    var minTemperature: String? {
        return "\(Int(currentWeather.main.temperature))°"
    }
    
    var maxTemperature: String? {
        return "\(Int(currentWeather.main.maxTemperature))°"
    }
    
    var temperature: String? {
        return "\(Int(currentWeather.main.temperature))°"
    }
    
    var weather: Weather? {
        return currentWeather.weathers?.allObjects.first as? Weather
    }
    
    var description: String? {
        return weather?.weatherDescription
    }
    
    var feelsLike: String? {
        return "\(currentWeather.main.feelsLike)°"
    }
    
    var cityName: String? {
        return currentWeather.cityName
    }
    
    var icon: String {
        return weather?.icon ?? ""
    }
    
    var backgroundImage: String {
        return icon + "Background"
    }
}
