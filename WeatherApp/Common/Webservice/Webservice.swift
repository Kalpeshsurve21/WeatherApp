//
//  Webservice.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 10/05/21.
//

import Foundation

/// This struct is used to have a common network layer for making api call to server
struct Webservice {
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completion:@escaping(_ result: T?)-> Void) {
        URLSession.shared.dataTask(with: requestUrl) { (response, _, error) in
            guard let responseData = response else {
                completion(nil)
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: responseData)
                completion(result)
            }
            catch let error {
                debugPrint("error occured while decoding = \(error)")
                completion(nil)
            }
        }.resume()
    }
}
