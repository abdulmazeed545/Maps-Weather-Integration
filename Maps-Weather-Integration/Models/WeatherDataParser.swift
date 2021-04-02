//
//  WeatherDataParser.swift
//  Maps-Weather-Integration
//
//  Created by Shaik abdul mazeed on 31/03/21.
//

import Foundation

struct WeatherDataParser {
    
    //Creating an singleton instance to the weather data parser
    static var shared = WeatherDataParser()
    
    //Creating a function to to forecast the weather data by using city names
    func weatherForecast(urlString:String, completion: @escaping (WeatherModel) -> Void){
        
        //Creating a url request to the url
        var urlRequest = URLRequest(url: URL(string: urlString)!)

        //Declaring the http method
        urlRequest.httpMethod = "GET"

        //Creating a data task session
        let weatherDataTask = URLSession.shared.dataTask(with: urlRequest) { (data, res, err) in
            
            if err == nil {
                
                do{
                    let decoder = JSONDecoder()
                    let weatherData = try decoder.decode(WeatherModel.self, from: data!)
                
                    //Returning the data to the completion handler
                    completion(weatherData)
                   
                }catch{
                    print("Oops there is an error: \(err?.localizedDescription)")
                }
            }
        }
        weatherDataTask.resume()
    }

}
