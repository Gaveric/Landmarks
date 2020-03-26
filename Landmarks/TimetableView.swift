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
    //var documentURL = URL (string: "http://успенскийприход.рф/files/2020/02/на-март-1.pdf")
    var document = PDFDocument(url: URL(string: "http://успенскийприход.рф/files/2020/02/на-март-1.pdf")!)
  
    //if let document = PDFDocument(url: pdfURL) {
//               pdfView.document = document
//           }
//
//           DispatchQueue.main.asyncAfter(deadline: .now()+3) {
//               self.dismiss(animated: true, completion: nil)
//           }
       
    
    
    var body: some View {
       
     Text("здесь откроется расписание")
       
      
    }
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


