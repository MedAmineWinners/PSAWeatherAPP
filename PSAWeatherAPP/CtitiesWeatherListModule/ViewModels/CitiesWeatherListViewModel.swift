//
//  CitiesWeatherListViewModel.swift
//  PSAWeatherAPP
//
//  Created by Mohamed Lamine Belfekih on 19/01/2021.
//

import Foundation
class CitiesWeatherListViewModel {
    private(set) var list: [CityWeatherViewModel]
    init(citiesWeatherVM: [CityWeatherViewModel]) {
        self.list = citiesWeatherVM
    }
}

extension CitiesWeatherListViewModel {
    func numberOfRows(_ section: Int) -> Int {
        return self.list.count
    }
    
    func modelAt(_ index: Int) -> CityWeatherViewModel {
        return self.list[index]
    }
    
    func add(_ cityWeatherVM: CityWeatherViewModel) {
        self.list.append(cityWeatherVM)
    }
    
    func removeAt(_ index: Int) {
        self.list.remove(at: index)
    }
}
