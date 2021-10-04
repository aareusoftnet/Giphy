//
//  ParentMO.swift
//  Giphy
//

import CoreData

//MARK: - NSManagedObject
extension NSManagedObject {
    
    class func entityName() -> String {
        return "\(self.classForCoder())"
    }
    
    class func deleteRemovedObject(oldObjs: [NSManagedObject], newObjs:[NSManagedObject]){
        var setOld = Set(oldObjs)
        let setNew = Set(newObjs)
        
        setOld.subtract(setNew)
        
        for obj in setOld {
            (AppConfig.appDelegate as! AppDelegate).persistentContainer.viewContext.delete(obj)
        }
        
        (AppConfig.appDelegate as! AppDelegate).saveContext()
    }
}

//MARK: - Protocol ParentMO
protocol ParentMO {
    
}

extension ParentMO where Self: NSManagedObject {

    /// It will create a new entity in database by passing its name.
    /// - Returns: It will return **NSManagedObject** object.
    static func createNewEntity() -> Self {
        let object = NSEntityDescription.insertNewObject(forEntityName: Self.entityName(), into: (AppConfig.appDelegate as! AppDelegate).persistentContainer.viewContext) as! Self
        return object
    }

    /// It will return new or existing **NSEntityDescription** object.
    /// - Parameters:
    ///   - key: Key name to check entitiy exists or not.
    ///   - value: Unique value which is represent entity.
    /// - Returns: It will return **NSEntityDescription** object.
    static func getEntity(_ key: String, value: String) -> Self {
        if let existingEntity = getExistingEntity(key, value: value) {
            return existingEntity
        }else{
            return createNewEntity()
        }
    }
    
    /// It will return an exsiting entity from database.
    ///
    /// - Parameters:
    ///   - key: Unique key name to identify record
    ///   - value: Unique valu to identify record
    /// - Returns: It will return exiting entity
    static func getExistingEntity(_ key: String, value: String) -> Self? {
        return fetchDataFromEntity(predicate: NSPredicate(format: "%K = %@", key, value), sortDescs: nil).first
    }

    /// It will return **NSEntityDescription** optional value, by passing entity name.
    /// - Returns: Represent **NSEntityDescription** object.
    static func getExisting() -> NSEntityDescription? {
        let entityDesc = NSEntityDescription.entity(forEntityName: Self.entityName(), in: (AppConfig.appDelegate as! AppDelegate).persistentContainer.viewContext)
        return entityDesc
    }
    
    /// It is class method.
    /// It will delete all records from the entity
    /// It is access directly using NSManagedObject class name.
    static func deleteAllRecords() {
        let entityDesc = getExisting()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entityDesc
        do {
            let resultsObj = try (AppConfig.appDelegate as! AppDelegate).persistentContainer.viewContext.fetch(fetchRequest)
            for object in resultsObj as! [Self] {
                (AppConfig.appDelegate as! AppDelegate).persistentContainer.viewContext.delete(object)
            }
            (AppConfig.appDelegate as! AppDelegate).saveContext()
        } catch let error as NSError {
            print(#function + " : " + error.localizedDescription)
        }
    }

    /// It will return an array of existing values from given entity name, with peredicate and sort description.
    /// - Parameters:
    ///   - pagination: Represent **APIPagination** object.
    ///   - predicate: Represent **NSPredicate** object.
    ///   - sortDescs: Represent **NSArray** object.
    /// - Returns: Collection **NSManagedObject** objects.
    static func fetchDataFromEntity(_ pagination: APIPagination? = nil, predicate: NSPredicate? = nil, sortDescs: NSArray? = nil)-> [Self] {
        //let entityDesc = getExisting()
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: Self.entityName())
        if let pagination = pagination {
            fetchRequest.fetchLimit = pagination.limit
            fetchRequest.fetchOffset = pagination.offSet
        }
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        if let sortDescs = sortDescs {
            fetchRequest.sortDescriptors = sortDescs as? Array
        }
        
        do {
            let resultsObj = try (AppConfig.appDelegate as! AppDelegate).persistentContainer.viewContext.fetch(fetchRequest)
            if (resultsObj as! [Self]).count > 0 {
                return resultsObj as! [Self]
            }else{
                return []
            }
            
        } catch let error as NSError {
            print("Error in fetchedRequest : \(error.localizedDescription)")
            return []
        }
    }
}
