//
//  TeamTableViewCell.swift
//  Sports App
//
//  Created by Nada on 23/05/2023.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memberImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
