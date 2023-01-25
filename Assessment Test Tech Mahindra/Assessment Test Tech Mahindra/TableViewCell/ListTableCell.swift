//
//  ListTableCell.swift
//  Assessment Test Tech Mahindra
//
//  Created by USER-MAC-GLIT-007 on 25/01/23.
//

import UIKit

class ListTableCell: UITableViewCell {

    @IBOutlet weak var listTitleLabel: UILabel!
    @IBOutlet weak var listImageView: UIImageView! {
        didSet {
            listImageView.clipsToBounds = true
            listImageView.layer.cornerRadius = listImageView.frame.height / 2
        }
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
