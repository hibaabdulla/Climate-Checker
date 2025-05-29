//
//  WeatherData.swift
//  Climate Checker
//
//  Created by Hiba Abdulla on 5/28/25.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
}
