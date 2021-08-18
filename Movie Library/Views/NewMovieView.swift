//
//  NewMovieView.swift
//  Movie Library
//
//  Created by Leandro Gamarra on 8/11/21.
//

import SwiftUI

import SwiftUI

struct NewMovieView: View {
    
    @Binding var isShow: Bool
    @Binding var addMovie: [MovieAdd]
    
    @State var newMovieName: String = ""
    @State var newMovieYear: String = ""
    @State var newMovieDirector: String = ""
    @State var newMovieLanguage: String = ""
    @State var newDateAdded: String = ""
    @State var newMovieRating: String = ""
    @State var newHomeOrTheatre:String = ""
    
    @State var isEditing = false
    
    @State var isShowingImagePicker = false
    @State var imageInBlackBox = UIImage()
    
    var body: some View {
        ScrollView {
        VStack {
            Spacer()
            
            VStack (alignment: .leading) {
                HStack {
                    Text("Add a New Movie")
                        .font(.system(.title, design: .rounded))
                        .bold()
                    Spacer()
                    
                    Button(action: {
                        self.isShow = false
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.headline)
                    })
                }
                ZStack {
                    VStack {
                    HStack (alignment: .center){
                        
                        Spacer()
                        Image(uiImage: imageInBlackBox)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .border(Color.black, width: 3)
                            .clipped()
                        Spacer()
                    }
                    
                    VStack {
                        Spacer()
                        Button(action: {
                            self.isShowingImagePicker.toggle()
                        }, label: {
                            Text("Select Image")
                                .font(.system(size: 15))
                        })
                        .sheet(isPresented: $isShowingImagePicker, content: { ImagePickerView(isPresented: $isShowingImagePicker, selectedImage: $imageInBlackBox)})
                    }
                    }
                }
                
                Group {
                TextField("Enter the movie name", text: $newMovieName, onEditingChanged: { (editingChanged) in
                    self.isEditing = editingChanged
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.bottom)
                
                TextField("Enter year movie came out", text: $newMovieYear, onEditingChanged: { (editingChanged) in
                    self.isEditing = editingChanged
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.bottom)
                
                TextField("Enter director's name", text: $newMovieDirector, onEditingChanged: { (editingChanged) in
                    self.isEditing = editingChanged
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.bottom)
                
                
                TextField("Enter language of movie", text: $newMovieLanguage, onEditingChanged: { (editingChanged) in
                    self.isEditing = editingChanged
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.bottom)
                
                
                TextField("Enter date of movie addition", text: $newDateAdded, onEditingChanged: { (editingChanged) in
                    self.isEditing = editingChanged
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.bottom)
                
                TextField("Enter movie rating out of 10", text: $newMovieRating, onEditingChanged: { (editingChanged) in
                    self.isEditing = editingChanged
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.bottom)
                
                TextField("Enter where movie watched, home/theatre", text: $newHomeOrTheatre, onEditingChanged: { (editingChanged) in
                    self.isEditing = editingChanged
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.bottom)
                }
                
                Button(action: {
                    if self.newMovieName.trimmingCharacters(in: .whitespaces) == "" {
                        return
                    }
                    
                    if self.newMovieYear.trimmingCharacters(in: .whitespaces) == "" {
                        return
                    }
                    
                    if self.newMovieDirector.trimmingCharacters(in: .whitespaces) == "" {
                        return
                    }
                    
                    if self.newMovieLanguage.trimmingCharacters(in: .whitespaces) == "" {
                        return
                    }
                    
                    if self.newDateAdded.trimmingCharacters(in: .whitespaces) == "" {
                        return
                    }
                    
                    if self.newMovieRating.trimmingCharacters(in: .whitespaces) == "" {
                        return
                    }
                    
                    if self.newHomeOrTheatre.trimmingCharacters(in: .whitespaces) == "" {
                        return
                    }
                    
                    if self.isShowingImagePicker {
                        return
                    }
                    
                    self.isShow = false
                    self.addMovieTask(movieName: self.newMovieName, movieYear: self.newMovieYear, movieDirector: self.newMovieDirector, movieLanguage: self.newMovieLanguage, dateAdded: self.newDateAdded, movieRating: self.newMovieRating, homeOrTheatre: self.newHomeOrTheatre, movieImage: ImagePickerView(isPresented: $isShowingImagePicker, selectedImage: $imageInBlackBox))
                }) {
                    Text("Save")
                        .font(.system(.headline, design: .rounded))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(10)
                }
                .padding(.bottom)
            }
        }
            .padding()
            .background(Color.white)
            .cornerRadius(10, antialiased: true)
            .offset(y: isEditing ? -320 : 0)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func addMovieTask(movieName: String, movieYear: String, movieDirector: String, movieLanguage: String, dateAdded: String, movieRating: String, homeOrTheatre: String, isComplete: Bool = false, movieImage: ImagePickerView) {
        
        let task = MovieAdd(movieName: movieName, movieYear: movieYear, movieDirector: movieDirector, movieLanguage: movieLanguage, dateAdded: dateAdded, movieRating: movieRating, homeOrTheatre: homeOrTheatre, movieImage: movieImage.selectedImage)
        addMovie.append(task)
    }
}

struct NewMovieView_Previews: PreviewProvider {
    static var previews: some View {
        NewMovieView(isShow: .constant(true), addMovie: .constant([]), newMovieName: "", newMovieYear: "", newMovieDirector: "", newMovieLanguage: "", newDateAdded: "", newMovieRating: "", newHomeOrTheatre: "", isShowingImagePicker: true)
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> some UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func makeCoordinator() -> ImagePickerView.Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: ImagePickerView
        init(parent: ImagePickerView){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                print(selectedImage)
                self.parent.selectedImage = selectedImage
            }
            self.parent.isPresented = false
        }
    }
    
    func updateUIViewController(_ uiViewController: ImagePickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        //
    }
}
