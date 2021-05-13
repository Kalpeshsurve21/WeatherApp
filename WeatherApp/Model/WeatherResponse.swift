//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 10/05/21.
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
    let clouds: Clouds
}

// MARK: - Main
struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Weather
struct Weather: Decodable {
    let main, weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case main
        case weatherDescription = "description"
    }
}

// MARK: - Clouds
struct Clouds: Decodable {
    let all: Int
}

//MARK: - WeatherResponse Extension
extension WeatherResponse {
    /// This method is used to convert the WeatherResponse object to WeatherModel
    /// - Returns: as WeatherModel
    func convertToWeatherViewModel() -> WeatherModel {
        let time = Utils.getCurrentTime()
        let temp = Utils.convertToCelcius(from: self.main.temp)
        let weather = WeatherModel(city: self.name, temp: temp, humidity: self.main.humidity, pressure: self.main.pressure, clouds: self.clouds.all, weather: self.weather[0].main, time: time)
        return weather
    }
}
