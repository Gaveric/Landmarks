import Combine
import SwiftUI

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false      //@Published var landmarks = landmarkData
    @Published var landmarks: [Landmark] = []
    @Published var categories: [String: [Landmark]] = [:]
    @Published var expander = [String: Bool] ()
    
        
    init() {
        //takeBondle()
         takeUrl()
        makeCategories(landmarks: landmarks)
     }
    
    func makeCategories(landmarks: [Landmark]){
        categories = Dictionary(
            grouping:  self.landmarks,
            by: { $0.category.rawValue }
        )
        expander = Dictionary (uniqueKeysWithValues: zip(categories.keys, Array(repeating: false, count: categories.keys.count)))
    }
    
    func takeUrl () {
        let url = URL(string: "https://my-files.su/Save/cmr520/landmarkData2.json")!
        //https://files.progressman.ru/landmarkData.json")!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let todoData = data {
                    let decodedData = try JSONDecoder().decode([Landmark].self, from: todoData)
                    DispatchQueue.main.async {
                        self.landmarks = decodedData
                        
                        for i in 0..<self.landmarks.count {
                            dump (self.landmarks[i].name)
                            dump (UserDefaults.standard.string (forKey:  self.landmarks[i].name))
                            
                            if UserDefaults.standard.string (forKey:  self.landmarks[i].name) != nil {
                                
                                self.landmarks[i].isFavorite =  Bool (UserDefaults.standard.string (forKey: self.landmarks[i].name) ?? "false")!
                            }}
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
