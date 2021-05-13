//
//  Constants.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 10/05/21.
//

import Foundation

/// This struct cotains all string constants
struct Constants {
    static let appName = "WeatherApp"
    static let weatherAppId = "d2368ded0701e76163d8d3af71a5d13e"
    
    //RegX
    static let CityRegX = "^[a-zA-Z0-9 ]+$"
    
    //Static message shown to user (Must be kept in localizable file)
    static let locationAdded = "Location has been successfully added to My locations list."
    static let locationRemoved = "Location has been successfully removed from the list of saved locations."
    static let technicalError = "Due to technical issue we are unable to process your request at this time, please try again later."
    static let NoLocationFound = "You have not added any location in the My Locations list, pls search weather by city and add it in your My Locations list."
    
    //Constant strings (Must be kept in localizable file)
    static let goodMorning = "Good morning.!"
    static let goodNoon = "Good afternoon.!"
    static let goodEvening = "Good evening.!"
    static let checkWeatherByCity = "Check the weather by city"
    static let MyLocations = "My Locations"
    static let SavedLocations = "Saved Locations"
    static let weatherDetails = "Weather details"
    static let humidity = "Humidity"
    static let pressure = "Pressure"
    static let cloudy = "Cloudy"
}
