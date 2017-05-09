//
//  LLResultItemCell.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/24.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLResultItemCell: UITableViewCell {
    
    fileprivate var  itemdata:LLCategoryRecItem!
    

    @IBOutlet weak var postimg: UIImageView!
    
    @IBOutlet weak var lbname: UILabel!
    
    @IBOutlet weak var lbldirector: UILabel!
    
    @IBOutlet weak var lblyear: UILabel!
    
    @IBOutlet weak var lblscore: UILabel!
    
    @IBOutlet weak var bottomview: UIView!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.clear
        contentView.backgroundColor = tablelightcolor
        bottomview.gradient(UIColor.white, endcolor: fontcolor)
        
        
    }
    func   setitem(_ item:LLCategoryRecItem){
         self.itemdata = item
          postimg.kf.setImage(with: URL(string:item.item_icon1) , placeholder: UIImage(named:"cellimgpalcehold"), options:  [KingfisherOptionsInfoItem.transition(ImageTransition.fade(1)), KingfisherOptionsInfoItem.forceRefresh], progressBlock: nil, completionHandler: nil)
        
          lbname.text = item.item_title
          lbldirector.text = item.displaydirector()
           lblyear.text = item.item_year
           lblscore.text = item.item_score
        
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}

