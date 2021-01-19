//
//  CitiesTableViewDataSource.swift
//  PSAWeatherAPP
//
//  Created by Mohamed Lamine Belfekih on 19/01/2021.
//

import Foundation
import UIKit

class CitiesTableViewDataSource: NSObject, UITableViewDataSource {
    
    let currentCellIdentifier = "currentWeatherCell"
    private var currentCitiesWeather: CitiesWeatherListViewModel
    
    init(_ citiesWeatherListViewModel: CitiesWeatherListViewModel) {
        self.currentCitiesWeather = citiesWeatherListViewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentCitiesWeather.numberOfRows(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cityWeatherVM = self.currentCitiesWeather.modelAt(indexPath.row)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.currentCellIdentifier) as? CurrentCityWeatherCell else {
            fatalError()
        }
        cell.cityWeatherVM = cityWeatherVM
        return cell
    }
}
