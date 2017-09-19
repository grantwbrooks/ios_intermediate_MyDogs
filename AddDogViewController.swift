//
//  AddDogViewController.swift
//  MyDogs
//
//  Created by Grant Brooks on 9/18/17.
//  Copyright © 2017 Grant Brooks. All rights reserved.
//

import UIKit

class AddDogViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var delegate: AddDogDelegate?
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var colorLabel: UITextField!
    @IBOutlet weak var treatLabel: UITextField!
    var newimage: UIImage?

    
    
    @IBAction func photofromCamera(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.camera
        image.allowsEditing = false
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    
    
    
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
    
    
    @IBAction func addClicked(_ sender: UIButton) {
        delegate?.saveItem(by: self, name: nameLabel.text!, color: colorLabel.text!, treat: treatLabel.text!, newImage: newimage!, indexPath: nil)
        delegate?.cancelItem(by: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newimage = #imageLiteral(resourceName: "testdog")
        myDogImage.setBackgroundImage(newimage, for: [])
        self.hideKeyboardWhenTappedAround()


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


extension UIViewController {
    // be sure to put this function in every viewController viewDidLoad if you want taps outside UIObject to close keyboard
    // on this one I also added a endEditing to the date picker so if you change values on that it closes keyboard.
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.  this can interfere with didSelectRowAtIndexPath so add below line to stop interference.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
