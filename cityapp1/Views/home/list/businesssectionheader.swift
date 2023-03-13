//
//  businesssectionheader.swift
//  cityapp1
//
//  Created by Mohammad Jamali on 3/13/23.
//

import SwiftUI

struct businesssectionheader: View {
    var title:String
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(.white)
            Text(title).font(.headline)
        }
    }
}

