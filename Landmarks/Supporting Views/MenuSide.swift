//
//  MenuSide.swift
//  Расписание богослужений
//
//  Created by User on 16.09.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct MenuSide: View {
    var body: some View {
        
        ZStack {
        
            Text("Господи, благослови.")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.offBlue)
            .padding(.top, 10)
        
        
        }
        .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
        .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
    }
}

struct MenuSide_Previews: PreviewProvider {
    static var previews: some View {
        MenuSide()
    }
}
