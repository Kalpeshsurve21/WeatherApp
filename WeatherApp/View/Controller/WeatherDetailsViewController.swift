//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 11/05/21.
//

import UIKit

/// This class is used to show the weather details
class WeatherDetailsViewController: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblWeatherDetails: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblCloudy: UILabel!
    @IBOutlet weak var lblHumidityValue: UILabel!
    @IBOutlet weak var lblPressureValue: UILabel!
    @IBOutlet weak var lblCloudyValue: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgIcon: UIImageView!
    
    //MARK: - Local variables
    var obj: WeatherModel!
    var isBtnAddHidden = true
    private let manager = WeatherManager()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setContents()
    }
    
    //MARK: - User defined methods
    
    /// This method is used to to setup the initial UI binding
    private func setContents() {
        title = Constants.weatherDetails
        lblCity.text = obj.city
        lblWeather.text = obj.weather + ", " + obj.time
        lblTemp.text = "\(obj.temp)°"
        lblWeatherDetails.text = Constants.weatherDetails
        lblHumidity.text = Constants.humidity
        lblPressure.text = Constants.pressure
        lblCloudy.text = Constants.cloudy
        lblHumidityValue.text = "\(obj.humidity)%"
        lblPressureValue.text = "\(obj.pressure)hPa"
        lblCloudyValue.text = "\(obj.clouds)%"
        btnAdd.isHidden = isBtnAddHidden
        
        //Change the background image according to weather type
        if obj.weather.lowercased().contains("sun") || obj.weather.lowercased().contains("cle") {
            imgBackground.image = UIImage(named: "sunny")
            imgIcon.image = UIImage(systemName: "cloud.sun")
        }
        else {
            imgBackground.image = UIImage(named: "cloudy")
            imgIcon.image = UIImage(systemName: "cloud.fill")
        }
    }
    
    //MARK: - IBActions
    
    /// This method is used to perform action on add location button click to save the location in the list of locations
    /// - Parameter sender: as UIButton
    @IBAction func btnAddLocationTapped(_ sender: UIButton) {
        self.manager.add(weather: obj)
        let alert = UIAlertController(title: Constants.appName, message: Constants.locationAdded, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// This method is used to perform action on remove location button click to remove the location from the list of locations
    /// - Parameter sender: as UIButton
    @IBAction func btnRemoveLocationTapped(_ sender: UIButton) {
        let res = manager.deleteWeather(weather: obj)
        if res { //Check if we got the success or not
            self.showBackAlert(with: Constants.locationRemoved)
        }
        else {
            let alert = UIAlertController(title: Constants.appName, message: Constants.technicalError, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
