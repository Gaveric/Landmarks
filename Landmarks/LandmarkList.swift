
import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject private var userData: UserData
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: userData.landmarks, //landmarkData,
            by: { $0.category.rawValue }
        )
    }

    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    Toggle(isOn: $userData.showFavoritesOnly) {
                        Text("Show Favorites Only")
                    }
                
                     ForEach (categories.keys.sorted(), id: \.self) { key in
                                       CategoryRow(categoryName: key, items: self.categories[key]!)
                        }
                    
                    
//                    ForEach(userData.landmarks) { landmark in
//                        if !self.userData.showFavoritesOnly || landmark.isFavorite {
//                            NavigationLink(
//                                destination: LandmarkDetail(landmark: landmark)
//                                    .environmentObject(self.userData)
//                            ) {
//                                LandmarkRow(landmark: landmark)
//                            }
//                        }
//                   }
                  
                        
                        
                        
                        .navigationBarTitle(Text("Храмы Екатеринбургской епархии"))
                
                Button ("Обновить список храмов", action: {
                    self.userData.takeUrl()
                    print ("                                             ПРИНТ ПО КНОПКЕ")
                    })
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
            LandmarkList()//categoryName: "Березовское", items: Array(landmarkData.prefix(4)))
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
        .environmentObject(UserData())
    }
}
