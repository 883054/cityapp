//
//  homeview.swift
//  cityapp1
//
//  Created by Mohammad Jamali on 3/13/23.
//

import SwiftUI

struct homeview: View {
    @EnvironmentObject var modelV2 : contentmodelC
    @State var ismapshowing = false
    var body: some View {
        if modelV2.restaurantsV.count != 0 || modelV2.sightsV.count != 0 {
            
            NavigationView {
                //determine if we should show list or map view
                if !ismapshowing {
                    //show list view
                    VStack {
                        HStack {
                            Image(systemName: "location")
                            Text("ghanbary")
                            Spacer()
                            Text("switch to map view")
                        }
                        Divider()
                        businesslist()
                    }
                }
                else {
                    //show map view
                }
            }
        }
        else {
            //still waiting for data, so show spinner
            ProgressView()
        }
    }
}

struct homeview_Previews: PreviewProvider {
    static var previews: some View {
        homeview().environmentObject(contentmodelC())
    }
}
