//
//  WeatherDetailsViewModel.swift
//  PSAWeatherAPP
//
//  Created by Mohamed Lamine Belfekih on 19/01/2021.
//

import Foundation
import PSAWeatherSDK

class WeatherDetailsViewModel {
    var cityWeatherVM: CityWeatherViewModel
    var hourlyWeatherListVM: HourlyWeatherListViewModel
    var dailyWeatherListVM: DailyWeatherListViewModel
    
    init(cityWeatherVM: CityWeatherViewModel, hourlyWeatherListVM: HourlyWeatherListViewModel, dailyWeatherListVM: DailyWeatherListViewModel) {
        self.cityWeatherVM = cityWeatherVM
        self.hourlyWeatherListVM = hourlyWeatherListVM
        self.dailyWeatherListVM = dailyWeatherListVM
    }
}

class HourlyWeatherListViewModel {
    var list: [HourWeatherViewModel]
    init(_ list: [HourWeatherViewModel]) {
        self.list = [HourWeatherViewModel]()
    }
    func numberOfRows(_ section: Int) -> Int {
        return self.list.count
    }
    
    func modelAt(_ index: Int) -> HourWeatherViewModel {
        return self.list[index]
    }
}

struct DailyWeatherListViewModel {
    var list: [DayWeatherViewModel]
    init(_ list: [DayWeatherViewModel]) {
        self.list = [DayWeatherViewModel]()
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return self.list.count
    }
    
    func modelAt(_ index: Int) -> DayWeatherViewModel {
        return self.list[index]
    }
}

struct HourWeatherViewModel {
    var hourly: Hourly
    
    init(hourly: Hourly) {
        self.hourly = hourly
    }
    
    var weather: Weather? {
        return hourly.weathers?.allObjects.first as? Weather
    }
    
    var hour: String? {
        let formatter = DateFormatter()
        return (hourly.date.shortDate(with: formatter) == Date().shortDate(with: formatter) && hourly.date.hours() == Date().hours()) ? "now" : "\(Calendar.current.component(.hour, from: hourly.date))h"
    }
    
    var icon: String {
        return weather?.icon ?? ""
    }
    
    var temperature: String? {
        return String(hourly.temperature)
    }
    
}

struct DayWeatherViewModel {
    var daily: Daily
        
    var weather: Weather? {
        return daily.weathers?.allObjects.first as? Weather
    }
    
    var day: String? {
        let formatter = DateFormatter()
        return daily.date.shortDate(with: formatter) == Date().shortDate(with: formatter) ? "today" :  daily.date.dateToDayString(with: DateFormatter())
    }
    
    var maxTemperature: String? {
        return String(daily.maxTemperature)
    }
    
    var minTemperature: String? {
        return String(daily.minTemperature)
    }
    
    var icon: String {
        return weather?.icon ?? ""
    }
    
    var sunrise: String? {
        return "\(daily.sunrise.hours())h"
    }
    
    var sunset: String? {
        return "\(daily.sunset.hours())h"
    }
    
    var humidity: String? {
        return "\(daily.humidity)%"
    }
    
    var pressure: String? {
        return "\(daily.pressure)hPa"
    }
}
