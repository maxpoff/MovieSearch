//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by Maxwell Poffenbarger on 1/25/20.
//  Copyright © 2020 Poff Daddy. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //MARK: - Properties
    var movie: Movie?
    
    //MARK: - Outlets
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieSummary: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieIDNumber: UILabel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Private Methods
    private func updateViews() {
        guard let movie = movie else {return}
        self.movieName.text = "\(movie.title)"
        self.movieSummary.text = "Summary: \(movie.summary)"
        self.movieReleaseDate.text = "Release Date: \(movie.releaseDate)"
        self.movieIDNumber.text = "Movie Database ID Number: \(movie.id)"
    }
}//End of class
