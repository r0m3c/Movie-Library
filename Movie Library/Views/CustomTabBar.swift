//
//  CustomTabBar.swift
//  Movie Library
//
//  Created by Leandro Gamarra on 8/11/21.
//

import SwiftUI

struct CustomTabBar: View {
    
    var animation: Namespace.ID
    @Binding var currentTab: Tab
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases,id:\.rawValue) { tab in
                TabButton(tab: tab, animation: animation, currentTab: $currentTab) { pressedTab in
                    
                    withAnimation(.spring()) {
                        currentTab = pressedTab
                    }
                    
                }
            }
        }
        .padding(.horizontal)
        .padding(.top,15)
        .padding(.bottom,10)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SettingStore())
    }
}

struct TabButton: View {
    var tab: Tab
    var animation: Namespace.ID
    @Binding var currentTab: Tab
    
    var onTap: (Tab)->()
    
    var body: some View{
        Image(systemName: tab.rawValue)
            .foregroundColor(currentTab == tab ? .white : .gray)
            .frame(width: 45,height: 45)
            .background(
                ZStack {
                    if currentTab == tab {
                        Circle()
                            .fill(Color(.purple))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            )
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                onTap(tab)
            }
    }
}
