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
             List {
                
                //_________________Где-то здесь добавляет лишние ячейки______________________
                
                        ForEach(self.items) { landmark in
                            if !self.userData.showFavoritesOnly || landmark.isFavorite {
                                NavigationLink(
                                    destination: LandmarkDetail(landmark: landmark)
                                        .environmentObject(self.userData)
                                ) {
                                    
                            LandmarkRow(landmark: landmark)
                //______________________________________
                    }.scaledToFill()  // Если это не использовать, то ячейки вообще не отображаются
                            }
                }
            }
            //.scaledToFit()
            .scaledToFill()
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
