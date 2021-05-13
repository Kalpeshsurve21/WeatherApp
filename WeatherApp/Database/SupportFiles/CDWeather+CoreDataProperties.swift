//
//  CDWeather+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 11/05/21.
//
//

import Foundation
import CoreData


extension CDWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDWeather> {
        return NSFetchRequest<CDWeather>(entityName: "CDWeather")
    }

    @NSManaged public var city: String?
    @NSManaged public var temp: Double
    @NSManaged public var humidity: Int16
    @NSManaged public var pressure: Int16
    @NSManaged public var clouds: Int16
    @NSManaged public var weather: String?
    @NSManaged public var time: String?
    
    func convertToWeatherModel() -> WeatherModel {
        let obj = WeatherModel(city: self.city ?? "", temp: self.temp, humidity: Int(self.humidity), pressure: Int(self.pressure), clouds: Int(self.clouds), weather: self.weather ?? "", time: self.time ?? "")
        return obj
    }

}

extension CDWeather : Identifiable {

}
