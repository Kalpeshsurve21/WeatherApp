//
//  Weather.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 11/05/21.
//

import Foundation

/// This is a weather model, used to parse and save the weather data in core data entity format
struct WeatherModel {
    let city: String
    let temp: Double
    let humidity: Int
    let pressure: Int
    let clouds: Int
    let weather: String
    let time: String
    
    init(city: String, temp: Double, humidity: Int, pressure: Int, clouds: Int, weather: String, time: String) {
        self.city = city
        self.temp = temp
        self.humidity = humidity
        self.pressure = pressure
        self.clouds = clouds
        self.weather = weather
        self.time = time
    }
}
