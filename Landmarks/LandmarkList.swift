/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a list of landmarks.
*/

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        NavigationView {
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
            
            
            
            
//            <!-- START MAP -->
//            <script type="text/javascript">
//            var mapDefaultFilter = {church_id:3258}, setBoundsAuto=true, setHideChurchTree=true;
//            (function() {
//            var s = document.createElement("script");
//            s.type ="text/javascript"; s.id = "map"; s.charset = "utf-8"; s.async = true;
//            s.src = "http://prihod.ru/map/js/init.js";
//            var sc = document.getElementsByTagName("head")[0];
//            if (sc){ sc.appendChild(s); }else{ document.documentElement.firstChild.appendChild(s); }
//            })();
//            </script>
//            <main class="web-app-map" id="web-app-map" style="width:100%;height:600px"></main>
//            <!-- END MAP -->
            
            
            
            
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
