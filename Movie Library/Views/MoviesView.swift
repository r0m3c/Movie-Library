//
//  MoviesView.swift
//  Movie Library
//
//  Created by Leandro Gamarra on 8/16/21.
//

import SwiftUI

struct MoviesView: View {
    
    @State private var searchTerm = ""
    @State private var selectedIndex = 0
    @State private var tabs = ["Now Playing","Upcoming","Trending"]
    
    @ObservedObject var movieManager = MovieDownloadManager()
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().selectionStyle = .none
        
        UINavigationBar.appearance().backgroundColor = .clear
//        line 24 to .white
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().barTintColor = .orange
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        VStack {
            VStack (alignment: .leading) {
                Text(tabs[selectedIndex])
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.red)
                    .padding(.top)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.medium)
                    
                    TextField("Search...", text: $searchTerm)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .padding(.horizontal)
            
//            segment control
            VStack {
                Picker("_", selection: $selectedIndex) {
                    ForEach(0..<tabs.count) { index in
                        Text(tabs[index])
                            .font(.title)
                            .bold()
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedIndex) { _ in
                    if selectedIndex == 0 {
                        movieManager.getNowPlaying()
                    }
                    else if selectedIndex == 1 {
                        movieManager.getUpcoming()
                    }
                    else if selectedIndex == 2 {
                        movieManager.getPopular()
                    }
                }
            }
            .padding()
            
            List {
                ForEach(movieManager.movies.filter{ searchTerm.isEmpty ? true : $0.title?.lowercased().localizedStandardContains(searchTerm.lowercased()) ?? true
                }) { movie in
                    
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieCell(movie: movie)
                    }
                    .listRowBackground(Color.clear)
                    
                }
            }
            .onAppear {
                movieManager.getNowPlaying()
            }
            Spacer()
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
