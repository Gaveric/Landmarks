//
//  ButtonRefresh.swift
//  Landmarks
//
//  Created by User on 21.07.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct ButtonMenu: View {
        @EnvironmentObject private var userData: UserData
    
    
    var body: some View {
        Button ("Обновить список", action: {
            self.userData.takeUrl()
            
            self.userData.makeCategories(landmarks: self.userData.landmarks)
        })
            .foregroundColor(Color.black.opacity(0.7))
      
             
    }
}

struct ButtonRefresh_Previews: PreviewProvider {
    static var previews: some View {
        ButtonMenu()
    }
}
