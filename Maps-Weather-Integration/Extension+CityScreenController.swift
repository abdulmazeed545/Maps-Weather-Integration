//
//  Extension+CityScreenController.swift
//  Maps-Weather-Integration
//
//  Created by Shaik abdul mazeed on 01/04/21.
//

import Foundation
import UIKit
extension CityScreenController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return humidity.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.forecastCell, for: indexPath) as! ForecastCell
        cell.temparature.text = "Temparaute is: \(temparature[indexPath.row])ºC"
        cell.humidity.text = "Humidity is: \(humidity[indexPath.row])%"
        cell.wind.text = "Wind speed is: \(windSpeed[indexPath.row])Km/hr"
        cell.weather.text = "Weather: \(weather[indexPath.row][0])"
        cell.date.text = date[indexPath.row]
        cell.layer.cornerRadius = 30
        return cell
    }
}
