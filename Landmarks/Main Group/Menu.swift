//
//  SwiftUIView.swift
//  Расписание богослужений
//
//  Created by User on 17.09.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        
        
        VStack (alignment: .leading) {
            HStack {
                Image(systemName: "person")
                    .imageScale(.large)
                Text("Profile")
                    .font(.headline)
            }
                .padding(.top, 100)
            HStack {
                Image(systemName: "envelope")
                    .imageScale(.large)
                Text("Messages")
                    .font(.headline)
            }
                .padding(.top, 30)
            HStack {
                Image(systemName: "gear")
                    .imageScale(.large)
                Text("Settings")
                    
                    .font(.headline)
            }
                .padding(.top, 30)
            Spacer()
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray)
        .edgesIgnoringSafeArea(.all)
        .foregroundColor(Color.offYellow)
        
    }
}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
