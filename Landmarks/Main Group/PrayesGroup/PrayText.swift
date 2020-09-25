//
//  PrayesDitail.swift
//  Расписание богослужений
//
//  Created by User on 23.09.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI


struct PrayText: View {
    @EnvironmentObject private var userData: UserData
    var pray : Pray
    @State private var fontSize: CGFloat = 14
    
    var body: some View {
        VStack {
            Stepper("", value: $fontSize)
                .padding(.vertical)
            ScrollView {
                VStack {
                    Text(pray.id).bold()
                    Text(pray.text).padding(.top, 30)
                }
                .font(Font.custom("HelveticaNeue", size: fontSize))
                .foregroundColor(Color.offBlack)
                .background(Color.offYellow)
            }
        }.padding(.top, -30)
    }
}

struct PrayesDitail_Previews: PreviewProvider {
    static var previews: some View {
        // @EnvironmentObject private var userData: UserData
        
        //PrayText(pray[1])
        Text("Молитвы ко Причастию")
    }
}
