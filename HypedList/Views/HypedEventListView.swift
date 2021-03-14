//
//  HypedEventListView.swift
//  HypedList
//
//  Created by Xiaoheng Pan on 3/13/21.
//

import SwiftUI

struct HypedEventListView: View {
    
    var hypedEvents: [HypedEvent]
    var noEventsText: String
    
    var body: some View {
        ScrollView {
            VStack {
                if hypedEvents.count == 0 {
                    Text(noEventsText)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.top, 50)
                        .padding(.horizontal, 10)
                } else {
                    ForEach(hypedEvents, id: \.id) { event in
                        HypedEventTileView(hypedEvent: event)
                    }
                }
            }
        }
    }
}

struct HypedEventListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HypedEventListView(hypedEvents: [testHypedEvent1, testHypedEvent2], noEventsText: "Nothing to show")
            HypedEventListView(hypedEvents: [], noEventsText: "Nothing to show")
        }
    }
}
