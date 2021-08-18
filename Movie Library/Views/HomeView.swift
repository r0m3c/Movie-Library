//
//  HomeView.swift
//  Movie Library
//
//  Created by Leandro Gamarra on 8/16/21.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showSettings = false
    
    var body: some View {
        NavigationView {
            Group {
                MoviesView()
            }
            .navigationBarTitle("Movies", displayMode: .automatic)
            .navigationBarItems(trailing: HStack {
                settingsButton
            })
            .sheet(isPresented: $showSettings, content: {
                HomeViewSettings(isPresented: $showSettings)
            })
        }
    }
    
    private var settingsButton: some View {
        Button(action: {
            showSettings.toggle()
        }, label: {
            HStack {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .foregroundColor(.gray)
            }
            .frame(width: 30, height: 30)
        })
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
