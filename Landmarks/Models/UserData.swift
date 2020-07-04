import Combine
import SwiftUI
 
final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false      //@Published var landmarks = landmarkData
    @Published var landmarks: [Landmark] = []
    init() {
        takeUrl()
        // здесь нужно добавить в landmarks звездочки пользователя из Кордата
    }
    func takeUrl () {
    let url = URL(string: "http://uspenski.cerkov.ru/files/2020/05/landmarkData.jpg")! //https://files.progressman.ru/landmarkData.json")!
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
    
    
}

