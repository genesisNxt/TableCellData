//
//  CustomCell.swift
//  TableCellData
//
//  Created by PARMJIT SINGH KHATTRA on 30/5/20.
//  Copyright © 2020 PARMJIT SINGH KHATTRA. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    
    @IBOutlet weak var myCell: CustomCell!
    
    @IBOutlet weak var colour: UIButton!
    
    @IBOutlet weak var data: UIButton!
    @IBAction func changeColour(_ sender: UIButton) {
        //colour.backgroundColor = .systemGreen
        
    }
    
    
    //static let identifier = "MyTableViewCell"
    
//    static func nib() -> UINib {
//        return UINib(nibName: "MyTableViewCell", bundle: nil)
//    }
//    public func configure(with title: String, image Name: string){
//        my
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
