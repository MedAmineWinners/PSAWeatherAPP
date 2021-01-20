//
//  DailyTableViewDataSource.swift
//  PSAWeatherAPP
//
//  Created by Mohamed Lamine Belfekih on 19/01/2021.
//

import Foundation
import UIKit

class DailyTableViewDataSource: NSObject, UITableViewDataSource {
    
    let DailyTableViewCellIdentifier = "DailyTableViewCell"
    private var dailyWeatherListVM: DailyWeatherListViewModel
    
    init(_ dailyWeatherListVM: DailyWeatherListViewModel) {
        self.dailyWeatherListVM = dailyWeatherListVM
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dailyWeatherListVM.numberOfRows(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCellIdentifier, for: indexPath) as? DailyTableViewCell else {
            fatalError()
        }
        cell.dayWeatherVM = self.dailyWeatherListVM.modelAt(indexPath.row)
        return cell
    }
}
