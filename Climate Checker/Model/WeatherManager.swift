//
//  WeatherManager.swift
//  Climate Checker
//
//  Created by Hiba Abdulla on 5/26/25.
//

import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=AppId&units=imperial"
    var delegate: WeatherManagerDelegate?
    let weatherConditionImage = "cloud.bolt"
    
    func fetchWeatherData(cityName: String) {
        let urlString = "\(baseUrl)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeatherData(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(baseUrl)&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with url: String) {
        if   let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                if  error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = parseJson(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            dataTask.resume()
        }
    }
        
    func parseJson(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
          let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(weatherId: id, cityName: name, temperature: temp)
            return weather
            
        }
        catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
