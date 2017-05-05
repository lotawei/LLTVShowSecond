//
//  LLFullLandScreenViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/27.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLFullLandScreenViewController: UIViewController,BMPlayerDelegate {

    
    var player:BMPlayer!
    
    var  vidopath:String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.player = BMPlayer(customControllView: BMPlayerCustomControlView())
        self.player.delegate = self
        self.view.addSubview(self.player)
        player.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(-kNavigationBarH)
            make.width.equalTo(view)
            make.height.equalTo(view)
            make.left.equalTo(view.snp.left)
            
        }
        player.delegate = self
        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true {
                
                
                return
            }
            let _ = self.navigationController?.popViewController(animated: true)
        }
        
        let  path = URL.init(fileURLWithPath: self.vidopath)
        let res1 = BMPlayerResource(url: path)
        
        player.setVideo(resource: res1)
        player.autoPlay()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func bmPlayer(player: BMPlayer ,playerStateDidChange state: BMPlayerState)
    {
        
    }
    func bmPlayer(player: BMPlayer ,loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval){
        
    }
    func bmPlayer(player: BMPlayer ,playTimeDidChange currentTime : TimeInterval, totalTime: TimeInterval){
        
    }
    func bmPlayer(player: BMPlayer ,playerIsPlaying playing: Bool){
        
    }

}
