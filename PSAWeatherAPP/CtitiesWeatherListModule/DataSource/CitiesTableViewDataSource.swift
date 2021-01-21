//
//  CitiesTableViewDataSource.swift
//  PSAWeatherAPP
//
//  Created by Mohamed Lamine Belfekih on 19/01/2021.
//

import Foundation
import UIKit

protocol CitiesTableViewRemoveItemProtocol {
    func citiesTableViewDidRemove(currentCityWeatherVM: CityWeatherViewModel)
}

class CitiesTableViewDataSource: NSObject, UITableViewDataSource {
    
    let currentCellIdentifier = "currentWeatherCell"
    private var currentCitiesWeather: CitiesWeatherListViewModel
    var removeItemProtocol: CitiesTableViewRemoveItemProtocol?
    
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let currentCityWeatherVMToDelete = currentCitiesWeather.modelAt(indexPath.row)
            currentCitiesWeather.removeAt(indexPath.row)
            tableView.reloadData()
            removeItemProtocol?.citiesTableViewDidRemove(currentCityWeatherVM: currentCityWeatherVMToDelete)
        }
    }
}
