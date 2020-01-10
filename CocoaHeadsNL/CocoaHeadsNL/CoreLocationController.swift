//
//  CoreLocationController.swift
//  CocoaHeadsNL
//
//  Created by Bart Hoffman on 23/08/15.
//  Copyright (c) 2016 Stichting CocoaheadsNL. All rights reserved.
//

import Foundation
import CoreLocation

class CoreLocationController: NSObject, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    let locationNotification = "LOCATION_AVAILABLE"

    override init() {
        super.init()

        self.locationManager.delegate = self
        self.locationManager.distanceFilter = 5000
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        self.locationManager.requestWhenInUseAuthorization()
    }

    // MARK: - CLLocationManagerDelegate methods

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorizationStatus")

        switch status {
        case .notDetermined:
            print(".NotDetermined")
        case .authorizedAlways:
            print(".Authorized")
        case .authorizedWhenInUse:
            print(".AuthorizedWhenInUse")
            self.locationManager.startUpdatingLocation()
        case .denied:
            print(".Denied")
        default:
            print("Unhandled authorization status")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location = locations.last!

        print("didUpdateLocations:  \(location.coordinate.latitude), \(location.coordinate.longitude)")

        let userInfo = [ "location": location]

        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: Notification.Name(rawValue: locationNotification), object: nil, userInfo: userInfo)
    }
}
