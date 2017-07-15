//
//  ViewController.swift
//  VideoCamera
//
//  Created by Saxena, Sameer on 1/11/17.
//  Copyright © 2017 Saxena, Sameer. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker : UIImagePickerController = UIImagePickerController()
    var saveFileName = "/video.mp4"
    var ticker = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Started recording
    @IBAction func record(sender: AnyObject) {
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if (UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil) {
                
                imagePicker.sourceType = .Camera
                imagePicker.mediaTypes = [kUTTypeMovie as String]
                imagePicker.allowsEditing = false
                imagePicker.delegate = self
                
                presentViewController(imagePicker, animated: true, completion: nil)
                
            } else {
                print("Rear Camera not available")
            }
        } else {
            print("No Camera Available")
        }
    }
    
    //Finished recording
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedVideo: NSURL = (info[UIImagePickerControllerMediaURL] as? NSURL) {
            saveFileName = "/video\(ticker).mp4"
            ticker += 1
            
            let selectorCall = Selector("videoWasSavedSuccessfully:didFinishSavingWithError:context:")
            UISaveVideoAtPathToSavedPhotosAlbum(pickedVideo.relativePath!, self, selectorCall, nil)
            
            let videoData = NSData(contentsOfURL: pickedVideo)
            let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            let documentsDirectory : AnyObject = paths[0]
            let dataPath = documentsDirectory.stringByAppendingPathComponent(saveFileName)
            videoData?.writeToFile(dataPath, atomically: false)
            
            imagePicker.dismissViewControllerAnimated(true, completion: nil)
            
        }
    }
    
    @IBAction func play(sender: AnyObject) {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory : AnyObject = paths[0]
        let dataPath = documentsDirectory.stringByAppendingPathComponent(saveFileName)
        
        let videoAsset = (AVAsset(URL: NSURL(fileURLWithPath: dataPath)))
        let playerItem = AVPlayerItem(asset: videoAsset)
        
        let player = AVPlayer(playerItem: playerItem)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        
        self.presentViewController(playerVC, animated: true) { 
            playerVC.player?.play()
        }
    }

}

