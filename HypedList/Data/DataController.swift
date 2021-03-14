//
//  DataController.swift
//  HypedList
//
//  Created by Xiaoheng Pan on 3/13/21.
//

import Foundation
import SwiftDate
import SwiftUI

class DataController: ObservableObject {
    @Published var hypedEvents = [HypedEvent]()
    @Published var discoverHypedEvents: [HypedEvent] = []
    
    var upcomingHypedEvents: [HypedEvent] {
        return hypedEvents.filter { $0.date > Date().dateAt(.startOfDay) }.sorted { $0.date < $1.date}
    }
    
    var pastHypedEvents: [HypedEvent] {
        return hypedEvents.filter { $0.date < Date().dateAt(.startOfDay) }.sorted { $0.date < $1.date}
    }
    
    private let key = "hypedEvents"
    static var shared = DataController()
    
    private init() {}
    
    func saveData() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.hypedEvents) {
                UserDefaults.standard.setValue(encoded, forKey: self.key)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    func loadData() {
        DispatchQueue.global().async {
            if let data = UserDefaults.standard.data(forKey: self.key) {
                let decoder = JSONDecoder()
                if let decodedEvent = try? decoder.decode([HypedEvent].self, from: data) {
                    DispatchQueue.main.async {
                        self.hypedEvents = decodedEvent
                    }
                }
            }
        }
    }
    
    func getDiscoverEvents() {
        let url = URL(string: "https://api.jsonbin.io/b/604d6a467ea6546cf3dd104b/1")!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]] {
                for item in json {
                    var hypedEventsToAdd: [HypedEvent] = []
                    
                    for jsonHypedEvent in json {
                        let hypedEvent = HypedEvent()
                        if let id = jsonHypedEvent["id"] {
                            hypedEvent.id = id
                        }
                        if let dateString = jsonHypedEvent["date"] {
                            SwiftDate.defaultRegion = Region.local
                            if let dateInRegion = dateString.toDate() {
                                hypedEvent.date = dateInRegion.date
                            }
                        }
                        if let title = jsonHypedEvent["title"] {
                            hypedEvent.title = title
                        }
                        if let url = jsonHypedEvent["url"] {
                            hypedEvent.url = url
                        }
                        if let colorHex = jsonHypedEvent["color"] {
                            hypedEvent.color = Color(UIColor("#" + colorHex))
                        }
                        if let imageURL = jsonHypedEvent["imageURL"] {
                            if let url = URL(string: imageURL) {
                                if let data = try? Data(contentsOf: url) {
                                    hypedEvent.imageData = data
                                }
                            }
                        }
                        hypedEventsToAdd.append(hypedEvent)
                    }
                    DispatchQueue.main.async {
                        self.discoverHypedEvents = hypedEventsToAdd
                    }
                }
            }
        }.resume()
    }
}
