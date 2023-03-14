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
    @State var selectedbusiness: businessS?
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
                            Button("switch to map view") {
                                self.ismapshowing = true
                            }
                            
                        }
                        Divider()
                        businesslist().ignoresSafeArea()
                    }
                }
                else {
                    ZStack (alignment: .top) {
                        //show map view
                        businessmap(selectedbusiness2: $selectedbusiness).ignoresSafeArea().sheet(item: $selectedbusiness) { business in
                            //create a business detail view instance
                            //pass in the selected business
                            businessdetail(business3: business)
                        }
                        //overlay
                        ZStack {
                            Rectangle().foregroundColor(.white).frame(height: 48)
                            HStack {
                                Image(systemName: "location")
                                Text("ghanbary")
                                Spacer()
                                Button("switch to list view") {
                                    self.ismapshowing = false
                                }
                            }
                        }
                        
                    }
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
