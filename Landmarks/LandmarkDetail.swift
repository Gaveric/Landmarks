/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing the details for a landmark.
*/

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
                
                
                      
                //                Button ("Обновить расписание", action: {
                //
                //                    let url = URL (string: "http://xn--d1abjaeeumcfledx5b.xn--p1ai/files/2020/02/%D0%BD%D0%B0-%D0%BC%D0%B0%D1%80%D1%82-1.pdf")
                //               let downloadTask = URLSession.shared.downloadTask(with: url!) {
                //                    urlOrNil, responseOrNil, errorOrNil in
                //                    // check for and handle errors:
                //                    // * errorOrNil should be nil
                //                    // * responseOrNil should be an HTTPURLResponse with statusCode in 200..<299
                //
                //                    guard let fileURL = urlOrNil else { return }
                //                    do {
                //                        let documentsURL = try
                //                            FileManager.default.url(for: .documentDirectory,
                //                                                    in: .userDomainMask,
                //                                                    appropriateFor: nil,
                //                                                    create: false)
                //                        let savedURL = documentsURL.appendingPathComponent(
                //                            fileURL.lastPathComponent)
                //                        try FileManager.default.moveItem(at: fileURL, to: savedURL)
                //                    } catch {
                //                        print ("file error: \(error)")
                //                    }
                //                }
                //                downloadTask.resume()
                //
                //                })
                //                //    .padding()
                //                .offset(x: -100, y: 0)
                //
                                
                
            MapView(coordinate: landmark.locationCoordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 150)
            
            CircleImage(image: landmark.image)
                .offset(x: 0, y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
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
                
                
                
                HStack(alignment: .top) {
                    
                    
                    //-----------------
                                
                                    NavigationLink(
                                        destination: TimetableView(landmark: landmark)
                                            .environmentObject(self.userData)
                                    )               {  Text ("Подробное расписание") .font(.subheadline)
                                        
                                    }
                                    
                                
                    //_________________

                    
                    
                       
                    Spacer()
                    Text(landmark.state)
                        .font(.subheadline)
                }
            }
            .padding()
            
            Spacer()
            
            
        }//================
            
            
        }
    }
//}

struct LandmarkDetail_Preview: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return LandmarkDetail(landmark: userData.landmarks[0])
            .environmentObject(userData)
    }
}
