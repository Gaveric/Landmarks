//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by User on 07.05.2020.
//  Copyright © 2020 Apple. All rights reserved.
//


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
            
                        HStack(alignment: .top) {
                            NavigationLink(
                                destination: TimetableView(landmark: landmark)
                                    .environmentObject(self.userData)
                            )               {  Text ("(смотреть подробное расписание)") .font(.subheadline)
                            }
                            
                            Spacer()
            //                Text(landmark.state)
            //                    .font(.subheadline)
                        }
            
            List{
                
                VStack(alignment: .leading) {
                    Text ("Понедельник:")
                    Text ("8-00 - Утреня.Вечерня.Литургия")
                    Text ("16-00 - Утреня.Вечерня.(Всенощное бдение)")
                }
                
                VStack(alignment: .leading) {
                    Text ("Вторник-Пятница:")
                    Text ("8-30 - Литургия")
                    Text ("16-00 - Утреня.Вечерня.(Всенощное бдение)")
                }
                
                VStack(alignment: .leading) {
                    Text ("Суббота:")
                    Text ("8-30 - Литургия")
                    Text ("16-00 - Всенощное бдение")
                }
                
                VStack(alignment: .leading) {
                    Text ("Воскресение:")
                    Text ("8-30 - Литургия")
                    Text ("Утреня, Вечерня не служится")
                }
                
                
            } // List end
                .font(.system(size: 12))
            
            
            
            
            // Ссылка на подробное расписание
            

            
            
            
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
