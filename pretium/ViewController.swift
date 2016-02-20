//
//  ViewController.swift
//  pretium
//
//  Created by Michael Krumdick on 2/19/16.
//  Copyright © 2016 ndSophware. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var currentImage: UIImageView!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    func takePicture(){
        if(UIImagePickerController.isSourceTypeAvailable(.Camera)){
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil{
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                imagePicker.delegate = self
                presentViewController(imagePicker, animated: true, completion: {})
            } else {
                print("Cannot access rear camera")
            }
        } else {
            print("Camera is inaccessible")
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("Got an image")
        var newImage: UIImage
        if let possibleImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newImage = possibleImage
            readText(scaleImage(newImage, maxDimension: 640))
        } else {
            print("Error")
            return
        }
        
//        let imageName = NSUUID().UUIDString
//        let imagePath = getDocumentsDirectory().stringByAppendingPathComponent(imageName)
//        
//        if let jpegData = UIImageJPEGRepresentation(newImage, 80){
//            jpegData.writeToFile(imagePath, atomically: true)
//        }
        
        imagePicker.dismissViewControllerAnimated(true, completion: {
            // Anything you want to happen when the user saves an image
        })
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("User canceled image")
        dismissViewControllerAnimated(true, completion: {
            // Anything you want to happen when the user selects cancel
        })
    }
    
    func readText(image:UIImage){
        let tesseract = G8Tesseract()
        tesseract.language = "eng"
        tesseract.engineMode = .TesseractCubeCombined
        tesseract.pageSegmentationMode = .Auto
        tesseract.maximumRecognitionTime = 60.0
        tesseract.image = image.g8_blackAndWhite()
        tesseract.recognize()
        print(cleanString(tesseract.recognizedText))
    }
    
    func scaleImage(image: UIImage, maxDimension: CGFloat) -> UIImage {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        var scaleFactor: CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.drawInRect(CGRectMake(0, 0, scaledSize.width, scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    func cleanString(mess: String)-> [String] {
        var prices = [String]()
        let cleanerMess = mess.stringByReplacingOccurrencesOfString("\n", withString: " ")
        let arr = cleanerMess.characters.split{$0 == " "}.map(String.init)
        for str in arr{
            if str.rangeOfString(".") != nil{
                let splitStr = str.characters.split{$0 == "."}.map(String.init)
                if (splitStr.count == 2){
                    if (splitStr[1].characters.count == 2){
                        if (!prices.contains(str)) {
                            prices.append(str)
                        }
                    }
                }
            }
        }
        return prices
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        takePicture()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

