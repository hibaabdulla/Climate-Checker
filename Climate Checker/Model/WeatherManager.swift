//
//  WeatherManager.swift
//  Climate Checker
//
//  Created by Hiba Abdulla on 5/26/25.
//

import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=cfd02e34f8b1c0cd9be57ee708b341ca&units=imperial"
    var delegate: WeatherManagerDelegate?
    let weatherConditionImage = "cloud.bolt"
    
    func fetchWeatherData(cityName: String) {
        let urlString = "\(baseUrl)&q=\(cityName)"
        performRequest(url: urlString)
    }
    
    func performRequest(url: String) {
        if   let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                if  error != nil {
                    print(error)
                    return
                }
                
                if let safeData = data {
                    if let weather = parseJson(weatherData: safeData) {
                        delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func parseJson(weatherData: Data) -> WeatherModel? {
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
            print(error)
            return nil
        }
    }
}
