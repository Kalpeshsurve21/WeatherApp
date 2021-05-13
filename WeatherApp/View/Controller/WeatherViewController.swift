//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 11/05/21.
//

import UIKit

/// This class is used to search and show the recent weather details
class WeatherViewController: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var lblGreet: UILabel!
    @IBOutlet weak var lblCheckWeather: UILabel!
    @IBOutlet weak var lblMyLocations: UILabel!
    @IBOutlet weak var colViwLocations: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viwSearch: UIView!
    @IBOutlet weak var lblNoLocations: UILabel!
    
    //MARK: - Local variables
    private let manager = WeatherManager()
    var viewModel = WeatherViewModel()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let arr = manager.getWeatherOf(top: 3) else { return }
        viewModel.arrWeather.value = arr
    }
    
    //MARK: - User defined methods
    
    /// This method is used to to setup the initial UI binding
    private func setContent() {
        self.title = Constants.appName
        lblGreet.text = Utils.greetMessage()
        lblCheckWeather.text = Constants.checkWeatherByCity
        lblMyLocations.text = Constants.MyLocations
        
        colViwLocations.collectionViewLayout = flowLayout
        flowLayout.itemSize = CGSize(width: flowLayout.itemSize.width, height: flowLayout.itemSize.height)
        flowLayout.minimumInteritemSpacing = 6.0
        flowLayout.minimumLineSpacing = 6.0
        
        viwSearch.layer.cornerRadius = 15.0
        viwSearch.layer.borderWidth = 1.0
        viwSearch.layer.borderColor = UIColor.white.cgColor
        txtSearch.delegate = self
        txtSearch.attributedPlaceholder = NSAttributedString(string: "Search city",
                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        bindViewModel()
    }
    
    /// This method is used to bind the viewModel with UI
    func bindViewModel() {
        viewModel.objWeather.bind { [unowned self] (response) in
            guard let resp = response else { return }
            let isPresent = self.manager.isRecordPresent(city: resp.city)
            if self.viewModel.arrWeather.value?.count ?? 0 < 3 { self.manager.add(weather: resp) }
            else if isPresent { self.manager.add(weather: resp) }
            self.navigateOnDetailsScreen(obj: resp, isBtnAddHidden: isPresent)
        }
        
        viewModel.arrWeather.bind { [weak self] _ in
            let count = self?.viewModel.arrWeather.value?.count ?? 0
            self?.lblNoLocations.isHidden = count > 0 ? true : false
            self?.colViwLocations.reloadData()
        }
    }
    
    /// This method is used to fetch the weather details from api for particular city
    /// - Parameter city: city as string
    func fetchData(city: String) {
        self.showActivity(viw: self.view)
        let obj = WeatherRequest(city: city)
        WeatherViewModel().fetchWeatherDetails(request: obj) { [weak self] (response) in
            self?.hideActivity()
            if let resp = response { //Check if we got the reponse or not
                self?.viewModel.objWeather.value = resp
            }
            else {
                let alert = UIAlertController(title: Constants.appName, message: Constants.technicalError, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    /// This method is used to navigate user on weather details screen
    /// - Parameter obj: object of WeatherModel
    func navigateOnDetailsScreen(obj: WeatherModel, isBtnAddHidden: Bool = false) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "WeatherDetailsViewController") as! WeatherDetailsViewController
        vc.obj = obj
        vc.isBtnAddHidden = isBtnAddHidden
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - IBActions
    
    /// This method is used to perform action on locations button click to show the list of locations
    /// - Parameter sender: as UIButton
    @IBAction func btnLocationsTapped(_ sender: UIButton) {
        //Check if locations are added or not
        if viewModel.arrWeather.value?.count ?? 0 > 0 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "LocationsListViewController") as! LocationsListViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let alert = UIAlertController(title: Constants.appName, message: Constants.NoLocationFound, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /// This method is used to perform action on Search button click to show the weather of entered city
    /// - Parameter sender: as UIbutton
    @IBAction func btnSearchTapped(_ sender: UIButton) {
        let city = txtSearch.text ?? ""
        txtSearch.text = ""
        if viewModel.isValid(city: city) { fetchData(city: city) }
    }

}
