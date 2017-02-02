//
//  NewsCell.swift
//  YOLO
//
//  Created by Kiril on 16.09.16.
//  Copyright © 2016 Kiril. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var lNameNews: UILabel!
    @IBOutlet weak var imImageNews: UIImageView!
    @IBOutlet weak var tvAboutNews: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
