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
            NavigationView {
                VStack {
                    Form {
                      HStack (alignment: .center){
                        VStack (alignment: .leading){
                            Text("Храмы")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                            Text("Екатеринбургской епархии")
                                .font(.headline)
                        }.padding(.leading)
                        Spacer()
                        ImageStore.shared.image(name: "DefaultPhoto")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 100, height: 100)
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                     }.frame( height:100)
                    
                        HStack {
                            HStack {
                                ButtonRefresh()
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 0))
                            }.frame(width: 130.0, height: /*@START_MENU_TOKEN@*/60.0/*@END_MENU_TOKEN@*/, alignment: .center)
                            Spacer()
                            HStack {
                                Toggle(isOn: $userData.showFavoritesOnly) {
                                    Text("Только избранные")
                                }
                                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 0))
                            }.frame(width: 160.0, height: /*@START_MENU_TOKEN@*/60.0/*@END_MENU_TOKEN@*/)
                        }.font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
 
                        ForEach (self.userData.categories.keys.sorted(), id: \.self) { key in
                            Section(
                                header:
                                HStack {
                                    Text(key+" благочиние")
                                        .frame(height: 50)
                                        .font(.headline)
                                        .padding(.leading, 15)
                                        .padding(.top, 5)
                                        .foregroundColor(Color(red: 0.1, green: 0.4, blue: 0.4, opacity: 1.0))
                                    Image(systemName:  self.userData.expander[key]! ? "chevron.up" : "chevron.down")
                                }.onTapGesture {
                                    self.userData.expander[key]!.toggle()
                                } )
                            { if self.userData.expander[key]! {
                                    FooterView(items: self.userData.categories[key]!, key: key)
                                }
                            }
                        }
                    }.navigationBarTitle("Храмы")
                    .navigationBarHidden(true)
                }
            }
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
