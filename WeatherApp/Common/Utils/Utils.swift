//
//  Utils.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 13/05/21.
//

import Foundation
import SystemConfiguration

/// This is an utility class which contains commanly used methods
class Utils {
    
    /// This method is used to perform regex on passed input string
    /// - Parameters:
    ///   - strInput: input string
    ///   - regex: regex formula
    /// - Returns: true is valid else false
    class func isValid(strInput: String,regex:String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with:strInput)
    }
    
    /// This method is used to get the current time in AM/PM format
    /// - Returns: return string of time
    class func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let strDate = dateFormatter.string(from: Date())
        return strDate
    }
    
    /// This method is used to convert the temperature from kelvin to celcius
    /// - Parameter kelvin: kelvin as Double
    /// - Returns: in celcius as double
    class func convertToCelcius(from kelvin: Double) -> Double {
        var result = kelvin - 273.15
        result = Double(round(100*result)/100)
        return result
    }
    
    /// This method is used to greet user according to time
    /// - Returns: Greet message as string
    class func greetMessage() -> String {
        let hrComponents = Calendar.current.component(.hour, from: Date())
        if hrComponents < 12 { return Constants.goodMorning }
        else if hrComponents < 16 { return Constants.goodNoon }
        else { return Constants.goodEvening }
    }
    
    /// This method is used to check if the internet connection active on mobile
    /// - Returns: true if connection is active else false
    class func isOnline() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
