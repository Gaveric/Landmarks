
import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject private var userData: UserData
   //@ObservedObject private var userData: UserData
    
//    init() {
//        // To remove only extra separators below the list:
//        UITableView.appearance().tableFooterView = UIView()
//        //self.init()
//        // To remove all separators including the actual ones:
//       // UITableView.appearance().separatorStyle = .none
//    }
    
    
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
                
                /*
                    let task = URLSession.shared.dataTask (with: baseURL) { (data, response, error)   in
                        guard let data = data else {
                            print ("error data Api")
                            return  }
                       
                            do {
                                let json = try JSONDecoder().decode(CurrentWeather.self, from: data) as CurrentWeather?
                                
                                
                            } catch   {
                            print ("error JSON")
                            }        }
                    
                    task.resume()
                }
                */
                Button ("Обновить список храмов", action: {
                    let url = URL (string: "https://files.progressman.ru/landmarkData.json")
                        //http://uspenski.cerkov.ru/files/2020/05/landmarkData.jpg")
                        
                    //landmarkData = getFromURL1 (url: baseURL )
                    //landmarkData = fetch ("http://uspenski.cerkov.ru/files/2020/05/landmarkData.jpg")
                     
                    print (landmarkData, "                                             ПРИНТ ПО КНОПКЕ")
                    //dump (landmarkData)
                
                     
                                  //  saveJSON(filename: "landmarkData.json", object: self.userData.landmarks)
                    })
            }
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
