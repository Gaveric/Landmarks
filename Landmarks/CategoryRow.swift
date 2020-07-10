import SwiftUI

struct CategoryRow: View {
    @EnvironmentObject private var userData: UserData
    @State var expand = false
    var categoryName: String
    var items: [Landmark]
    var body: some View {
        VStack(alignment: .leading) {
            
                
            HStack {
                Text(self.categoryName)
                    .font(.headline)
                    .padding(.leading, 15)
                    .padding(.top, 5)
                Image(systemName: expand ? "chevron.up" : "chevron.down")
            }.onTapGesture {
                self.expand.toggle()
            }
            if expand {
             //  VStack(alignment: .leading, spacing: 0) {
           // HStack {
            List {
                        ForEach(self.items) { landmark in
                          // Text(landmark.name)
                            
                            if !self.userData.showFavoritesOnly || landmark.isFavorite {
                                NavigationLink(
                                    destination: LandmarkDetail(landmark: landmark)
                                        //.environmentObject(self.userData)
                                ) {
                                    
                            LandmarkRow(landmark: landmark)
                                    
                    }.scaledToFill()
                            }
                }
                
               // }
            }
            .scaledToFit()//.scaledToFill()
        }
       }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(
            categoryName: landmarkData[0].category.rawValue,
            items: Array(landmarkData.prefix(4))
        )
    }
}
