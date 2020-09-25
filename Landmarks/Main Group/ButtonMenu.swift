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

        Button(action: {
            withAnimation{
                self.userData.showMenu.toggle()
            }
        }) {
            
            Image(systemName: self.userData.showMenu ? "line.horizontal.3" : "line.horizontal.3") //"xmark" : "line.horizontal.3")
                .resizable()
                .frame(width: self.userData.showMenu ? 18 : 22, height: 18)
                .foregroundColor(Color.offBlack.opacity(0.4))
        }

        
             
    }
}

struct ButtonRefresh_Previews: PreviewProvider {
    static var previews: some View {
        ButtonMenu()
    }
}
