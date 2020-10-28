//
//  Prayes.swift
//  Расписание богослужений
//
//  Created by User on 22.09.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct ThePrayes: View {
    
    @EnvironmentObject private var userData: UserData
    @Environment(\.managedObjectContext) var managedObjectContext
    //var prayes =  [Pray]
    
    
    
    var body: some View {
        
        ZStack {
           

                        // MARK: - НавигейшнВью
            NavigationView {
                VStack {
                    VStack {
                        
                        // MARK: - Шапка фото
                        HStack (alignment: .center){
                            
                            ImageStore.shared.image(name: "DefaultPhoto")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 80, height: 80)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                            
                            VStack (){
                                HStack {
                                    Text("Молитвы")//.font(.system(.headline, design: .rounded))
                                        .font(.largeTitle)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    
                                    // MARK: - Кнопка
                                    ButtonMenu()
                                }
                                
                            }.padding(.leading)
                        }
                            .padding([.top, .leading, .trailing])//.padding(.trailing, 18.0)
                            //.frame( height:80)
                        
                        // MARK: - Молитвы
                        
                        List  {
                            
                            ForEach (userData.prayes) { pray in
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.offYellow)
                                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 0.41))
                                    .frame(  height: 60)
                                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                                    .overlay(
                                        VStack{
                                        NavigationLink(destination: PrayText(pray: pray)) {
                                            Text(pray.id)
                                                    
                                        }
                                        }
                                        .padding(.horizontal)
                                        .frame(height: 13.0)
                                )
                            }
                        }.listStyle(PlainListStyle())
                                 
                        
                    }.navigationBarTitle("назад")
                        .navigationBarHidden(true)
                    
                    Spacer()
                }
            }.padding(.top)
            
            
        }    }
}

struct Prayes_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            ThePrayes()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
        .environmentObject(UserData())
    }
}
