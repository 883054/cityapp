//
//  businesslist.swift
//  cityapp1
//
//  Created by Mohammad Jamali on 3/13/23.
//

import SwiftUI

struct businesslist: View {
    @EnvironmentObject var modelV3 : contentmodelC
    var body: some View {
        ScrollView {
            LazyVStack {
                businesssection(title:"restauratns", businesses: modelV3.restaurantsV)
                businesssection(title:"sights", businesses: modelV3.sightsV)
            }
        }
    }
}

struct businesslist_Previews: PreviewProvider {
    static var previews: some View {
        businesslist()
    }
}
