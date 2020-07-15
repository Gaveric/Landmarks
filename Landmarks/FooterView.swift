//
//  FooterView.swift
//  Landmarks
//
//  Created by User on 15.07.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI



struct FooterView: View {
    
    @EnvironmentObject private var userData: UserData
    //@Environment(\.managedObjectContext) var managedObjectContext
    //@State var expand = false
    var items: [Landmark]
    var key: String
    
    
    var body: some View {
        // List {
        
            ForEach(self.items) { landmark in
               List  {
                   HStack {
                    if !self.userData.showFavoritesOnly || landmark.isFavorite {
                        NavigationLink(
                            destination: LandmarkDetail(landmark: landmark)
                        ) {
                            
                            //VStack {
                                LandmarkRow(landmark: landmark)
                            //}
                        }//.scaledToFill()  // Если это не использовать, то ячейки вообще не отображаются
                    }
                }
            }.frame(height: 53)                
         }
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        Text(" ")
    }
}
