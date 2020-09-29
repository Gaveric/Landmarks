//
//  Blago-FavoritView.swift
//  Расписание богослужений
//
//  Created by User on 04.09.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI



struct BlagoFavoritView: View {
    @EnvironmentObject private var userData: UserData
    @Environment(\.managedObjectContext) var managedObjectContext
    //@State var expand = false
    
    
    var body: some View {

        
        Form {
            if !userData.showFavoritesOnly {
                
               // VStack (alignment: .leading, spacing: 10) {
                    ForEach (self.userData.categories.keys.sorted(), id: \.self) { key in
                        Section(
                            header:
                            HStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.offBlue)
                                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 0.41))
                                    .frame(  height: 50)
                                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                                    .overlay(
                                        HStack {
                                            Text(key)
                                                .frame(height: 50)
                                                .font(.subheadline)
                                            Image(systemName:  self.userData.expander[key]! ? "chevron.up" : "chevron.down")
                                        } // Здесь живут и множатся благочиния
                                ) // конец оверлея

                            }.onTapGesture {
                                self.userData.expander[key]!.toggle()
                            } )
                        { if self.userData.expander[key]! {
                            FooterView(items: self.userData.categories[key]!, key: key)
                            }
                        }
                    //}
                } //foreach
            }
            else
            {
                
                 ForEach (self.userData.categories.keys.sorted(), id: \.self) { key in
                    FooterView(items: self.userData.categories[key]!, key: key)
                }
//                ForEach (self.userData.landmarks.sorted(), id: \.self) {landmark in
//                    FooterView(items: self.userData.landmarks[landmark]!, landmark: landmark)
//                }
                
                
            } // else
            
        }
            .foregroundColor(.offBlack) // form

        
}//body
}
struct BlagoFavoritView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            BlagoFavoritView()
        }
        .environmentObject(UserData())

        
        
    }
}



//            Form {
//                                        if !userData.showFavoritesOnly {
//
//                                        ForEach (self.userData.categories.keys.sorted(), id: \.self) { key in
//                                            Section(
//                                                header:
//                                                HStack {
//                                                    RoundedRectangle(cornerRadius: 15)
//                                                        .fill(Color.white)
//                                                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 0.3))
//                                                        .frame(  height: 50)
//                                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
//                                                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
//                                                        .overlay(
//                                                            HStack {
//                                                                Text(key+" благочиние")
//                                                                    .frame(height: 50)
//                                                                    .font(.headline)
//                                                                Image(systemName:  self.userData.expander[key]! ? "chevron.up" : "chevron.down")
//                                                            }
//                                                    ) // конец оверлея
//
//                                                }.onTapGesture {
//                                                    self.userData.expander[key]!.toggle()
//                                                } )
//                                            { if self.userData.expander[key]! {
//                                                FooterView(items: self.userData.categories[key]!, key: key)
//                                                }
//                                            }
//                                        }
//                                        } else {
//
//                                            ForEach (self.userData.landmarks.sorted(), id: \.self) {landmark in
//                                                    FooterView(items: self.userData.landmarks[landmark]!, landmark: landmark)
//                                                    }
//                                        }
//                                }    }
