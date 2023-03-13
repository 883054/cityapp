//
//  businessdetail.swift
//  cityapp1
//
//  Created by Mohammad Jamali on 3/13/23.
//

import SwiftUI

struct businessdetail: View {
    var business3: businessS
    var body: some View {
        VStack {
            VStack {
                //business image
                GeometryReader() {geometry in
                    let UIImage3 = UIImage(data: business3.imagedata ?? Data())
                    Image(uiImage: UIImage3 ?? UIImage())
                        .resizable().frame(width: geometry.size.width, height: geometry.size.height).clipped()
                }

                ZStack {
                    Rectangle().frame(height:36).foregroundColor(business3.is_closed! ? .gray: .blue)
                    Text(business3.is_closed! ? "closed" : "open")
                }
            }

            
            Group {
                //Business name
                Text(business3.name!).font(.largeTitle)
                //loop through display address
                if business3.location?.display_address != nil {
                    ForEach(business3.location!.display_address!, id: \.self) {displayline in
                        Text(displayline)
                    }
                }
                //rating
                Image("regular_\(business3.rating ?? 0.0)")
                Divider()
                //phone
                HStack {
                    Text("phone:").bold()
                    Text(business3.display_phone ?? "")
                    Spacer()
                    Link("call", destination: URL(string: "tel:\(business3.phone ?? "")")!)
                }
                Divider()
                //reivews
                HStack {
                    Text("reviews:").bold()
                    Text(String(business3.review_count ?? 0))
                    Spacer()
                    Link("read", destination: URL(string: "\(business3.url ?? "")")!)
                }
                Divider()
                //website
                HStack {
                    Text("website:").bold()
                    Text(business3.url ?? "").lineLimit(1)
                    Spacer()
                    Link("visit", destination: URL(string: "\(business3.url ?? "")")!)
                }
                Divider()
            }
            //get direction button
            Button {
                //todo
            } label: {
                ZStack {
                    Rectangle().frame(height: 48)
                    Text("get directions").foregroundColor(.white)
                }
            }

        }
    }
}


