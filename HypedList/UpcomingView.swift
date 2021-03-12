//
//  UpcomingView.swift
//  HypedList
//
//  Created by Xiaoheng Pan on 3/12/21.
//

import SwiftUI

struct UpcomingView: View {
    
    @State var showingCreateView = false
        
    var body: some View {
        Text("Upcoming View")
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
