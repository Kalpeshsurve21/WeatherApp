//
//  WeatherDataRepository.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 11/05/21.
//

import Foundation
import CoreData

/// This protocol is used to have bunch of methods related to hanling of data repository operations
protocol WeatherRepository {
    func add(weather: WeatherModel)
    func getWeather(for city: String) -> WeatherModel?
    func getWeatherAllCities() -> [WeatherModel]?
    func update(weather: WeatherModel) -> Bool
    func delete(weather: WeatherModel) -> Bool
}

/// This is a WeatherDataRepository struct, used to perform database operations
struct WeatherDataRepository: WeatherRepository {
    func add(weather: WeatherModel) {
        let cdWeather = CDWeather(context: PersistentStorage.shared.context)
        cdWeather.city = weather.city
        cdWeather.temp = weather.temp
        cdWeather.clouds = Int16(weather.clouds)
        cdWeather.humidity = Int16(weather.humidity)
        cdWeather.pressure = Int16(weather.pressure)
        cdWeather.weather = weather.weather
        cdWeather.time = weather.time
        PersistentStorage.shared.saveContext()
    }
    
    func getWeather(for city: String) -> WeatherModel? {
        guard let res = getWeatherFor(city: city) else { return nil }
        return res.convertToWeatherModel()
    }
    
    func getWeatherAllCities() -> [WeatherModel]? {
        guard let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDWeather.self) else { return nil }
        var arrWeather = [WeatherModel]()
        result.forEach({ (obj) in
            arrWeather.append(obj.convertToWeatherModel())
        })
        return arrWeather
    }
    
    func update(weather: WeatherModel) -> Bool {
        guard let res = getWeatherFor(city: weather.city) else { return false }
        res.city = weather.city
        res.clouds = Int16(weather.clouds)
        res.humidity = Int16(weather.humidity)
        res.pressure = Int16(weather.pressure)
        res.temp = weather.temp
        res.weather = weather.weather
        res.time = weather.time
        
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func delete(weather: WeatherModel) -> Bool {
        guard let res = getWeatherFor(city: weather.city) else { return false }
        PersistentStorage.shared.context.delete(res)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func getWeatherOf(top: Int) -> [WeatherModel]? {
        guard let res = getWeatherFor(top: top) else { return nil }
        var arrWeather = [WeatherModel]()
        res.forEach({ (obj) in
            arrWeather.append(obj.convertToWeatherModel())
        })
        return arrWeather
    }
    
    private func getWeatherFor(city: String) -> CDWeather? {
        do {
            let fetchReq = NSFetchRequest<CDWeather>(entityName: "CDWeather")
            let predicate = NSPredicate(format: "city==%@", city as CVarArg)
            fetchReq.predicate = predicate
            guard let result = try PersistentStorage.shared.context.fetch(fetchReq).first else { return nil }
            return result
        }
        catch let err { print(err.localizedDescription) }
        return nil
    }
    
    private func getWeatherFor(top: Int) -> [CDWeather]? {
        do {
            let fetchReq = NSFetchRequest<CDWeather>(entityName: "CDWeather")
            fetchReq.fetchLimit = top
            let result = try PersistentStorage.shared.context.fetch(fetchReq)
            return result
        }
        catch let err { print(err.localizedDescription) }
        return nil
    }
    
    
}
