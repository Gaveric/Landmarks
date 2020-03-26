//
//  TimetableView.swift
//  Landmarks
//
//  Created by User on 25.03.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI
import PDFKit

struct TimetableView: View {
    @EnvironmentObject var userData: UserData
    var landmark: Landmark
    
     let documentURL = Bundle.main.url(forResource: "timeTable", withExtension: "pdf")!
     var body: some View {
         VStack(alignment: .center) {
//             Text("PSPDFKit SwiftUI")
//                 .font(.largeTitle)
//             HStack(alignment: .top) {
//                 Text("Made with ❤ at WWDC19")
//                     .font(.title)
//             }
             PDFKitView(url: documentURL)
         }
     }
    
    
    
//    var body: some View {
//        PDFKitView(landmark.park)
//     Text("здесь откроется расписание")
//    }
    
    
    
    
    
    
}

struct TimetableView_Previews: PreviewProvider {
    
        static var previews: some View {
        let userData = UserData()
        return TimetableView(landmark: userData.landmarks[0])
            .environmentObject(userData)
    }
    
    
//    static var previews: some View {
//        TimetableView(landmark: <#T##Landmark#>)
   }


