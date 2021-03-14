//
//  UpcomingView.swift
//  HypedList
//
//  Created by Xiaoheng Pan on 3/12/21.
//

import SwiftUI

struct UpcomingView: View {
    
    @State var showingCreateView = false
    @ObservedObject var data = DataController.shared
    
    var body: some View {
        HypedEventListView(hypedEvents: data.upcomingHypedEvents, noEventsText: "Nothing to look forward to. Create an event or checkout the Discover tab!")
            .navigationTitle("Upcoming")
            .navigationBarItems(trailing: Button(action: {
                showingCreateView = true
            }, label: {
                Image(systemName: "calendar.badge.plus")
                    .font(.title)
            }).sheet(isPresented: $showingCreateView, content: {
                CreateHypedEventView()
            }))
    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView()
    }
}
