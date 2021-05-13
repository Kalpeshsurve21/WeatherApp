//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 11/05/21.
//

import Foundation

/// This is WeatherViewModel struct used to bind the data to and from the view and model
struct WeatherViewModel {
    
    //MARK: - Local variables
    var objWeather: Observable<WeatherModel> = Observable(nil)
    var arrWeather: Observable<[WeatherModel]> = Observable([])
    private var webservice = Webservice()
    
    /// This method is used to check if the entered city isk valid or not (check for min of 3characters)
    /// - Parameter city: city as string
    /// - Returns: if valid return true else false
    func isValid(city: String) -> Bool {
        if city.count > 2 { return true }
        else { return false }
    }
    
    /// This method is used to make an api call to fetch the details from server for passed request
    /// - Parameters:
    ///   - request: as an object of WeatherRequest
    ///   - completion: result of completion as an object of WeatherModel or nil in case of failure
    func fetchWeatherDetails(request: WeatherRequest, completion: @escaping(_ result: WeatherModel?) -> Void) {
        guard let endpoint = URL(string: Endpoints.baseUrl) else { return }

        var components = URLComponents(url: endpoint, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "q", value: request.city), URLQueryItem(name: "appid", value: Constants.weatherAppId)]

        guard let url = components?.url else { return }
        
        webservice.getApiData(requestUrl: url, resultType: WeatherResponse.self) { (response) in
            if let resp = response { //Check if we got the response
                let objWeather = resp.convertToWeatherViewModel()
                DispatchQueue.main.async { completion(objWeather) }
            }
            else { DispatchQueue.main.async { completion(nil) } }
        }
    }
}

