//
//  AppDefaults.swift
//  ArmMaps
//
//  Created by Aswin R on 14/09/24.
//

import Foundation

struct StorageKeys {
    static let latitude = "latitude"
    static let longitude = "longitude"
}

class AppDefaults {
    
    static let shared = AppDefaults()
    
    private static var lastLatitude: Double = 0.0
    private static var lastLongitude: Double = 0.0
    
    private let userDefaults = UserDefaults.standard
    
    var latitude: Double {
        get {
            return userDefaults.double(forKey: StorageKeys.latitude)
        }
        
        set {
            userDefaults.set(newValue, forKey: StorageKeys.latitude)
        }
    }
    
    var longitude: Double {
        get {
            return userDefaults.double(forKey: StorageKeys.longitude)
        }
        
        set {
            userDefaults.set(newValue, forKey: StorageKeys.longitude)
        }
    }
    
    private init() {}
    
    func getLastLocation() -> LocationModel {
        return LocationModel(latitude: latitude, longitude: longitude)
    }
}
