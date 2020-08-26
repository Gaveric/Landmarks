import Combine
import SwiftUI

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false      //@Published var landmarks = landmarkData
    @Published var landmarks: [Landmark] = []
    @Published var categories: [String: [Landmark]] = [:]
    @Published var expander = [String: Bool] ()
    
    
    init() {
        takeUrl()
    }
    
    func makeCategories(landmarks: [Landmark]){
        categories = Dictionary(
            grouping:  self.landmarks,
            by: { $0.category.rawValue }
        )
        dump (categories.count)
        print ("     ________________categories________________")
            }
    
    func makeExpander() {
        expander = Dictionary (uniqueKeysWithValues: zip(categories.keys, Array(repeating: false, count: categories.keys.count)))
        dump (expander)
        print ( "_____________expander___________")
    }
    
    func takeUrl () {
    
        
        let url = URL(string:"https://api.jsonbin.io/b/5f3f5b85993a2e110d32b538/latest")!
            
            
            //https://files.fm/down.php?i=xt239puv")!
                      // https://files.progressman.ru/landmarkData.json")!
       
//https://api.jsonbin.io/b/5f3ba62fb88c04101cf64a4e/latest
//        guard let url1 = URL(string: "https://api.lucidtech.ai/v0/receipts"),
//            let payload = "{\"documentId\": \"a50920e1-214b-4c46-9137-2c03f96aad56\"}".data(using: .utf8) else
//        {
//            return
//        }

//        var request = URLRequest(url: url1)
//        request.httpMethod = "POST"
//        request.addValue("your_api_key", forHTTPHeaderField: "x-api-key")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = payload
        
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let todoData = data {
                    let decodedData = try JSONDecoder().decode([Landmark].self, from: todoData)
                    DispatchQueue.main.async {
                        self.landmarks = decodedData
                        
                        for i in 0..<self.landmarks.count {
                            dump (self.landmarks[i].name)
                            // dump (UserDefaults.standard.string (forKey:  self.landmarks[i].name))
                            
                            if UserDefaults.standard.string (forKey:  self.landmarks[i].name) != nil {
                                
                                self.landmarks[i].isFavorite =  Bool (UserDefaults.standard.string (forKey: self.landmarks[i].name) ?? "false")!
                            }}
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            
                            self.makeCategories(landmarks: self.landmarks)
                            self.makeExpander()

                        }
                        
                    }
                } else {
                    print("No data")
                }
            } catch {
                print("Error")
            }
        }.resume()
        
    }
    
    func takeBondle() {
        
        self.landmarks = landmarkData
        
        for i in 0..<self.landmarks.count {
            dump (self.landmarks[i].name)
            dump (UserDefaults.standard.string (forKey:  self.landmarks[i].name))
            
            if UserDefaults.standard.string (forKey:  self.landmarks[i].name) != nil {
                
                self.landmarks[i].isFavorite =  Bool (UserDefaults.standard.string (forKey: self.landmarks[i].name) ?? "false")!
            }}
        
    }
    
    
}


struct UserData_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
