//
//  CoreDataStack.swift
//  CoreMovies
//
//  Created by Jose on 2/6/19.
//  Copyright © 2019 appcat.com. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataStack
{
	let context: NSManagedObjectContext
	let entity: NSEntityDescription
	let movie: NSManagedObject
	let fetchRequest: NSFetchRequest<NSManagedObject>
	
	init()
	{
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		context = appDelegate.persistentContainer.viewContext
		entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)!
		movie = NSManagedObject(entity: entity, insertInto: context)
		fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
		fetchRequest.includesPendingChanges = false
	}
}
