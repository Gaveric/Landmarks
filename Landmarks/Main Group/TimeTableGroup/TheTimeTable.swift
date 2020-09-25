//
//  TheMain.swift
//  Расписание богослужений
//
//  Created by User on 17.09.2020.


import SwiftUI

struct TheTimeTable: View {
    
    @EnvironmentObject private var userData: UserData
    @Environment(\.managedObjectContext) var managedObjectContext
    //           init(){
    //            UITableView.appearance().backgroundColor =  UIColor(red: 240/255, green:240/255, blue: 249/255, alpha: 0.5)
    //            }
    
    var body: some View {
        
        VStack {
            Spacer()
            
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
                            VStack (alignment: .leading){
                                HStack {
                                    Text("Храмы")//.font(.system(.headline, design: .rounded))
                                        .font(.largeTitle)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    ButtonMenu()
                                    
                                }
                                Text("Екатеринбургской епархии")
                                    .font(.headline)
                            }.padding(.leading)
                        }.padding(.trailing, 18.0).frame( height:80)
                            .foregroundColor(Color.offBlack)
                        
                        // MARK: - Кнопки
                        
                        HStack {
                            HStack { // Кнопка 1
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.offYellow) // ____________ цвет 1 кнопки
                                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 0.41))                                    .frame(width: 100, height: 50)
                                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                                    .overlay(
                                        Button ("Обновить список", action: {
                                            self.userData.takeUrl()
                                            print ("ПРИНТ ПО КНОПКЕ")
                                            self.userData.makeCategories(landmarks: self.userData.landmarks)
                                            })                                            .foregroundColor(Color.black.opacity(0.7))
                                )
                            }.frame(width: 130.0, height: /*@START_MENU_TOKEN@*/60.0/*@END_MENU_TOKEN@*/)//, alignment: .center)
                            
                            Spacer()
                            // Кнопка 2
                            HStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.offYellow)// ____________ цвет 2 кнопки
                                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 0.41)) // линия вокруг кнопки
                                    .frame(width: 190, height: 50)
                                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                                    .overlay(
                                        HStack {
                                            Toggle(isOn: $userData.showFavoritesOnly) {
                                                
                                                Text("Только избранные").foregroundColor(Color.black.opacity(0.7))
                                            }
                                        }.frame(width: 160.0, height: 60.0)
                                )
                            }
                        } .padding(.trailing, 19.0)
                            
                            .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                            .multilineTextAlignment(.center)
                        
                        // MARK: - Благочиния
                        BlagoFavoritView()
                        
                    }.navigationBarTitle("список храмов")
                        .navigationBarHidden(true)
                    
                    Spacer()
                }//.edgesIgnoringSafeArea(.all)
                
            }.padding(.top, -2.0)
            
            
        }
    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
    
}

struct TheMain_Previews: PreviewProvider {
    static var previews: some View {
        Text ("")
    }
}
