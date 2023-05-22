//
//  UpComingCell.swift
//  Sports App
//
//  Created by Nada on 22/05/2023.
//

import UIKit

class UpComingCell: UICollectionViewCell {
    
    @IBOutlet weak var awayTeamTitle: UILabel!
    @IBOutlet weak var awayTeamImg: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var homeTeamTitle: UILabel!
    @IBOutlet weak var homeTeamImg: UIImageView!
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
            // Apply rounded corners
            layer.cornerRadius = 30
            
            // Add border
            layer.borderWidth = 1.0
            layer.borderColor = UIColor.lightGray.cgColor
        }
}
