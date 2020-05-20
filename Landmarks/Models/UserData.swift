/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A model object that stores app data.
*/

import Combine
import SwiftUI
 

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
//    @Published var landmarks = landmarkData
    @Published var landmarks: [Landmark] = []
    
    init() {
        let url = URL(string: "http://uspenski.cerkov.ru/files/2020/05/landmarkData.jpg")! //https://files.progressman.ru/landmarkData.json")!
        // 2.
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let todoData = data {
                    // 3.
                    let decodedData = try JSONDecoder().decode([Landmark].self, from: todoData)
                    DispatchQueue.main.async {
                        self.landmarks = decodedData
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

