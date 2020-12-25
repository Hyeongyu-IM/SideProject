//
//  ImageFileManager.swift
//  BasicWeatherApp iOS
//
//  Created by 임현규 on 2020/12/23.
//

import UIKit

class ImageFileManager {
    static let shared: ImageFileManager = ImageFileManager()
    fileprivate let fileManager = FileManager.default
    
    func saveImage(_ image: UIImage,_ name: String) {
        let url = "http://openweathermap.org/img/wn/\(name)@2x.png"
        
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return }
        
        var filePath = URL(fileURLWithPath: path)
        filePath.appendPathComponent((url as NSString).lastPathComponent)
        
        if !fileManager.fileExists(atPath: filePath.path) {
            fileManager.createFile(atPath: filePath.path,
                                   contents: image.pngData(),
                                   attributes: nil)
        }
    }
    
    func loadImage(_ name: String) -> UIImage {
        let url = "http://openweathermap.org/img/wn/\(name)@2x.png"
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return UIImage() }
        
        var filePath = URL(fileURLWithPath: path)
        filePath.appendPathComponent((url as NSString).lastPathComponent)
        
        if fileManager.fileExists(atPath: filePath.path) {
            guard let imageData = try? Data(contentsOf: filePath) else {
                return UIImage()
            }
            guard let image = UIImage(data: imageData) else {
                return UIImage()
            }
            print(#function, "성공적으로 이미지를 불러왔습니다")
            return image
        }
        return UIImage()
    }
    
    func checkingImage(_ name: String) -> Bool {
        let url = "http://openweathermap.org/img/wn/\(name)@2x.png"
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return false }
        
        var filePath = URL(fileURLWithPath: path)
        
        filePath.appendPathComponent((url as NSString).lastPathComponent)
        return fileManager.fileExists(atPath: filePath.path)
    }
}
