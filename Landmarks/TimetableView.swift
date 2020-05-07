
import SwiftUI
import PDFKit

struct TimetableView: View {
    @EnvironmentObject var userData: UserData
    var landmark: Landmark
    
    let documentURL = Bundle.main.url(forResource: "timeTable", withExtension: "pdf")!
    var body: some View {
        VStack(alignment: .center) {
       
// Отображение пдф расписания через вебвью
   
            WebView (url: "http://xn--d1abjaeeumcfledx5b.xn--p1ai/files/2020/03/%D0%B0%D0%BF%D1%80%D0%B5%D0%BB%D1%8C-1.pdf")
            
             WebView (url: landmark.park)
        
// Пока не готово - Обновление ПДФ расписания с сайта Храма (ссылка должна быть в Джейсоне)
           
            Button ("Обновить расписание", action: {
                
                let url = URL (string: "http://xn--d1abjaeeumcfledx5b.xn--p1ai/files/2020/03/%D0%B0%D0%BF%D1%80%D0%B5%D0%BB%D1%8C-1.pdf")
                let downloadTask = URLSession.shared.downloadTask(with: url!) {
                    urlOrNil, responseOrNil, errorOrNil in
                    // check for and handle errors:
                    // * errorOrNil should be nil
                    // * responseOrNil should be an HTTPURLResponse with statusCode in/Users/user/Downloads/HandlingUserInput-1/Complete/Landmarks/Landmarks/WebView.swift 200..<299
                    
                    guard let fileURL = urlOrNil else { return }
                    do {
                        let documentsURL = try
                            FileManager.default.url(for: .documentDirectory,
                                                    in: .userDomainMask,
                                                    appropriateFor: nil,
                                                    create: false)
                        let savedURL = documentsURL.appendingPathComponent(
                            fileURL.lastPathComponent)
                        try FileManager.default.moveItem(at: fileURL, to: savedURL)
                    } catch {
                        print ("file error: \(error)")
                    }
                }
                downloadTask.resume()
                print(downloadTask)
                
                
            })
                .padding()
                .offset(x: -100, y: 0)
         
            
            //PDFKitView(url: documentURL)
     
// _______
            
            

            
        }
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


