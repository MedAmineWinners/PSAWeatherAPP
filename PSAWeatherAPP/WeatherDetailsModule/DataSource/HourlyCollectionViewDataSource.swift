//
//  HourlyCollectionViewDataSource.swift
//  PSAWeatherAPP
//
//  Created by Mohamed Lamine Belfekih on 19/01/2021.
//

import Foundation
import UIKit
class HourlyCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    let hourlyCollectionViewCellIdentifier = "HourlyCollectionViewCell"
    private var hourlyWeatherVM: HourlyWeatherListViewModel
    
    init(_ hourlyWeatherVM: HourlyWeatherListViewModel) {
        self.hourlyWeatherVM = hourlyWeatherVM
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.hourlyWeatherVM.numberOfRows(section)
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hourlyCollectionViewCellIdentifier, for: indexPath) as? HourlyCollectionViewCell else {
            fatalError()
        }
        cell.hourWeatherVM = self.hourlyWeatherVM.modelAt(indexPath.row)
        return cell
    }
}
