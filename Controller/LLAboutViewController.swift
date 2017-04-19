//
//  LLAboutViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/13.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLAboutViewController: BaseViewController {
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        self.titleView.text = "关于"
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
           navigationController?.navigationBar.isHidden = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
