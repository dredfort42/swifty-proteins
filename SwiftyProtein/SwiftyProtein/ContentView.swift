//
//  ContentView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 15.11.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
			Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
			Spacer()
            Text("Hello, world!")
			Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
