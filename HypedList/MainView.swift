//
//  MainView.swift
//  HypedList-iOS
//
//  Created by Xiaoheng Pan on 3/15/21.
//

import SwiftUI

struct MainView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .compact {
            HypedListTabView()
        } else {
            HypedListSidebarView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
