//
//  AddVC.swift
//  NewBook
//
//  Created by STARKS on 8/13/18.
//  Copyright © 2018 STARKS. All rights reserved.
//

import UIKit
import RealmSwift

class AddVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var existingCourse : Course?
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var price: UITextField!
    var imagePicker : UIImagePickerController!
 
    override func viewDidLoad() {
        super.viewDidLoad()
imagePicker = UIImagePickerController()
        if let passedCourse = existingCourse{
            name.text = passedCourse.name
            email.text = passedCourse.email
            price.text = passedCourse.price
            if let imageNsData = passedCourse.imageNsData as Data?
            {
                let images = UIImage(data: imageNsData)
            image.image = images
                
                
            }
            
            
            
        }
        
        
        
        
    }
    
    @IBAction func SaveBtn(_ sender: Any) {
        var newCourse : Course!
        
        
        if existingCourse == nil{
        newCourse = Course()
        if let name = name.text{
            newCourse.name = name
        }
        if let email = email.text{
            newCourse.email = email
        }
        if let price = price.text{
            newCourse.price = price
        }
        if let imageD = image.image{
            if let nsData = imageD.jpegData(compressionQuality: 0.1) as NSData?
            {
                newCourse.imageNsData = nsData
            }
            
        }
        let realm = try? Realm()
        try? realm?.write{
            realm?.add(newCourse)
        }
        }
        else
        {
            newCourse = existingCourse
            let realm = try? Realm()
        
            try? realm?.write {
                if let name = name.text{
                    newCourse.name = name
                }
                if let email = email.text{
                    newCourse.email = email
                }
                if let price = price.text{
                    newCourse.price = price
                    
                }
                if let image = image.image{
                    if let nsData = image.jpegData(compressionQuality: 0.1) as NSData?
                    {
                        newCourse.imageNsData = nsData
                    }
                }
            }
            
        }
        
        
        navigationController?.popViewController(animated: true)
    
    
    }
    @IBAction func TapGest(_ sender: Any) {
    imagePicker.sourceType = .photoLibrary
    imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let ima = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {image.image = ima
        }
        picker.dismiss(animated: true, completion: nil)
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
