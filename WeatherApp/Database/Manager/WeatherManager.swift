//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 11/05/21.
//

import Foundation

/// This is a weathermanager struct for managing the database related methods
struct WeatherManager {
    private let weatherDataRepo = WeatherDataRepository()
    
    /// This method is used to add the weather record in city, if the record already present then update the same
    /// - Parameter weather: object of WeatherModel
    func add(weather: WeatherModel) {
        if isRecordPresent(city: weather.city) { _ = self.updateWeather(weather: weather) }
        else { weatherDataRepo.add(weather: weather) }
    }
    
    /// This method is used to fetch the weather record for passed city
    /// - Parameter city: city as string
    /// - Returns: object of WeatherModel
    func fetchWeather(city: String) -> WeatherModel? {
        return weatherDataRepo.getWeather(for: city)
    }
    
    /// This method is used to fetch all the weather records present in database
    /// - Returns: array of WeatherModel?
    func fetchWeather() -> [WeatherModel]? {
        return weatherDataRepo.getWeatherAllCities()
    }
    
    /// This method is used to update the weather record if the record present in database
    /// - Parameter weather: object of WeatherModel
    /// - Returns: true if the record updated else false
    func updateWeather(weather: WeatherModel) -> Bool {
        return weatherDataRepo.update(weather: weather)
    }
    
    /// This method is used to delete the weather record if the record present in database
    /// - Parameter weather: object of WeatherModel
    /// - Returns: true if the record deleted else false
    func deleteWeather(weather: WeatherModel) -> Bool {
        return weatherDataRepo.delete(weather: weather)
    }
    
    /// This method is used to fetch the weather record for passed city
    /// - Parameter top: number of records to be fetched as Int
    /// - Returns: array of WeatherModel
    func getWeatherOf(top: Int) -> [WeatherModel]? {
        return weatherDataRepo.getWeatherOf(top: top)
    }
    
    /// This method is used to check if the weather record for city is already exist in database
    /// - Parameter city: city as string
    /// - Returns: true if record present else false
    func isRecordPresent(city: String) -> Bool {
        guard let _ = self.fetchWeather(city: city) else { return false }
        return true
    }
    
}
