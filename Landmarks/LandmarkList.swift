
import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject private var userData: UserData

        @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        
        NavigationView {
           
            VStack {
                List {
                    Toggle(isOn: $userData.showFavoritesOnly) {
                        Text("Show Favorites Only")
                    }
                    
                    ForEach(userData.landmarks) { landmark in
                        if !self.userData.showFavoritesOnly || landmark.isFavorite {
                            NavigationLink(
                                destination: LandmarkDetail(landmark: landmark)
                                    .environmentObject(self.userData)
                            ) {
                                LandmarkRow(landmark: landmark)
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("Храмы Березовского благочиния"))
                
                Button ("Обновить список храмов", action: {
                    self.userData.takeUrl()
                    print ("                                             ПРИНТ ПО КНОПКЕ")
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
