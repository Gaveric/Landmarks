import UIKit
import SwiftUI
import CoreLocation
import CoreData
 
extension Color {
    static let offWhite = Color(red: 0.96, green: 0.96, blue: 0.96)
    static let offBlue = Color(red: 0.93, green: 0.96, blue: 0.97)

    //Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}
 

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 22, height: 22)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}

var landmarkData: [Landmark] = load("landmarkData3.json")

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
       
        ZStack {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.offWhite)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 0.3)) // линия вокруг кнопки
            .frame(width: 190, height: 50)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            .overlay(
                VStack {
                    Text("Hello, World!")
                }
        )
        }//.foregroundColor(Color.offBlue)

    }
}


