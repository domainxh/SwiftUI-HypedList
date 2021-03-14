//
//  PastView.swift
//  HypedList
//
//  Created by Xiaoheng Pan on 3/13/21.
//

import SwiftUI

struct PastView: View {
    
    @ObservedObject var data = DataController.shared
    
    var body: some View {
        HypedEventListView(hypedEvents: data.pastHypedEvents, noEventsText: "No events have passed yet, you should add some more things!")
        .navigationTitle("Past")
    }
}

struct PastView_Previews: PreviewProvider {
    static var previews: some View {
        PastView()
    }
}
