
import SwiftUI
import PDFKit

struct TimetableView: View {
    @EnvironmentObject var userData: UserData
    var landmark: Landmark
    
    //let documentURL = Bundle.main.url(forResource: "timeTable", withExtension: "pdf")!
    var body: some View {
        VStack(alignment: .center) {
            
            WebView (url: landmark.park).padding()
                .edgesIgnoringSafeArea(.top)
                .offset(x: 0, y: -20)
                .padding(.top, -20)
            
            
            
            //            Button ("Обновить расписание", action: {
            //
            //                let url = URL (string: "http://uspenski.cerkov.ru/files/2013/10/Rasp.pdf")
            //                let downloadTask = URLSession.shared.downloadTask(with: url!) {
            //                    urlOrNil, responseOrNil, errorOrNil in
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
            //                print(downloadTask)
            //            })
            //                .padding()
            //                .offset(x: -100, y: 0)
            //PDFKitView(url: documentURL)
        }
       .padding(.top, -50.0)
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


