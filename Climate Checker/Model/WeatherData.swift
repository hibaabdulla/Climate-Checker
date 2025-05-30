//
//  WeatherData.swift
//  Climate Checker
//
//  Created by Hiba Abdulla on 5/28/25.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
