//
//  contentmodel.swift
//  cityapp1
//
//  Created by Mohammad Jamali on 3/11/23.
//

import Foundation
import CoreLocation

class contentmodelC: NSObject, CLLocationManagerDelegate, ObservableObject {
    var locationmanager = CLLocationManager()
    
    override init() {
        //init method of NSObject
        super.init()
        //set content model as the gelegate of the location manager
        locationmanager.delegate = self
        //request permission from the user
        locationmanager.requestWhenInUseAuthorization()
        //
    }
    //MARK: - Location manager delegate methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationmanager.authorizationStatus == .authorizedAlways || locationmanager.authorizationStatus == .authorizedWhenInUse {
            //we have permission
            //start geolocating the user, after we get permission
            locationmanager.startUpdatingLocation()
        }
        else if locationmanager.authorizationStatus == .denied {
            //we don't have permission
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //gives us the location of the user
        let userlocation = locations.first
        if userlocation != nil {
            //stop requestion the location after we got it
            locationmanager.stopUpdatingLocation()
            //if we have the coordinates of the user, send into Yelp API
            //getbusiness1(category: "art", location: userlocation)
            getbusiness1(category: "restaurants", location: userlocation!)
        }
    }
    
    // MARK: - Yelp API methods
    func getbusiness1(category:String, location:CLLocation) {
       //create URL first way
        /*
        let urlstring = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        */
        //create URL second way
        var urlcomponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlcomponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        let url = urlcomponents?.url
        
        if let url = url {
            //create URL request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer NSbRclbDzB_0WAQEa3GRU9-RMkmNpqHrCMXcwgriJCDf0-ltpVSMl3vDd-IwWCuDMtjznm8F8qcL0mN81XFke9g9FPevy-O728pr0Ym40pq3u1U4xSLd_J10Uw8NZHYx", forHTTPHeaderField: "Authorization")
            //Get URLsession
            let session = URLSession.shared
            //create data task
            let datatask = session.dataTask(with: request) { (data1, response1, error1) in
                //check that there isn't an error
                if error1 == nil {
                    print(response1)
                    print("aaaaaaaa")
                }
            }
            //start the data task
            datatask.resume()
        }
        
    }
}
