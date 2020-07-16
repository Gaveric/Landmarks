import SwiftUI
struct LandmarkList: View {
    @EnvironmentObject private var userData: UserData
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var expand = false
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Toggle(isOn: $userData.showFavoritesOnly) {
                        Text("Только избранные")
                    }
                    ForEach (self.userData.categories.keys.sorted(), id: \.self) { key in
                        Section(
                            header:
                            HStack {
                                Text(key+" благочиние")
                                    .font(.headline)
                                    .padding(.leading, 15)
                                    .padding(.top, 5)
                                Image(systemName:  self.userData.expander[key]! ? "chevron.up" : "chevron.down")
                            }.onTapGesture {
                                self.userData.expander[key]!.toggle()
                            },
                            footer:
                            Text("") )
                        {
                            if self.userData.expander[key]! {
                                FooterView(items: self.userData.categories[key]!, key: key)
                            }
                        }
                    }.navigationBarTitle(Text("Храмы Екатеринбургской епархии"))
                    
                    
                }
                Button ("Обновить список храмов", action: {
                    self.userData.takeUrl()
                    
                    print ("                                             ПРИНТ ПО КНОПКЕ")
                    dump(self.userData.categories.keys.sorted())
                    self.userData.makeCategories(landmarks: self.userData.landmarks)
                })
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
