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
	let fetchRequest: NSFetchRequest<NSManagedObject>
	let fetchController: NSFetchedResultsController<NSManagedObject>
	
	init()
	{
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		context = appDelegate.persistentContainer.viewContext
		entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)!
		fetchRequest = NSFetchRequest(entityName: "Movie")
		fetchRequest.sortDescriptors = []
		fetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
		
		//fetchRequest.includesPendingChanges = false
		//fetchRequest.returnsObjectsAsFaults = false
		//let predicate = NSPredicate(format: "name != nil")
		//fetchRequest.predicate = predicate
	}
}
