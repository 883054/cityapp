//
//  businessmap.swift
//  cityapp1
//
//  Created by Mohammad Jamali on 3/14/23.
//

import SwiftUI
import MapKit

struct businessmap: UIViewRepresentable {
    @EnvironmentObject var modelV5 : contentmodelC
    @Binding var selectedbusiness2: businessS?
    var locations:[MKPointAnnotation] {
        var annotations1 = [MKPointAnnotation]()
        //create a set of annotations from our list of businesses
        for business in modelV5.restaurantsV + modelV5.sightsV {
            //if business has a lat/long, create a MKPointAnnotation for it
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                //create a new annotation
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                annotations1.append(a)
            }
        }
        return annotations1
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapview1 = MKMapView()
        mapview1.delegate = context.coordinator
        //make the user show up on the map
        mapview1.showsUserLocation = true
        mapview1.userTrackingMode = .followWithHeading
        //todo: set the region
        return mapview1
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //remove all annotations
        //uiView.removeAnnotation(uiView.annotations)
        //add the one based on the business
        uiView.showAnnotations(self.locations, animated: true)
    }
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        
    }
    
    // MARK: -- coordinator class
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self)
    }
 
      
      
    class Coordinator: NSObject, MKMapViewDelegate {
        var map: businessmap
        init(map: businessmap) {
            self.map = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            //if the annotation is the user blue do, return nol
            if annotation is MKUserLocation {
                return nil
            }
            //check if there's a resuable annotation view first
            var annotationview = mapView.dequeueReusableAnnotationView(withIdentifier: constantsS.annotationresueid)
            if annotationview == nil {
                //create a new one
                annotationview = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: constantsS.annotationresueid)
                annotationview!.canShowCallout = true
                annotationview!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            else {
                //we got a resualbe one
                annotationview!.annotation = annotation
            }
            //return it
            return annotationview
        }
        
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            //user tapped on the annotation view
            
            //get the business object that this annotation represents
            //loop through business in the model and find a match
            for business in map.modelV5.restaurantsV + map.modelV5.sightsV {
                if business.name == view.annotation?.title {
                    //set the selectedbusiness property to that business object
                    map.selectedbusiness2 = business
                    return 
                }
                
                
            }
            
        }
    }

 }
