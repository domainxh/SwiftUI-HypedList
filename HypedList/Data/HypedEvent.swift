//
//  HypedEvent.swift
//  HypedList
//
//  Created by Xiaoheng Pan on 3/12/21.
//

import Foundation
import SwiftUI
import SwiftDate
import UIColor_Hex_Swift

class HypedEvent: ObservableObject, Identifiable, Codable {
    
    var id = UUID().uuidString
    var date = Date() + 8.days
    var title = ""
    var url = ""
    var color = Color.purple
    @Published var imageData: Data?
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case title
        case url
        case color
        case imageData
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: CodingKeys.id)
        try container.encode(date, forKey: CodingKeys.date)
        try container.encode(title, forKey: CodingKeys.title)
        try container.encode(url, forKey: CodingKeys.url)
        try container.encode(UIColor(color).hexString(), forKey: CodingKeys.color)
        try container.encode(imageData, forKey: CodingKeys.imageData)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        date = try values.decode(Date.self, forKey: .date)
        title = try values.decode(String.self, forKey: .title)
        url = try values.decode(String.self, forKey: .url)
        let colorHex = try values.decode(String.self, forKey: .color)
        color = Color(UIColor(colorHex))
        imageData = try? values.decode(Data.self, forKey: .imageData)
    }
    
    init() {}
    
    func image() -> Image? {
        if let data = imageData, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }
        return nil
    }
    
    func dateAsString() -> String {
        let formatter = DateFormatter()
        if date.compare(.isThisYear) {
            formatter.dateFormat = "MMM d"
        } else {
            formatter.dateFormat = "MMM d yyyy"
        }
        return formatter.string(from: date)
    }
    
    func timeFromNow() -> String {
        date.toRelative()
    }
}

var testHypedEvent1: HypedEvent {
    let hypedEvent = HypedEvent()
    if let uiImage = UIImage(named: "pngImage"), let data = uiImage.pngData() {
        hypedEvent.imageData = data
    }
    
    hypedEvent.title = "WWDC 2021"
    hypedEvent.color = .green
    hypedEvent.date = Date() + 4.days + 1.years
    hypedEvent.url = "apple.com"
    
    return hypedEvent
}

var testHypedEvent2: HypedEvent {
    let hypedEvent = HypedEvent()
    if let uiImage = UIImage(named: "pngImage"), let data = uiImage.pngData() {
        hypedEvent.imageData = data
    }
    
    hypedEvent.title = "Family Trip"
    hypedEvent.color = .red
    hypedEvent.date = Date()
    hypedEvent.url = "google.com"
    
    return hypedEvent
}
