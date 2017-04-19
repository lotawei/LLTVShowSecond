//
//  IndexTittleView.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/12.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class IndexTittleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var    model:LLWeatherInfo!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var weatherimg: UIImageView!
    @IBOutlet weak var disc: UILabel!
    
    static    func   shareview() ->  IndexTittleView {
        
        let   ainfoview = Bundle.main.loadNibNamed("IndexTittleView", owner: nil, options: nil)?.first  as! IndexTittleView
        return  ainfoview
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    func   setinfo(_ amodel:LLWeatherInfo){
        
        temp.text = amodel.temp1
        disc.text = amodel.wetherdisc
        area.text = amodel.city
        weatherimg.image  = UIImage(named: amodel.img1)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


}
