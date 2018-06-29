//
//  ViewController.swift
//  HotDoggyDogZ!
//
//  Created by McKinney family  on 6/26/18.
//  Copyright © 2018 FasTek Technologies. All rights reserved.
//

import UIKit
import VisualRecognitionV3
import SVProgressHUD
import CoreML

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //var or constants
    let imagePicker = UIImagePickerController()
    
    let apiKey = "fbcd915e6875571676ce33843a6acc6f59db0e28"
    
    let version = "2017-05-19"
     var classificationResults : [String] = []
    
    
    //outlet
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var hotdogImg: UIImageView!
    
    
    
    
    
    
    
    //func
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let hotdogIMG = info[UIImagePickerControllerOriginalImage] as? UIImage {
           
            hotdogImg.image = hotdogIMG
            
            imagePicker.dismiss(animated: true, completion: nil)
            
            let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        
            let imageData = UIImageJPEGRepresentation(hotdogIMG, 0.01)
            
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            let fileURL = documentsURL.appendingPathComponent("tempImage.jpg")
            
            try? imageData?.write(to: fileURL, options: [])
            
            visualRecognition.classify(imagesFile: fileURL, success:  {(classifiedImages)in
                let classes = classifiedImages.images.first?.classifiers.first?.classes
                
                
            })
            
        } else {
            print("There was an Error picking image")
        }
        
    }
    
    
    
    
    
    //IbAction btn
    @IBAction func cameraBtnPressed(_ sender: UIBarButtonItem) {
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

