//
//  LocationsListViewController.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 11/05/21.
//

import UIKit

/// This class is used to show the list of locations
class LocationsListViewController: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tblList: UITableView!
    
    //MARK: - Local variables
    private var manager = WeatherManager()
    var viewModel = WeatherViewModel()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setContents()
    }
    
    //MARK: - User defined methods
    
    /// This method is used to to setup the initial UI binding
    private func setContents() {
        title = Constants.SavedLocations
        tblList.tableFooterView = UIView()
        tblList.alwaysBounceVertical = false
        tblList.estimatedRowHeight = 50
        
        bindViewModel()
        
        guard let arr = manager.getWeatherOf(top: 3) else { return }
        viewModel.arrWeather.value = arr
    }
    
    /// This method is used to bind the viewModel with UI
    func bindViewModel() {
        viewModel.objWeather.bind { [weak self] (response) in
            guard let resp = response else { return }
            let isPresent = self?.manager.isRecordPresent(city: resp.city)
            if self?.viewModel.arrWeather.value?.count ?? 0 < 3 { self?.manager.add(weather: resp) }
            else if isPresent! { self?.manager.add(weather: resp) }
            self?.navigateOnDetailsScreen(obj: resp, isBtnAddHidden: isPresent!)
        }
        
        viewModel.arrWeather.bind { [weak self] _ in
            self?.tblList.reloadData()
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

}

//MARK: - UITableViewDataSource
extension LocationsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrWeather.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as! LocationTableViewCell
        let obj = viewModel.arrWeather.value?[indexPath.row]
        cell.configureCell(obj: obj)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension LocationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let obj = self.viewModel.arrWeather.value?[indexPath.row] else { return }
        //Check if internet connection is available
        if Utils.isOnline() { fetchData(city: obj.city) }
        else { self.navigateOnDetailsScreen(obj: obj, isBtnAddHidden: true) }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            guard let obj = viewModel.arrWeather.value?[indexPath.row] else { return }
            let res = WeatherManager().deleteWeather(weather: obj)
            if res { //Check if we got success or not
                tableView.beginUpdates()
                viewModel.arrWeather.value?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                tableView.endUpdates()
            }
            else {
                let alert = UIAlertController(title: Constants.appName, message: Constants.technicalError, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
