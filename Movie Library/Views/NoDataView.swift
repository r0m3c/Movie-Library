//
//  NoDataView.swift
//  Movie Library
//
//  Created by Leandro Gamarra on 8/11/21.
//

import SwiftUI

struct NoDataView: View {
    var body: some View {
        Image(systemName: "film")
            .resizable()
            .scaledToFit()
            .frame(width: 400, height: 400)
    }
}

struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataView()
    }
}
