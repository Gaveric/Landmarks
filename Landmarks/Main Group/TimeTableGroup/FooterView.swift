
import SwiftUI

struct FooterView: View {
    @EnvironmentObject private var userData: UserData
    var items: [Landmark]
    var key: String

    var body: some View {
        ForEach(self.items) { landmark in
            if !self.userData.showFavoritesOnly || landmark.isFavorite {
                
                List  {
                    HStack {
                        NavigationLink(
                            destination: LandmarkDetail(landmark: landmark)
                        ) {
                            LandmarkRow(landmark: landmark)
                        }
                    }
                }.frame(height: 53)
            }
        }
    }
    
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        Text(" ")
    }
}
