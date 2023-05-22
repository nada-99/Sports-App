//
//  LeaguesCustomCell.swift
//  Sports App
//
//  Created by Nada on 22/05/2023.
//

import UIKit

class LeaguesCustomCell: UITableViewCell {

    @IBOutlet weak var leagueTitle: UILabel!
    @IBOutlet weak var leagueImg: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Make the image view circular
        leagueImg.layer.cornerRadius = leagueImg.bounds.width / 2.9
        leagueImg.clipsToBounds = true
        
        // Add border to the image view
        leagueImg.layer.borderWidth = 1.0
        leagueImg.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
