//
//  AddPhotoViewController.swift
//  ViewFinder
//
//  Created by Apple on 6/25/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

//ass ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var photos : [Photos] = []
    
    //Create an instance of UIImagePickerController, stored in a property on that class
    var newScreen = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Tell that property to give it’s information to this class
        newScreen.delegate = self
    }// end of override func viewDidLoad()
    

    func getPhotos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            if let coreDataPhotos = try? context.fetch(Photos.fetchRequest()) as? [Photos] {
               photos = coreDataPhotos
                tableView.reloadData()
            }
        }
    }
    
    
    
    //Create actions for all buttons, and an outlet for the placeholder photo and text field
    //  @IBOutlet weak var photoTaken: UIImageView! these are the same
    @IBOutlet weak var photoShown: UIImageView!
    
    
    
    //Inside of your actions for “Take Photo”, “Find Photo”, etc., write the code necessary to access the camera/library/albums, based on which action you are in.
    
    @IBAction func TakePhoto(_ sender: UIButton) {
        newScreen.sourceType = .camera
        present(newScreen, animated: true, completion: nil)
    }
    
    
    @IBAction func AccessAlbum(_ sender: UIButton) {
        newScreen.sourceType = .photoLibrary
        present(newScreen, animated: true, completion: nil)
    }
    

    //Write the imagePickerController function. Again, feel free to reference the lesson from this.
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            //photoTaken
            photoShown.image = selectedImage
        }
        newScreen.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            
            let photoToSave = Photos(entity: Photos.entity(), insertInto: context)
            photoToSave.caption = captionText.text
            
            if let userImage = photoShown.image {
                if let userImageData = UIImagePNGRepresentation(userImage){
                    photoToSave.imageData = userImageData
                }
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            navigationController?.popViewController(animated: true)
            
        }//end if let context
    
    }//end of saveButton func
    
    
    
    
    @IBOutlet weak var captionText: UITextField!
    
    
    
    

    
    
    
    
}//end of the AddPhotoViewController
