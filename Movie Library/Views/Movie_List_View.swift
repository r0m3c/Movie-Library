//
//  Movie_List_View.swift
//  Movie Library
//
//  Created by Leandro Gamarra on 8/11/21.
//

import SwiftUI

struct Movie_List_View: View {
    @State var movieAdd: [MovieAdd] = []
    
    @State private var newMovieName: String = ""
    @State private var newMovieYear: String = ""
    @State private var newMovieDirector: String = ""
    @State private var newMovieLanguage: String = ""
    @State private var newDateAdded: String = ""
    @State private var newMovieRating: String = ""
    @State private var newHomeOrTheatre: String = ""
    @State private var showNewMovie = false
    
    @EnvironmentObject var settingStore: SettingStore
    @State private var showSettings: Bool = false
    
    @State var searchText = ""
    @State var isSearching = false
    
    @State private var newMovieImage = UIImage()
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    
                    Button(action: {
                        self.showSettings = true
                    }, label: {
                        Image(systemName: "gear")
                            .font(.title)
                            .foregroundColor(.yellow)
                    })
                    .fullScreenCover(isPresented: $showSettings) {
                        SettingView().environmentObject(self.settingStore)
                    }
                    
                    Spacer()
                    
                    Text("Movies Watched Ratings")
                        .font(.system(size: 30, weight: .black, design: .rounded
                        ))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button(action: {
                        self.showNewMovie = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.yellow)
                    }
                    
                }
                .padding()
                
                List{
                    
                    SearchBar(searchText: $searchText, isSearching: $isSearching)
                    
                    ForEach(movieAdd.sorted(by: self.settingStore.displayOrder.predicate()).filter({"\($0)".contains(searchText) || searchText.isEmpty})){movie in
                        if self.shouldShowItem(movie: movie) {
                            
                            movieRow(movieAdd: movie)
                        }
                        }
                    
                }

                
                Spacer()
            }
            .rotation3DEffect(Angle(degrees: showNewMovie ? 5 : 0), axis: (x: 1, y: 0, z: 0))
            .offset(y: showNewMovie ? -50 : 0)
            .animation(.easeOut)
            
            if movieAdd.count == 0 {
                NoDataView()
            }
            
            if showNewMovie {
                BlankView(bGColor: .black)
                    .opacity(0.5)
                    .onTapGesture {
                        self.showNewMovie = false
                    }
                
                NewMovieView(isShow: $showNewMovie, addMovie: $movieAdd, newMovieName: newMovieName)
                    .transition(.move(edge: .bottom))
                    .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0))
            }
        }
    }
    
//    private func setFavorite(item movie: MovieAdd) {
//        if let index = self.movie.movieAdd.firstIndex(where: {$0.id == movie.id}) {
//            self.movies.movies[index].isFavorite.toggle()
//        }
//    }
//
//    private func delete(item movie: MovieAdd) {
//        if let index = self.movies.movies.firstIndex(where: {$0.id == movie.id}) {
//            self.movies.movies.remove(at: index)
//        }
//    }
    
    private func shouldShowItem(movie: MovieAdd) -> Bool {
        return (!self.settingStore.showFavoriteOnly || movie.isFavorite)
    }
}
   

struct movieRow: View {
    
    @ObservedObject var movieAdd : MovieAdd
    
    var body: some View {
        HStack {
            Image(uiImage: movieAdd.movieImage)
                .resizable()
                .frame(width: 160, height: 230)
                .cornerRadius(5)
            VStack (alignment: .leading, spacing: 5){
                Text(movieAdd.movieName.uppercased())
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                
                Divider()
                
                Text("Year Released: ")
                    .font(.headline)
                    .foregroundColor(.black)
                    +
                    Text(movieAdd.movieYear)
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Date Added: ")
                    .font(.headline)
                    .foregroundColor(.black)
                    +
                    Text(movieAdd.dateAdded)
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Movie/Theatre: ")
                    .font(.headline)
                    .foregroundColor(.black)
                    +
                    Text(movieAdd.homeOrTheatre)
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Director: ")
                    .font(.headline)
                    .foregroundColor(.black)
                    +
                    Text(movieAdd.movieDirector)
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Language: ")
                    .font(.headline)
                    .foregroundColor(.black)
                    +
                    Text(movieAdd.movieLanguage)
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Rating: ")
                    .font(.headline)
                    .foregroundColor(.black)
                    +
                    Text(movieAdd.movieRating)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct SearchBar: View {

    @Binding var searchText: String
    @Binding var isSearching: Bool

    var body: some View {
        HStack {
            HStack {
                TextField("Search films here", text: $searchText)
                    .padding(.horizontal, 23)
            }
            .padding()
            .background(Color(.systemGray4))
            .cornerRadius(6)
            .padding(.horizontal, -6)
            .onTapGesture {
                isSearching = true
            }
            .padding(.horizontal, 4)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()

                    if isSearching {
                        Button(action : {
                            searchText = ""
                        }, label:{
                            Image(systemName: "xmark.circle.fill")
                        })

                    }

                }
                .padding(.horizontal, 7.0)
                .foregroundColor(.gray)
            )
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""

                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                }, label : {
                    Text("Cancel")
                        .foregroundColor(.blue)
                })
            }
        }

    }
}

    

struct Movie_List_View_Previews: PreviewProvider {
    static var previews: some View {
        Movie_List_View()
        
    }
}
