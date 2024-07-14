//
//  ViewController.swift
//  codeDataP
//
//  Created by bloom on 7/13/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
        createData(name: "kim", phoneNumber: "010-4125-9024")
        updateData(currentName: "kim", updateName: "Lee")
        deleteData(name: "Lee")
        readAllData()
        
        
    }
    
    func createData(name: String, phoneNumber: String) { //crud 에서의 c
        guard let entity = NSEntityDescription.entity(forEntityName: PhoneBook.className, in: self.container.viewContext) else {
            print("x")
            return }
        
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newPhoneBook.setValue(name, forKey: PhoneBook.Key.name)
        newPhoneBook.setValue(phoneNumber, forKey: PhoneBook.Key.phoneNumber)
        
        do {
            try self.container.viewContext.save()
            print("문맥 저장성공")
        } catch {
            print("문맥 저장실패")
        }
    }
    
    func readAllData(){ //crud에서 의 r
        do{
            let phoneBooks = try self.container.viewContext.fetch(PhoneBook.fetchRequest())
            
            for phoneBook in phoneBooks as [NSManagedObject] {
                if let name = phoneBook.value(forKey: PhoneBook.Key.name) as? String,
                   let phoneNummber = phoneBook.value(forKey: PhoneBook.Key.phoneNumber) as? String {
                    print("name: \(name) phoneNumber: \(phoneNummber)")
                }
                
            }
        }
        catch{
            print("데이터 읽기 실패 ")
        }
    }
    
    func updateData(currentName: String, updateName: String) {
        
        let fetchRequest = PhoneBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", currentName)
        do {
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            for data in result as [NSManagedObject] {
                
                data.setValue(updateName, forKey: PhoneBook.Key.name)
            }
            
            try self.container.viewContext.save()
            
            
        } catch {
            print("데이터 변경 실패")
        }
    }
    
    func deleteData(name: String) {
        
        let fetchRequest = PhoneBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            for data in result as [NSManagedObject] {
                self.container.viewContext.delete(data)
            }
            try self.container.viewContext.save()
         print("데이터 삭제 성공 ")
        }
        catch{
            print("데이터 삭제 실패 ")
        }
        
    }
    
    
    
    
}

