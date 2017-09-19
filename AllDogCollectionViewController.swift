//
//  AllDogCollectionViewController.swift
//  MyDogs
//
//  Created by Grant Brooks on 9/18/17.
//  Copyright © 2017 Grant Brooks. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "DogCell"

fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

class AllDogCollectionViewController: UICollectionViewController, EditDogDelegate, AddDogDelegate {
    
    var dogs = [DogItem]()
    
    let MOC = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }

    @IBAction func plusClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddDogSegue", sender: sender)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditDogSegue", sender: indexPath)
        print(indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is IndexPath{
            let navc = segue.destination as! UINavigationController
            let editvc = navc.topViewController as! EditDogViewController
            editvc.delegate = self
            
            let index = sender as! NSIndexPath
            print(index)
            print(index.row)
//            print(dogs[1].name!)

            editvc.name = dogs[(index.row)].name!
            editvc.color = dogs[(index.row)].color!
            editvc.treat = dogs[(index.row)].treat!
            editvc.index = index
            
            let dataOfImage = dogs[(index.row)].image! as NSData
            
            editvc.newimage = UIImage(data: dataOfImage as Data)
            
        }
        else {
            let addvc = segue.destination as! AddDogViewController
            addvc.delegate = self
        }
    }
    
    
    func cancelItem(by: Any){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func fetchAllItems() {
        let request:NSFetchRequest<DogItem> = DogItem.fetchRequest()
        do { dogs = try MOC.fetch(request)}
        catch { print("\(error)") }
    }
    
    func saveItem(by: Any, name: String, color: String, treat: String, newImage: UIImage, indexPath: NSIndexPath?) {
        if let ip = indexPath {
            dogs[ip.row].name = name
            dogs[ip.row].color = color
            dogs[ip.row].treat = treat
            
            let imageData = UIImagePNGRepresentation(newImage)

            dogs[ip.row].image = imageData! as NSData
            
        }
        else {
            if name.characters.count > 0 {
                let dog = DogItem(context: MOC)
                dog.name = name
                dog.color = color
                dog.treat = treat
                
                let imageData = UIImagePNGRepresentation(newImage)
                
                dog.image = imageData! as NSData
            }
        }
        
        do { try MOC.save()}
        catch {print("\(error)")}
        
        fetchAllItems()
        collectionView?.reloadData()
        cancelItem(by: by)
    }
    
    func deleteDog(indexPath: NSIndexPath) {
        MOC.delete(dogs[indexPath.row])
        
        do { try MOC.save()}
        catch {print("\(error)")}
        
        fetchAllItems()
        collectionView?.reloadData()
        cancelItem(by: indexPath)  //indexPath shouldn't be here but I needed to send something bc of how I set it up
    }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dogs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DogCell
    
        // Configure the cell
        let dataOfImage = dogs[(indexPath.row)].image! as NSData
        cell.DogImage.image = UIImage(data: dataOfImage as Data)
        
//        cell.DogImage.image = #imageLiteral(resourceName: "testdog")
        cell.DogLabel.text = dogs[indexPath.row].name!
        
        return cell
        }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
