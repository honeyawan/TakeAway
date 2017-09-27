//
//  TARestaurantTableViewCell.swift
//  TakeAway
//
//  Created by Haneef Habib on 9/26/17.
//  Copyright © 2017 TakeAway. All rights reserved.
//

import UIKit

@objc protocol TARestaurantCellFavouriteDelegate : NSObjectProtocol {
    func restaurantCellPressedFavourite(_ isFavourite : Bool, atIndex index:Int)
}

class TARestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var lblStatus: UILabel!
    var index = -1
    weak var delegate : TARestaurantCellFavouriteDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func onBtnFavourite() {
        btnFavourite.isSelected = !btnFavourite.isSelected
        if let delegateObject = delegate {
            delegateObject.restaurantCellPressedFavourite(btnFavourite.isSelected, atIndex: index)
        }
    }

}
