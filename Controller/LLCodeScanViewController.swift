//
//  LLCodeScanViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/13.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit
import AVFoundation

//二维码
class LLCodeScanViewController: BaseViewController , AVCaptureMetadataOutputObjectsDelegate{
    private var titleLabel = LLBaseLable()
    private var captureSession: AVCaptureSession?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var animationLineView = UIImageView()
    private var timer: Timer?
    
    
    
    private var   result:String?
    override func viewWillAppear(_ animated: Bool) {
         view.backgroundColor = UIColor.white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        buildNavigationItem()
        
        buildInputAVCaptureDevice()
        
        buildFrameImageView()
//
        buildTitleLabel()
//
        buildAnimationLineView()
        // Do any additional setup after loading the view.
    }
    private func buildNavigationItem() {
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.barTintColor = fontcolor
    }
  
    private func buildTitleLabel() {
        
        titleView.text  = "二维码收藏"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.frame = CGRect(x:0, y:340, width:ScreenWidth, height:30)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
    }
    private func buildInputAVCaptureDevice() {
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        titleLabel.text = "将视频二维码对准扫描即可添加到收藏"
        let input = try? AVCaptureDeviceInput(device: captureDevice)
        if input == nil {
            titleLabel.text = "只支持真机额"
            
            return
        }
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession = AVCaptureSession()
        captureSession?.addInput(input!)
        captureSession?.addOutput(captureMetadataOutput)
        let dispatchQueue = DispatchQueue(label: "myquene")
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatchQueue)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode]
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.frame
        view.layer.addSublayer(videoPreviewLayer!)
        captureMetadataOutput.rectOfInterest = CGRect(x:0, y:0, width:1, height:1)
        
        captureSession?.startRunning()

    
    
    }
    private func buildFrameImageView() {
        
        let lineT = [CGRect(x:0, y:0, width:ScreenWidth, height:100),
                     CGRect(x:0, y:100, width:ScreenWidth * 0.2, height:ScreenWidth * 0.6),
                     CGRect(x:0, y:100 + ScreenWidth * 0.6, width:ScreenWidth, height:ScreenHeight - 100 - ScreenWidth * 0.6),
                     CGRect(x:ScreenWidth * 0.8, y:100, width:ScreenWidth * 0.2, height:ScreenWidth * 0.6)]
        for lineTFrame in lineT {
            buildTransparentView(frame: lineTFrame)
        }
        
        let lineR = [CGRect(x:ScreenWidth * 0.2, y:100, width:ScreenWidth * 0.6, height:2),
                     CGRect(x:ScreenWidth * 0.2, y:100, width:2, height:ScreenWidth * 0.6),
                     CGRect(x:ScreenWidth * 0.8 - 2, y:100, width:2, height:ScreenWidth * 0.6),
                     CGRect(x:ScreenWidth * 0.2, y:100 + ScreenWidth * 0.6, width:ScreenWidth * 0.6, height:2)]
        
        for lineFrame in lineR {
            buildLineView(frame: lineFrame)
        }
        
        let yellowHeight: CGFloat = 4
        let yellowWidth: CGFloat = 30
        let yellowX: CGFloat = ScreenWidth * 0.2
        let bottomY: CGFloat = 100 + ScreenWidth * 0.6
        let lineY = [CGRect(x:yellowX, y:100, width:yellowWidth, height:yellowHeight),
                     CGRect(x:yellowX, y:100, width:yellowHeight, height:yellowWidth),
                     CGRect(x:ScreenWidth * 0.8 - yellowHeight, y:100, width:yellowHeight, height:yellowWidth),
                     CGRect(x:ScreenWidth * 0.8 - yellowWidth, y:100, width:yellowWidth, height:yellowHeight),
                     CGRect(x:yellowX, y:bottomY - yellowHeight + 2, width:yellowWidth, height:yellowHeight),
                     CGRect(x:ScreenWidth * 0.8 - yellowWidth, y:bottomY - yellowHeight + 2, width:yellowWidth, height:yellowHeight),
                     CGRect(x:yellowX, y:bottomY - yellowWidth, width:yellowHeight, height:yellowWidth),
                     CGRect(x:ScreenWidth * 0.8 - yellowHeight, y:bottomY - yellowWidth, width:yellowHeight, height:yellowWidth)]
        
        for yellowRect in lineY {
            buildYellowLineView(frame: yellowRect)
        }
    }
    private func buildLineView(frame: CGRect) {
        let view1 = UIView(frame: frame)
        view1.backgroundColor = UIColor.colorWithCustom(230, g: 230, b: 230)
        view.addSubview(view1)
    }
    
    private func buildYellowLineView(frame: CGRect) {
        let yellowView = UIView(frame: frame)
        yellowView.backgroundColor = normalcolor
        view.addSubview(yellowView)
    }
    
    private func buildTransparentView(frame: CGRect) {
        let tView = UIView(frame: frame)
        tView.backgroundColor = UIColor.colorWithCustom(230, g: 230, b: 230)
        tView.alpha = 0.5
        view.addSubview(tView)
    }

    private func buildAnimationLineView() {
        animationLineView.image = UIImage(named: "blackline")
        view.addSubview(animationLineView)
        
        timer = Timer(timeInterval: 4, target: self, selector: #selector(LLCodeScanViewController.startYellowViewAnimation), userInfo: nil, repeats: true)
        let runloop = RunLoop.current
        runloop.add(timer!, forMode: RunLoopMode.commonModes)
        timer!.fire()
    }
    func startYellowViewAnimation() {
        weak var weakSelf = self
        if   weakSelf!.result == nil {
            
            print("没扫到任何结果，可能需要调整位置")
            
            
        }
        
        animationLineView.frame = CGRect(x:ScreenWidth * 0.2 + ScreenWidth * 0.1 * 0.5, y:100, width:ScreenWidth * 0.5, height:2)
        UIView.animate(withDuration:4) { () -> Void in
            weakSelf!.animationLineView.frame.origin.y += ScreenWidth * 0.55
             weakSelf!.animationLineView.alpha = 0.2
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        if   timer != nil {
            timer?.invalidate()
            
            timer = nil
        }
        
    }
    //代理

    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        var stringValue:String?
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
        }
        else{
            
            stringValue = "nil"
        }
        self.captureSession?.stopRunning()
         _ =  SweetAlert().showAlert("扫描结果－" + stringValue!)
        
        
        
        
    }
}
