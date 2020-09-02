import SwiftUI

struct LandmarkDetail: View {
    @EnvironmentObject var userData: UserData
    var landmark: Landmark
    var landmarkIndex: Int {
        userData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    var body: some View {
        VStack {
            MapView(coordinate: landmark.locationCoordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 100)
            CircleImage(image: landmark.image)
                .offset(x: 100, y: -150)
                .padding(.bottom, -160)
            VStack(alignment: .center) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                    Button(action: {
                        self.userData.landmarks[self.landmarkIndex].isFavorite.toggle()
                        dump(self.userData.landmarks[self.landmarkIndex].isFavorite)
                        self.userData.makeCategories(landmarks: self.userData.landmarks)        //здесь нужно убрать перезапись категории
                        let toggle =  self.userData.landmarks[self.landmarkIndex].isFavorite
                        let defaults = UserDefaults.standard
                        defaults.set(String(toggle), forKey: self.userData.landmarks[self.landmarkIndex].name)
                        defaults.synchronize()
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
            .offset(x: 0, y: 0)
            .padding(.bottom, 0)
            if landmark.explanation == nil {
               
                Form {
                    HStack {
                        Text ("Расписание Богослужений:").bold() 
                        Spacer()
                    }
                    VStack(alignment: .leading) {
                        Text ("Понедельник:")
                        Text (landmark.timeTable!.monday.morning)
                        Text (landmark.timeTable!.monday.evening)
                    }
                    VStack(alignment: .leading) {
                        Text ("Вторник-Пятница:")
                        Text (landmark.timeTable!.tuesdayFriday.morning)
                        Text (landmark.timeTable!.tuesdayFriday.evening)
                    }
                    VStack(alignment: .leading) {
                        Text ("Суббота:")
                        Text (landmark.timeTable!.saturday.morning)
                        Text (landmark.timeTable!.saturday.evening)
                    }
                    VStack(alignment: .leading) {
                        Text ("Воскресение:")
                        Text (landmark.timeTable!.sunday.morning)
                        Text (landmark.timeTable!.sunday.evening)
                    }
                } // List end
                    .font(.system(size: 12))
            }
            else {
                Text (landmark.explanation!)
                    .padding(.all)
            }
            Spacer()
            HStack(alignment: .top) {
                NavigationLink(
                    destination: TimetableView(landmark: landmark)
                        .environmentObject(self.userData)
                )
                {  Text ("(посмотреть подробное расписание)") .font(.subheadline)
                }
            }
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
