//
//  Observable.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 11/05/21.
//

import Foundation

/// This is an observer class to observe the changes happened on viewmodel
class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    /// This method is used to bind the data to listener and the same will then be observed by the view model
    /// - Parameter listener: listener as generic completion
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
