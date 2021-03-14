//
//  DataController.swift
//  HypedList
//
//  Created by Xiaoheng Pan on 3/13/21.
//

import Foundation

class DataController: ObservableObject {
    @Published var hypedEvents = [HypedEvent]()
    
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
}
