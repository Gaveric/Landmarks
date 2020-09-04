import SwiftUI
struct LandmarkList: View {
    @EnvironmentObject private var userData: UserData
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var expand = false
    init(){
        UITableView.appearance().backgroundColor = UIColor(red: 204/255, green:255/255, blue: 255/255, alpha: 0.5)
    }
    var body: some View {
        
        VStack {
        Spacer()
            
            // Mark: - НавигейшнВью
            
            NavigationView {
                VStack {
                    VStack {
                        
            // MARK: - Шапка фото
            HStack (alignment: .center){
                VStack (alignment: .leading){
                    Text("Храмы")//.font(.system(.headline, design: .rounded))
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Text("Екатеринбургской епархии")
                        .font(.headline)
                }.padding(.leading)
                Spacer()
                ImageStore.shared.image(name: "DefaultPhoto")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 80, height: 80)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                //.shadow(radius: 10)
            }.frame( height:80)
            // .padding(.top, 50)
            // .position(x: 0, y: 00)
            
                        // MARK: - Кнопки
                        
                        HStack {
                            HStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 0.3))                                    .frame(width: 100, height: 50)
                                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                                    .overlay(
                                        Button ("Обновить список", action: {
                                            self.userData.takeUrl()
                                            print ("ПРИНТ ПО КНОПКЕ")
                                            self.userData.makeCategories(landmarks: self.userData.landmarks)
                                        })
                                            .foregroundColor(Color.black.opacity(0.7))
                                        
                                        
                                        
                                )
                            }.frame(width: 130.0, height: /*@START_MENU_TOKEN@*/60.0/*@END_MENU_TOKEN@*/, alignment: .center)
                            Spacer()
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 0.3)) // линия вокруг кнопки
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
                            
                        }.font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                            .multilineTextAlignment(.center)
                        
                        
                        
                        // MARK: - Благочиния
                        
                        Form {
                            ForEach (self.userData.categories.keys.sorted(), id: \.self) { key in
                                Section(
                                    header:
                                    HStack {
                                        
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color.white)
                                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 0.3))
                                            .frame(  height: 50)
                                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                                            .overlay(
                                                HStack {
                                                    Text(key+" благочиние")
                                                        .frame(height: 50)
                                                        .font(.headline)
                                                    //                                                .padding(.leading, 15)
                                                    //                                                .padding(.top, 5)
                                                    Image(systemName:  self.userData.expander[key]! ? "chevron.up" : "chevron.down")
                                                }
                                        ) // конец оверлея
                                        
                                    }.onTapGesture {
                                        self.userData.expander[key]!.toggle()
                                    } )
                                { if self.userData.expander[key]! {
                                    FooterView(items: self.userData.categories[key]!, key: key)
                                    }
                                }
                            }
                        }
                    }.navigationBarTitle("список храмов")
                        .navigationBarHidden(true)
                   // .navigationBarHidden(fullScreen)
                    Spacer()
                    
                }.edgesIgnoringSafeArea(.all)
                
            }.padding(.top, -2.0).colorMultiply(Color.offWhite)
       
            
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

struct LandmarksList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
        .environmentObject(UserData())
    }
}
