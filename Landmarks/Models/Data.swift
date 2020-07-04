import UIKit
import SwiftUI
import CoreLocation
import CoreData
 
var landmarkData: [Landmark] = load("landmarkData2.json")

func load<T: Decodable>(_ filename: String) -> T {
     
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
            } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func getFromURL1 (url: URL) -> [Landmark] {
    var jsonData: [Landmark] = []
    let task = URLSession.shared.dataTask (with: url) { (data, response, error)   in
        guard let data = data else {
            print ("error data Api")
            return  }
        print ("это сработал метод гетфромУРЛ", data)
        do {
            let decoder = JSONDecoder()
            try jsonData = decoder.decode([Landmark].self, from: data )
            print (jsonData[0].isFavorite)
        } catch {
            print ("Couldn't parse  ")
            }
    }
    task.resume()
    return jsonData
}

func saveJSON<T: Codable>(filename: String, object: T) {
    do {
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        do {
            let encoder = try JSONEncoder().encode(object)
            return try encoder.write (to: file)
        } catch {
                print("JSONSave error of \(error)")
        }
    }
}

final class ImageStore {
    typealias _ImageDictionary = [String: CGImage]
    fileprivate var images: _ImageDictionary = [:]     // объявление массива картинок

    fileprivate static var scale = 2
    
    static var shared = ImageStore()
    
    func image(name: String) -> Image {
        let index = _guaranteeImage(name: name)
        
        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(name))
    }

    static func loadImage(name: String) -> CGImage {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "jpg") ?? Bundle.main.url(forResource: "Default", withExtension: "jpg"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            fatalError("Couldn't load image \(name).jpg from main bundle.")
        }
        return image
    }
    
    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        images[name] = ImageStore.loadImage(name: name)
        return images.index(forKey: name)!
    }
}


struct Data_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
