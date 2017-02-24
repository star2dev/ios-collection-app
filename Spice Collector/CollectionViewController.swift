//
//  CollectionViewController.swift
//  Spice Collector
//
//  Created by Bruce Galpin on 2017/02/24.
//  Copyright © 2017 Social-IT-e Media. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var addUpdateBtn: UIButton!
    @IBOutlet weak var collectionImage: UIImageView!
    @IBOutlet weak var collectionTitleTxtField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var spice : Spice? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if spice != nil {
            collectionImage.image = UIImage(data: spice!.image as! Data)
            collectionTitleTxtField.text = spice!.title
            
            addUpdateBtn.setTitle("Update", for: .normal)
        } else {
            deleteBtn.isHidden = true
        }
        
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
        
        if spice != nil {
            
            spice!.title = collectionTitleTxtField.text
            spice!.image = UIImagePNGRepresentation(collectionImage.image!) as NSData?
            
        } else {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let spice = Spice(context: context)
            spice.title = collectionTitleTxtField.text
            spice.image = UIImagePNGRepresentation(collectionImage.image!) as NSData?
            
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func deleteCollectionBtn(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(spice!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
}
