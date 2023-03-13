//
//  launchview.swift
//  cityapp1
//
//  Created by Mohammad Jamali on 3/11/23.
//

import SwiftUI
import CoreLocation

struct launchview: View {
    @EnvironmentObject var modelV1 : contentmodelC
    
    var body: some View {
//detec the authorization status of geolocation the user
        if modelV1.authorizationstate == .notDetermined{
            //if not determinded, show onboarding
        }
        else if modelV1.authorizationstate == .authorizedAlways || modelV1.authorizationstate == .authorizedWhenInUse {
            //if approved, show home view
            homeview()
        }
        else {
            //if denied show the denied view
        }
        
    }
}

struct launchview_Previews: PreviewProvider {
    static var previews: some View {
        launchview().environmentObject(contentmodelC())
    }
}
