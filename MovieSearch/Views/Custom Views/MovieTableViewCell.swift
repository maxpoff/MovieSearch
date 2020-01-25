//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Maxwell Poffenbarger on 1/24/20.
//  Copyright © 2020 Poff Daddy. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
        
    //MARK: - Outlets
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieSummaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Private Methods
    private func updateViews() {
        guard let movie = movie else {return}
        movieTitleLabel.text = movie.title
        movieRatingLabel.text = "\(movie.rating)"
        movieSummaryLabel.text = movie.summary
        MovieController.FetchMovieImage(movie: movie) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.moviePosterImage.image = image
                case .failure(let error):
                    self.moviePosterImage.image = UIImage(named: "defaultPosterImage")
                    print(error, error.localizedDescription)
                }
            }
        }
    }
}//End of class
