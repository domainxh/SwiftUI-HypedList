//
//  CreateHypedEventView.swift
//  HypedList
//
//  Created by Xiaoheng Pan on 3/12/21.
//

import SwiftUI

struct CreateHypedEventView: View {
    
    @StateObject var hypedEvent = HypedEvent()
    @State var showTime = false
    
    var body: some View {
        Form {
            Section {
                FormLabelView(title: "Title", color: .green, iconSystemName: "keyboard")
                TextField("Family Vacation", text: $hypedEvent.title)
                    .autocapitalization(.words)
            }
            
            Section {
                FormLabelView(title: "Date", color: .blue, iconSystemName: "calendar")
                DatePicker("Date", selection: $hypedEvent.date, displayedComponents: showTime ? [.date, .hourAndMinute] : [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                Toggle(isOn: $showTime) {
                    FormLabelView(title: "Time", color: .blue, iconSystemName: "clock.fill")
                }
            }
            
            Section {
                ColorPicker(selection: $hypedEvent.color) {
                    FormLabelView(title: "Color", color: .yellow, iconSystemName: "eyedropper")
                }
            }
            
            Section {
                FormLabelView(title: "URL", color: .orange, iconSystemName: "link")
                TextField("nintendo.com", text: $hypedEvent.url)
                    .keyboardType(.URL)
                    .autocapitalization(.none)
            }
        }
    }
}

struct CreateHypedEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHypedEventView()
    }
}

struct FormLabelView: View {
    var title: String
    var color: Color
    var iconSystemName: String
    
    var body: some View {
        Label {
            Text(title)
        } icon: {
            Image(systemName: iconSystemName)
                .padding(4)
                .background(color)
                .cornerRadius(5)
                .foregroundColor(.white)
        }
    }
}
