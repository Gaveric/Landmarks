//
//  ButtonRefresh.swift
//  Landmarks
//
//  Created by User on 21.07.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct ButtonRefresh: View {
        @EnvironmentObject private var userData: UserData
    var body: some View {
        Button ("Обновить список", action: {
            self.userData.takeUrl()
            print ("                                             ПРИНТ ПО КНОПКЕ")
            dump(self.userData.categories.keys.sorted())
            self.userData.makeCategories(landmarks: self.userData.landmarks)
        })
            //.font(.caption)
            //.foregroundColor(.gray)
            
            //.overlay(RoundedRectangle(cornerRadius: 10)
            //   .stroke(Color.gray, lineWidth: 1))
        
    }
}

struct ButtonRefresh_Previews: PreviewProvider {
    static var previews: some View {
        ButtonRefresh()
    }
}
