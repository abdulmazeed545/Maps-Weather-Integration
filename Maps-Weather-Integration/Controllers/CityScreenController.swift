//
//  CityScreenController.swift
//  Maps-Weather-Integration
//
//  Created by Shaik abdul mazeed on 31/03/21.
//

import UIKit

class CityScreenController: UIViewController {
    
    //Creating variables
    var collectionView:UICollectionView!

    @IBOutlet weak var tableView: UITableView!
    var cities:String = ""
    
    var humidity:[Int] = []
    var temparature:[String] = []
    var windSpeed:[Double] = []
    var weather:[[String]] = []
    var date:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Calling the function
        displayData()
        collectionCV()

    }
    func displayData(){
        
        let city = Constants.city+"\(cities)"
        let urlString = Constants.baseURL+city+Constants.appId+Constants.units
       
        WeatherDataParser.shared.weatherForecast(urlString: urlString) { [self] (todaysForecast) in
            humidity = todaysForecast.list.map({
                $0.main.humidity
            })
            temparature = todaysForecast.list.map{
                $0.main.temperatureString
            }
            windSpeed = todaysForecast.list.map{
                $0.wind.speed
            }
            date = todaysForecast.list.map{$0.dt_txt}
            var windDegree = todaysForecast.list.map{
                $0.wind.deg
            }
            weather = todaysForecast.list.map{
                $0.weather.map{ $0.main} }
            
            DispatchQueue.main.async {

                self.collectionView.reloadData()
                
            }
            
        }
    }
    //MARK:- Creating the Collection View
    func collectionCV()
    {
        var collectionFLayout = UICollectionViewFlowLayout()
        collectionFLayout.itemSize = CGSize(width: view.frame.size.width / 2 - 5, height: 250)
        collectionFLayout.scrollDirection = .vertical
        collectionFLayout.minimumLineSpacing = 5
        
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), collectionViewLayout: collectionFLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        
        let CVCell = UINib(nibName: "ForecastCell", bundle: nil)
        collectionView.register(CVCell, forCellWithReuseIdentifier: Constants.forecastCell)
        view.addSubview(collectionView)
        collectionView.reloadData()
        
    }
    
}

