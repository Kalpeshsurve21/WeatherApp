//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 11/05/21.
//

import UIKit

/// This class is used to setup the collection cell data
class WeatherCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var imgBackground: UIImageView!
    
    //MARK: - User defined methods
    
    /// This method is used to bind the Model data to cell
    /// - Parameter obj: object of WeatherModel
    func configureCell(obj: WeatherModel?) {
        let temp = obj?.temp == nil ? "" : String(obj!.temp)
        lblTemp.text = temp + "°"
        lblWeather.text = obj?.weather
        lblCity.text = obj?.city
        lblTime.text = obj?.time
        
        guard let obj = obj else { return }
        //Change the background image according to weather type
        if obj.weather.lowercased().contains("sun") || obj.weather.lowercased().contains("cle") {
            imgBackground.image = UIImage(named: "sunny")
        }
        else { imgBackground.image = UIImage(named: "cloudy") }
    }
}
