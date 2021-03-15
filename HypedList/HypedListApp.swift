//
//  HypedListApp.swift
//  HypedList
//
//  Created by Xiaoheng Pan on 3/12/21.
//

import SwiftUI

@main
struct HypedListApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear {
                    DataController.shared.loadData()
                    DataController.shared.getDiscoverEvents()
                }
        }
    }
}
