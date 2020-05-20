/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Helpers for loading images and data.
*/

import UIKit
import SwiftUI
import CoreLocation
 
 
var landmarkData: [Landmark] = load ("lanmarkData2.json" )

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
    
     //dump (data)
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

//func getFromURL (_ url: URL) -> [Landmark] {
//    var vata: Data
//    var jsonData: Array<Any>
//    let task = URLSession.shared.dataTask (with: url) { (data, response, error)   in
//        guard let data = data else {
//        print ("error data Api")
//        return  }
//
//        vata = data
//        dump (vata)
//         }
//                 task.resume()
//
//        do {
//        //print (data)
//        let decoder = JSONDecoder()
//            return try jsonData = decoder.decode([Landmark].self, from: vata ) as [Landmark]
//
//    } catch {
//        print ("Couldn't parse  ")
//    }
//
//
//    //return jsonData
//}
 


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




//func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void)
// {
//     let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//     let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
//
//     if FileManager().fileExists(atPath: destinationUrl.path)
//     {
//         completion(destinationUrl.path, nil)
//     }
//     else
//     {
//         let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
//         var request = URLRequest(url: url)
//         request.httpMethod = "GET"
//         let task = session.dataTask(with: request, completionHandler:
//         {
//             data, response, error in
//             if error == nil
//             {
//                 if let response = response as? HTTPURLResponse
//                 {
//                     if response.statusCode == 200
//                     {
//                         if let data = data
//                         {
//                             if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
//                             {
//                                 completion(destinationUrl.path, error)
//                             }
//                             else
//                             {
//                                 completion(destinationUrl.path, error)
//                             }
//                         }
//                         else
//                         {
//                             completion(destinationUrl.path, error)
//                         }
//                     }
//                 }
//             }
//             else
//             {
//                 completion(destinationUrl.path, error)
//             }
//         })
//         task.resume()
//     }
// }




//func copyJSON (filename: String) {
//
//let from = Bundle.main.url(forResource: "landmarkData", withExtension: "json")!
//
//let to = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("prihod.json")
//
//do {
//
//    try FileManager.default.copyItem(at: from, to: to)
//
//    print(try FileManager.default.contents(atPath: to.path))
//
//    let wer = Data("rerree".utf8 )
//
//    try wer.write(to: to)
//
//    print(try FileManager.default.contents(atPath: to.path))
//
//}
//catch {
//
//    print(error)
//}
//
//
//}


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
            let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
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
