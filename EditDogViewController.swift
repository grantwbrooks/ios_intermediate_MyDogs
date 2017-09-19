//
//  EditDogViewController.swift
//  MyDogs
//
//  Created by Grant Brooks on 9/18/17.
//  Copyright © 2017 Grant Brooks. All rights reserved.
//

import UIKit

class EditDogViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var delegate: EditDogDelegate?
    var name: String?
    var color: String?
    var treat: String?
    var index: NSIndexPath?
    var newimage: UIImage?
    
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var colorLabel: UITextField!
    @IBOutlet weak var treatLabel: UITextField!
    
    @IBAction func photofromLibrary(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            myDogImage.setBackgroundImage(image, for: [])
            newimage = image
        }
        else {
            //Error message?//
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var myDogImage: UIButton!
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        delegate?.saveItem(by: self, name: nameLabel.text!, color: colorLabel.text!, treat: treatLabel.text!, newImage: newimage!, indexPath: index)
        delegate?.cancelItem(by: self)
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelItem(by: self)
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        delegate?.deleteDog(indexPath: index!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
        colorLabel.text = color
        treatLabel.text = treat
        myDogImage.setBackgroundImage(newimage, for: [])

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
