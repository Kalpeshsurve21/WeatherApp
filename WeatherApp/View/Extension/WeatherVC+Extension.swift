//
//  WeatherVC+Extension.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 11/05/21.
//

import UIKit

//MARK:- UICollectionViewDataSource
extension WeatherViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrWeather.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Weathercell", for: indexPath) as! WeatherCollectionViewCell
        let obj = viewModel.arrWeather.value?[indexPath.row]
        cell.configureCell(obj: obj)
        cell.layer.cornerRadius = 8.0
        cell.layer.masksToBounds = true
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension WeatherViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let obj = self.viewModel.arrWeather.value?[indexPath.row] else { return }
        //Check if internet connection is available
        if Utils.isOnline() { fetchData(city: obj.city) }
        else { self.navigateOnDetailsScreen(obj: obj, isBtnAddHidden: true) }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2.5, height: collectionView.bounds.height)
    }
}

//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let city = textField.text ?? ""
        txtSearch.text = ""
        if viewModel.isValid(city: city) { fetchData(city: city) }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Below code is to find length of textfield text if it is less than 20 then it is accepted else not accepted
        guard let text = textField.text else { return true }
        
        //To prevent user, entering space at the start of textfield
        if (range.location == 0 && string == " ") {
            return false
        }
        
        // Get text
        let newLength = text.utf16.count + string.utf16.count - range.length
        let strInput = text + string
        if newLength <= 64 {
            return Utils.isValid(strInput: strInput, regex: Constants.CityRegX)
        }
        
        return false
    }
}
