//
//  ImageUploader.swift
//  TwitterCloneSwiftUi
//
//  Created by Андрей Русин on 18.10.2022.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit

class ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> ()) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profileImage/\(fileName)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error {
                print("Debug: Failed to upload image with \(error.localizedDescription)")
                return
            }
            ref.downloadURL { imageURL, error in
                guard error == nil else {
                    print("Debug: Can't download image with error: \(error!.localizedDescription)")
                    return
                }
                
                guard let imageURl = imageURL?.absoluteString else {return}
                completion(imageURl)
            }
        }
    }
}
