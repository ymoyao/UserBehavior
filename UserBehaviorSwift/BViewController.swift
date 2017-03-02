//
//  BViewController.swift
//  UserBehaviorSwift
//
//  Created by MasterFly on 2017/3/2.
//  Copyright © 2017年 MasterFly. All rights reserved.
//

import UIKit

class BViewController: RootViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "B 的标题"

        let btn = RootButton.init(type: UIButtonType.custom)
        btn.addTarget(self, action: #selector(AViewController.btnClick), for: UIControlEvents.touchUpInside)
        btn.setTitle("点击返回到A", for: UIControlState.normal)
        btn.setTitleColor(UIColor.red, for: UIControlState.normal)
        btn.backgroundColor = UIColor.blue
        btn.frame = CGRect.init(x: 100, y: 100, width: 200, height: 100)
        btn.tag = 101
        self.view.addSubview(btn)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func btnClick() {
        
        print("点击了 \("点击返回到A") 按钮")

        self.navigationController!.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
