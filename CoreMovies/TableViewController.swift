//
//  TableViewController.swift
//  CoreMovies
//
//  Created by Jose on 20/5/19.
//  Copyright © 2019 appcat.com. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController
{
	var movies: [String] = []
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		title = "Top 10 All-time Movies"
    }
	
	// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int
	{
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = movies[indexPath.row]
        return cell
    }

    // MARK: - Navigation
	@IBAction func unwindFromAddMovieVC(segue: UIStoryboardSegue)
	{
		self.movies.append(contentsOf: (segue.source as! AddMovieViewController).movies)
		tableView.reloadData()
	}

}
