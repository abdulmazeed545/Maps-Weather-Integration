//
//  ViewController.swift
//  Maps-Weather-Integration
//
//  Created by Shaik abdul mazeed on 31/03/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
        // Do any additional setup after loading the view.
    }
    func displayData(){
        
        WeatherDataParser.shared.weatherForecast { (todaysForecast) in
            var today = todaysForecast.list.map({
                $0.main.humidity
            })
            var temp = todaysForecast.list.map{
                $0.main.temp
            }
            var windSpeed = todaysForecast.list.map{
                $0.wind.speed
            }
            var windDegree = todaysForecast.list.map{
                $0.wind.deg
            }
            
            print("Humidity is:\(today)\nTemparature is:\(temp)Celcius\nWind Speed is:\(windSpeed)\nWind Degree is:\(windDegree)")
        }
    }


}

