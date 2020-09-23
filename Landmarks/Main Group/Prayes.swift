//
//  Prayes.swift
//  Расписание богослужений
//
//  Created by User on 22.09.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct Prayes: View {
    @EnvironmentObject private var userData: UserData
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // @State var expand = false
    @Binding var showMenu: Bool
    
    var body: some View {
        
        
        VStack {
            Spacer()
            
            // Mark: - НавигейшнВью
            
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
                            
                            
                            
                            VStack (alignment: .leading){
                                HStack {
                                    Text("Молитвы")//.font(.system(.headline, design: .rounded))
                                        .font(.largeTitle)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    
                                    
                                    Button(action: {
                                        withAnimation{
                                            self.showMenu.toggle()
                                        }
                                    }) {
                                        // close Button...
                                        
                                        Image(systemName: self.showMenu ? "line.horizontal.3" : "line.horizontal.3") //"xmark" : "line.horizontal.3")
                                            .resizable()
                                            .frame(width: self.showMenu ? 18 : 22, height: 18)
                                            .foregroundColor(Color.black.opacity(0.4))
                                    }
                                    
                                }
                                
                            }.padding(.leading)
                        }.padding(.trailing, 18.0).frame( height:80)
                        
                        
                        
                        
                        
                        // MARK: - Молитвы
                        
                        
                        
                    }.navigationBarTitle("назад")
                        .navigationBarHidden(true)
                    
                    Spacer()
                }//.edgesIgnoringSafeArea(.all)
                
            }.padding(.top, -2.0)
            
            
        }
    }
}

struct Prayes_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            ContentView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
        .environmentObject(UserData())
    }
}
