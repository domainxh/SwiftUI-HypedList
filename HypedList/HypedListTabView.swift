//
//  ContentView.swift
//  HypedList
//
//  Created by Xiaoheng Pan on 3/12/21.
//

import SwiftUI

struct HypedListTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                UpcomingView()
            }.tabItem {
                Image(systemName: "calendar")
                Text("Upcoming")
            }
            Text("Hello2")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Discover")
                }
            Text("Hello2")
                .tabItem {
                    Image(systemName: "gobackward")
                    Text("Past")
                }
        }
    }
}

struct HypedListTabView_Previews: PreviewProvider {
    static var previews: some View {
        HypedListTabView()
    }
}
