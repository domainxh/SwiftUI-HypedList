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
        HypedEventEntry(date: Date(), hypedEvent: testHypedEvent1)
    }

    func getSnapshot(in context: Context, completion: @escaping (HypedEventEntry) -> ()) {
        let entry = HypedEventEntry(date: Date(), hypedEvent: testHypedEvent1)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [HypedEventEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = HypedEventEntry(date: entryDate, hypedEvent: testHypedEvent1)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct HypedEventEntry: TimelineEntry {
    let date: Date
    let hypedEvent: HypedEvent
}

struct HypedList_iOS_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.hypedEvent.title)
    }
}

@main
struct HypedList_iOS_Widget: Widget {
    let kind: String = "HypedList_iOS_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HypedList_iOS_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct HypedList_iOS_Widget_Previews: PreviewProvider {
    static var previews: some View {
        HypedList_iOS_WidgetEntryView(entry: HypedEventEntry(date: Date(), hypedEvent: testHypedEvent1))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
