//
//  TeamCollectionViewCell.swift
//  Sports App
//
//  Created by Nada on 23/05/2023.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamTitle: UILabel!
    @IBOutlet weak var teamImg: UIImageView!
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
        layer.cornerRadius = 20
            
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
    }
}
