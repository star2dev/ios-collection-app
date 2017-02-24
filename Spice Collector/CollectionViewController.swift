//
//  CollectionViewController.swift
//  Spice Collector
//
//  Created by Bruce Galpin on 2017/02/24.
//  Copyright © 2017 Social-IT-e Media. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var collectionImage: UIImageView!
    @IBOutlet weak var collectionTitleTxtField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
    }

    @IBAction func browsePhotos(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        collectionImage.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func launchCamera(_ sender: Any) {
    }
    
    @IBAction func addCollectionBtn(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let spice = Spice(context: context)
        spice.title = collectionTitleTxtField.text
        spice.image = UIImagePNGRepresentation(collectionImage.image!) as NSData?
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
}
