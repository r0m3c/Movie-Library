//
//  BlankView.swift
//  Movie Library
//
//  Created by Leandro Gamarra on 8/11/21.
//

import SwiftUI

struct BlankView: View {
    
    var bGColor: Color
    
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(bGColor)
        .edgesIgnoringSafeArea(.all)    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(bGColor: .black)
    }
}
