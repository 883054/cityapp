//
//  businessrow.swift
//  cityapp1
//
//  Created by Mohammad Jamali on 3/13/23.
//

import SwiftUI

struct businessrow: View {
    @ObservedObject var businessV1 : businessS
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                //Image
                let UIimage1 = UIImage(data: businessV1.imagedata ?? Data())
                Image(uiImage: UIimage1 ?? UIImage()).resizable().scaledToFit()
                //name and distance
                VStack {
                    Text(businessV1.name ?? "")
                    Text(String(format:"%.1f km away",(businessV1.distance ?? 0)/1000)).font(.caption)
                }
                Spacer()
                //star rating and number of reviews
                VStack {
                    Image("regular_\(businessV1.rating ?? 0.0)")
                    Text("\(businessV1.review_count ?? 0) reviews").font(.caption)
                }
            }
            Divider()
        }
    }
}

