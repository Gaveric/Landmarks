//
//  SwiftUIView.swift
//  Расписание богослужений
//
//  Created by User on 17.09.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct Menu: View {
    
    @EnvironmentObject private var userData: UserData
    
    // @Binding var showMenu: Bool
    // @Binding var index: Int
    
    
    var body: some View {
        
        HStack {
            Spacer()
            VStack (alignment: .trailing) {
                
                Button(action: {
                    self.userData.index = 1
                    withAnimation{
                        self.userData.showMenu.toggle()
                    }
                }) {
                    HStack(spacing: 25){
                        HStack {
                            Image(systemName: "message").imageScale(.large)
                            Text("Молитвы").font(.headline)
                        }
                        .padding(.top, 100)
                    }
                    .padding(.top,15)
                    
//                    .font(.system(size: 20))
//                    .frame(width: 30, height: 30)
//
//
//                           .animation(nil)
//                           .background(Color.red)
//                           .animation((Animation.linear).delay(0.1))
//                           .cornerRadius(30)
////                           .onTapGesture {
////
////
////                           }
                    
                    
                    
                    
                }

                Button(action: {
                    self.userData.index = 0
                    withAnimation{
                        self.userData.showMenu.toggle()
                    }
                }) {
                    HStack(spacing: 25){
                        HStack {
                            Image(systemName: "book").imageScale(.large)
                            Text("Расписания храмов").font(.headline)
                        }.padding(.top, 15)
                    }.padding(.top,15)
                }
                
                
                
                
                
                
                
                
                
                
                 
//                HStack {
//                    Image(systemName: "calendar")
//                        .imageScale(.large)
//                    Text("Календарь праздников")
//                        .font(.headline)
//                }
//                .padding(.top, 30)
//
//
//                HStack {
//                    Image(systemName: "gear")
//                        .imageScale(.large)
//                    Text("Выбор темы")
//
//                        .font(.headline)
//                }
//                .padding(.top, 30)
//
//
                VStack {
                    Text("Обратная связь:").font(.headline)
                    HStack {
                        Image(systemName: "envelope")
                            .imageScale(.large)
                        Text("averic@mail.ru")
                    }
                }
                .padding(.top, 30)
                Spacer()
                
            }
            .padding()
            .frame(maxWidth: UIScreen.main.bounds.width / 2, alignment: .trailing)
            .edgesIgnoringSafeArea(.all)
                
            .foregroundColor(Color.offBlack)
            
        }
        .colorMultiply(Color.offYellow)

    }
}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        // @Binding var showMenu = true
        // Menu(showMenu: true)
        Text ("")
    }
}
