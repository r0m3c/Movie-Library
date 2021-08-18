//
//  SettingView.swift
//  Movie Library
//
//  Created by Leandro Gamarra on 8/11/21.
//

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var settingStore: SettingStore
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedOrder = DisplayOrderType.alphabetical
    @State private var showRatings = 10
    @State private var showFavoriteOnly = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("SORT PREFERENCE"), footer: Text("System automatically displays order of films in any way you desire.")) {
                    Picker(selection: $selectedOrder, label: Text("Display Order")) {
                        ForEach(DisplayOrderType.allCases, id: \.self) { orderType in
                            Text(orderType.text)
                        }
                    }
                }
                
                Section(header: Text("FILTER PREFERENCE")) {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Toggle(isOn: $showFavoriteOnly) {
                            Text("Show Favorite's Only")
                        }
                    }
                }
                
                Section {
                    Label("Will be adding more features soon!!", systemImage: "rectangle.and.pencil.and.ellipsis")
                }
                .font(.headline)
                .foregroundColor(.black)
                
            }
            
            .navigationTitle("Settings")
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.black)
                    })
                                    
                    , trailing:
                    Button(action: {
                        self.settingStore.showFavoriteOnly = self.showFavoriteOnly
                        self.settingStore.displayOrder = self.selectedOrder
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                            .foregroundColor(.black)
                    })
                )
        }
        .onAppear {
            self.selectedOrder = self.settingStore.displayOrder
            self.showFavoriteOnly = self.settingStore.showFavoriteOnly
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView().environmentObject(SettingStore())
    }
}
