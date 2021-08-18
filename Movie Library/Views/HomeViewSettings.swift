//
//  HomeViewSettings.swift
//  Movie Library
//
//  Created by Leandro Gamarra on 8/16/21.
//

import SwiftUI

struct HomeViewSettings: View {
    
    @Binding var isPresented: Bool
    @State private var selection = 1
    @State private var email = ""
    
    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $selection, label: Text("Favorite Genre")) {
                    Text("Action")
                        .tag(1)
                    Text("Comedy")
                        .tag(2)
                    Text("Horrow")
                        .tag(3)
                    Text("SciFi")
                        .tag(4)
                }
                
                Section(header: Text("email")) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button(action: {
                    isPresented.toggle()
                }) {
                    Text("Save")
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct HomeViewSettings_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewSettings(isPresented: Binding<Bool>.constant(false))
    }
}
