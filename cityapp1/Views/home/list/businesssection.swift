//
//  businesssection.swift
//  cityapp1
//
//  Created by Mohammad Jamali on 3/13/23.
//

import SwiftUI

struct businesssection: View {
    var title:String
    var businesses : [businessS]
    var body: some View {
        Section (header: businesssectionheader(title: title)) {
            ForEach(businesses) { busineSS in
                
                NavigationLink {
                    businessdetail(business3: busineSS)
                } label: {
                    businessrow(businessV1: busineSS)
                }

                
                
                
            }
        }
    }
}

