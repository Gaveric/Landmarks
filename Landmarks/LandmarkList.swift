import SwiftUI
struct LandmarkList: View {
    @EnvironmentObject private var userData: UserData
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var expand = false
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    HStack {
                        Text("Екатеринбургской епархии")
                            .padding(.leading, 15)
                            .font(.title)
                        Spacer()
                        ImageStore.shared.image(name: "DefaultPhoto")
                            .resizable()
                            .scaledToFit()
                    }
                    .frame( height:70)
                    
                    
                    
                    List {
                        HStack {
                            HStack {
                                ButtonRefresh()
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 0))
                                Spacer()
                            }.frame(width: 130.0, height: /*@START_MENU_TOKEN@*/60.0/*@END_MENU_TOKEN@*/)

                            

                            Spacer()
                            HStack {
                                Toggle(isOn: $userData.showFavoritesOnly) {
                                    Text("Только избранные")
                                }
                                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 0))
                            }.frame(width: 160.0, height: /*@START_MENU_TOKEN@*/60.0/*@END_MENU_TOKEN@*/)

                            
                        }.font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/).foregroundColor(.gray)
                        
                        
                        ForEach (self.userData.categories.keys.sorted(), id: \.self) { key in
                            Section(
                                header:
                                HStack {
                                    Text(key+" благочиние")
                                        .frame(height: 50)

                                        .font(.headline)
                                        .padding(.leading, 15)
                                        .padding(.top, 5)
                                        .foregroundColor(Color(red: 0.1, green: 0.3, blue: 0.3, opacity: 1.0))
                                        

                                    Image(systemName:  self.userData.expander[key]! ? "chevron.up" : "chevron.down")
                                }.onTapGesture {
                                    self.userData.expander[key]!.toggle()
                                } )
                            {
                                if self.userData.expander[key]! {
                                    FooterView(items: self.userData.categories[key]!, key: key)
                                }
                            }
                           
                            
                        }
                    }.navigationBarTitle(  Text("Храмы") )
                    //.listStyle(GroupedListStyle())
                    // .listRowBackground(Color.green)


                }.background(Color.green.opacity(0.1))
//                .offset(x:0, y: -50)
//                .padding(.bottom, -50)
            }//.background(Color.green.opacity(0.1))
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
