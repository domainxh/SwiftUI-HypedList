//
//  HypedList_iOS_Widget.swift
//  HypedList-iOS-Widget
//
//  Created by Xiaoheng Pan on 3/14/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> HypedEventEntry {
        let placeholderHypedEvent = HypedEvent()
//        placeholderHypedEvent.color = .green
        placeholderHypedEvent.title = "Loading..."
        return HypedEventEntry(date: Date(), hypedEvent: placeholderHypedEvent)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (HypedEventEntry) -> ()) {
        let upcoming = DataController.shared.getUpcomingForWidget()
        var entry = HypedEventEntry(date: Date(), hypedEvent: testHypedEvent1)
        
        if upcoming.count > 0 {
            entry = HypedEventEntry(date: Date(), hypedEvent: upcoming.randomElement())
        }
        
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [HypedEventEntry] = []
        
        let upcoming = DataController.shared.getUpcomingForWidget()
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< upcoming.count {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = HypedEventEntry(date: entryDate, hypedEvent: upcoming[hourOffset])
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct HypedEventEntry: TimelineEntry {
    let date: Date
    let hypedEvent: HypedEvent?
}

struct HypedList_iOS_WidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        GeometryReader { geometry in
            if let hypedEvent = entry.hypedEvent {
                ZStack {
                    if let image = hypedEvent.image() {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    } else {
                        hypedEvent.color
                    }
                    Color.black.opacity(0.1)
                    
                    Text(hypedEvent.title)
                        .foregroundColor(.white)
                        .font(fontSize())
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text(hypedEvent.timeFromNow())
                                .bold()
                                .padding(10)
                                .foregroundColor(.white)
                        }
                    }
                }
                
            } else {
                VStack {
                    Spacer()
                    Text("No events upcoming. Tap me to add something!")
                        .padding()
                        .multilineTextAlignment(.center)
                        .font(fontSize())
                    Spacer()
                }
            }
        }
    }
    
    func fontSize() -> Font {
        switch widgetFamily {
        case .systemSmall:
            return .title3
        case .systemMedium:
            return .title
        case .systemLarge:
            return .largeTitle
        @unknown default:
            return .body
        }
    }
}

@main
struct HypedList_iOS_Widget: Widget {
    let kind: String = "HypedList_iOS_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HypedList_iOS_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("HypedEvent Widget")
        .description("See your upcoming events")
    }
}

struct HypedList_iOS_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HypedList_iOS_WidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: testHypedEvent1))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            HypedList_iOS_WidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: testHypedEvent1))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            HypedList_iOS_WidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: testHypedEvent1))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
            
            
//            HypedList_iOS_WidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: testHypedEvent2))
//                .previewContext(WidgetPreviewContext(family: .systemSmall))
//            HypedList_iOS_WidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: testHypedEvent2))
//                .previewContext(WidgetPreviewContext(family: .systemMedium))
//            HypedList_iOS_WidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: testHypedEvent2))
//                .previewContext(WidgetPreviewContext(family: .systemLarge))
//
//
//            HypedList_iOS_WidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: nil))
//                .previewContext(WidgetPreviewContext(family: .systemSmall))
//            HypedList_iOS_WidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: nil))
//                .previewContext(WidgetPreviewContext(family: .systemMedium))
//            HypedList_iOS_WidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: nil))
//                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
        
    }
}
