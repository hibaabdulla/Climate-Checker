//
//  WeatherManager.swift
//  Climate Checker
//
//  Created by Hiba Abdulla on 5/26/25.
//

import Foundation

struct WeatherManager {
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=cfd02e34f8b1c0cd9be57ee708b341ca&units=imperial"
    
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
                    parseJson(weatherData: safeData)
                }
            }
            dataTask.resume()
        }
    }
    
    func parseJson(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
          let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        }
        catch {
            print(error)
        }
    }
}
