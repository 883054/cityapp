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
    @Published var authorizationstate = CLAuthorizationStatus.notDetermined
    @Published var restaurantsV = [businessS]()
    @Published var sightsV = [businessS]()
    
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
        //update the authorizationstate property
        authorizationstate = locationmanager.authorizationStatus
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
            getbusiness1(category: constantsS.sightskey, location: userlocation!)
            getbusiness1(category: constantsS.restaurantskey, location: userlocation!)
        }
    }
    
    // MARK: - Yelp API methods
    func getbusiness1(category:String, location:CLLocation) {
       //create URL first way
        /*
        let urlstring = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        */
        //create URL second way
        var urlcomponents = URLComponents(string: constantsS.apiurl)
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
            request.addValue("Bearer \(constantsS.apikey)", forHTTPHeaderField: "Authorization")
            //Get URLsession
            let session = URLSession.shared
            //create data task
            let datatask = session.dataTask(with: request) { (data1, response1, error1) in
                //check that there isn't an error
                if error1 == nil {
                    do {
                       //parse Json
                        let decoder = JSONDecoder()
                        let result1 = try decoder.decode(businesssearch.self, from: data1!)
                        //sort businesses based on distance
                        var businesses2 = result1.businesses
                        businesses2.sort { (b1, b2) -> Bool in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        //call the get image fuction of the businesses
                        for b in businesses2 {
                            b.getimagedata()
                        }
                        DispatchQueue.main.async {
                            //assing results to the appropriate property
                            /*
                            if category == constantsS.sightskey {
                                self.sightsV = usinesses2
                            }
                            else if category == constantsS.restaurantskey {
                                self.restaurantsV = usinesses2
                            }
                            */
                            // same as if statement above
                            switch category {
                            case constantsS.sightskey:
                                self.sightsV = businesses2
                            case constantsS.restaurantskey:
                                self.restaurantsV = businesses2
                            default:
                                break
                            }
                        }
                        
                        
                        
                    } catch {
                        print(error)
                    }
                    
                    
                    
                }
            }
            //start the data task
            datatask.resume()
        }
        
    }
}
