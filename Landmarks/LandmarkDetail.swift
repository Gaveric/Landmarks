 
 
 import SwiftUI
 
 struct LandmarkDetail: View {
    @EnvironmentObject var userData: UserData
    var landmark: Landmark
    
    var landmarkIndex: Int {
        userData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    
    var body: some View {
        //        NavigationView {
        VStack {
            
            MapView(coordinate: landmark.locationCoordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 110)
            
            CircleImage(image: landmark.image)
                .offset(x: 0, y: -170)
                .padding(.bottom, -130)
            
            VStack(alignment: .center) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                    
                    Button(action: {
                        self.userData.landmarks[self.landmarkIndex]
                            .isFavorite.toggle()
                    }) {
                        if self.userData.landmarks[self.landmarkIndex]
                            .isFavorite {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.yellow)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                
                }
                         .offset(x: 0, y: -50)
                         .padding(.bottom, -50)
                
                // Повседневное общее расписание
              //  Spacer()
               
            HStack {
                Text ("Расписание Богослужений:")
            Spacer()
            }
            
            
            
            
            List{
                
                VStack {
                    Text ("Понедельник:")
                    Text ("8-00 - Утреня.Вечерня.Литургия")
                    Text ("16-00 - Утреня.Вечерня.(Всенощное бдение)")
                }
                
                VStack {
                    Text ("Вторник:")
                    Text ("8-30 - Литургия")
                    Text ("16-00 - Утреня.Вечерня.(Всенощное бдение)")
                }
                    
                    
                }
                .font(.system(size: 12))
            
          
            
                // Ссылка на подробное расписание
                
                HStack(alignment: .top) {
                    NavigationLink(
                        destination: TimetableView(landmark: landmark)
                            .environmentObject(self.userData)
                    )               {  Text ("Посмотреть подробное расписание") .font(.subheadline)
                    }
                    
                    Spacer()
                    Text(landmark.state)
                        .font(.subheadline)
                }
          
            
            // Spacer()
        }
    }
 }
 
 struct LandmarkDetail_Preview: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return LandmarkDetail(landmark: userData.landmarks[0])
            .environmentObject(userData)
    }
 }
