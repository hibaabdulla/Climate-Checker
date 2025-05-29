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
        print(urlString)
    }
}
