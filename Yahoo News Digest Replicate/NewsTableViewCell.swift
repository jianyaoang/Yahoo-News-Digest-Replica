//
//  NewsTableViewCell.swift
//  Yahoo News Digest Replicate
//

//  Copyright (c) 2015 JayAng. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var newsCategory: UILabel!
    @IBOutlet var newsTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.newsTitle.textColor = UIColor.blackColor()
        self.newsTitle.numberOfLines = 0
        self.newsTitle.sizeToFit()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
