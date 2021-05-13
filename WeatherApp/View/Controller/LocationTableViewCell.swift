//
//  LocationTableViewCell.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 11/05/21.
//

import UIKit

/// This class is used to setup the collection cell data
class LocationTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    
    //MARK: - User defined methods
    
    /// This method is used to bind the Model data to cell
    /// - Parameter obj: object of WeatherModel
    func configureCell(obj: WeatherModel?) {
        let temp = obj?.temp == nil ? "" : String(obj!.temp)
        lblTemp.text = temp + "°"
        lblLocation.text = obj?.city
    }

}
