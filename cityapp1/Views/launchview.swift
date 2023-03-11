//
//  launchview.swift
//  cityapp1
//
//  Created by Mohammad Jamali on 3/11/23.
//

import SwiftUI

struct launchview: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct launchview_Previews: PreviewProvider {
    static var previews: some View {
        launchview()
    }
}
