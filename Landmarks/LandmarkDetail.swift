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
                .offset(x: 100, y: -170)
                .padding(.bottom, -220)
            
            
            //      Mark: -  Название храма
            
            VStack(alignment: .center) {
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 0.3))
                    .frame (height: 60.0)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    .overlay(
                        
                        HStack {
                            Text(landmark.name)
                                .font(.headline)
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
                )
            }
            .offset(x: 0, y: -20)
            .padding(.bottom, -20)
            
            //            Mark: Расписание
            
            if landmark.explanation == nil && landmark.timeTable != nil {
                
                VStack (alignment: .leading, spacing: 10){
              
                    VStack (alignment: .leading){
                        Text ("Расписание Богослужений:").bold()
       
                    }
                   
                    
                    VStack(alignment: .leading) {
                        Text ("Понедельник:").bold()
                        Text (landmark.timeTable!.monday.morning)
                        Text (landmark.timeTable!.monday.evening)
                    
                    }
                    
                    VStack(alignment: .leading) {
                        Text ("Вторник-Пятница:").bold()
                        Text (landmark.timeTable!.tuesdayFriday.morning)
                        Text (landmark.timeTable!.tuesdayFriday.evening)
                     }
                    
                    VStack (alignment: .leading) {
                        Text ("Суббота").bold()
                        Text (landmark.timeTable!.saturday.morning)
                        Text (landmark.timeTable!.saturday.evening)
                     }
                    
                    
                    VStack(alignment: .leading) {
                        Text ("Воскресение:").bold()
                        Text (landmark.timeTable!.sunday.morning)
                        Text (landmark.timeTable!.sunday.evening)
                     }
                    
                } // List end
                    .font(.body)
            } else if landmark.explanation == nil && landmark.timeTable == nil{
                WebView (url: landmark.park).padding()
                .edgesIgnoringSafeArea(.top)
                .offset(x: 0, y: -20)
                .padding(.top, -20)
            }
            else {
                Text (landmark.explanation!)
                    .padding(.all)
            }
            
            Spacer()
            
            
            if landmark.explanation != nil || landmark.timeTable != nil {
            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 0.3))
                    .frame(  height: 50)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    .overlay(
                        
                        
                        HStack(alignment: .top) {
                            NavigationLink(destination: TimetableView(landmark: landmark)
                                .environmentObject(self.userData)
                                )
                            {  Text ("посмотреть расписание на сайте храма")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            }
                        }
                )
            }
            .padding(.bottom)
            }
        }
    }
}

struct LandmarkDetail_Preview: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return LandmarkDetail(landmark: userData.landmarks[1])
            .environmentObject(userData)
    }
}



