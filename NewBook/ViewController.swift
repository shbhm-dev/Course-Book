//
//  ViewController.swift
//  NewBook
//
//  Created by STARKS on 8/13/18.
//  Copyright © 2018 STARKS. All rights reserved.
//

import UIKit
import  RealmSwift

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var fetchedCourse : Results<Course>?
    let realm = try? Realm()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedCourse?.count{
            return count
        }
        
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let course = fetchedCourse?[indexPath.row]
        cell.textLabel?.text = course?.name
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = fetchedCourse?[indexPath.row]
        performSegue(withIdentifier: "seeall", sender: course)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seeall"{
            if let guest = segue.destination as? AddVC{
                if let course = sender as? Course{
                    guest.existingCourse = course
                }
                
            }
            
            
            
            
            
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let item = fetchedCourse?[indexPath.row] {
            try! realm?.write {
                realm?.delete(item)
            }
        }
     
            tableView.deleteRows(at: [indexPath], with: .fade)
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let realm = try? Realm()
        fetchedCourse = realm?.objects(Course.self).sorted(byKeyPath: "name", ascending: true)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }


}

