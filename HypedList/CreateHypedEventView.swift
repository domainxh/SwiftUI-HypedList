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
    @State var showImagePicker = false
    
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
                if let image = hypedEvent.image() {
                    HStack {
                        FormLabelView(title: "Image", color: .purple, iconSystemName: "camera")
                        
                        Spacer()
                        
                        Button(action: {
                            hypedEvent.imageData = nil
                        }, label: {
                            Text("Remove Image")
                                .foregroundColor(.red)
                        })
                    }
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    HStack {
                        FormLabelView(title: "Image", color: .purple, iconSystemName: "camera")
                        
                        Spacer()
                        
                        Button(action: {
                            showImagePicker = true
                        }, label: {
                            Text("Pick Image")
                        }).sheet(isPresented: $showImagePicker) {
                            ImagePicker(imageData: $hypedEvent.imageData)
                        }
                    }
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
