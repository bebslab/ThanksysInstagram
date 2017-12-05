//
//  tabbarVC.swift
//  InstagramThanksys
//
//  Created by Hubert LABORDE on 29/11/2017.
//  Copyright © 2017 Hubert LABORDE. All rights reserved.
//

import UIKit

// global variables of icons

class tabbarVC: UITabBarController {
    
    lazy var leftBarItem = { () -> UIBarButtonItem in
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.tintColor = .white
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let item = UIBarButtonItem(customView: btn)
        return item
    }()
    
    lazy var rightBarItem = { () -> UIBarButtonItem in
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "forward")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.tintColor = .white
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let item = UIBarButtonItem(customView: btn)
        return item
    }()
    
    // default func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
        customButtonUpload()
        setupUINavBar()
    }
    
    func setupTabbar(){
        // color of item
        self.tabBar.tintColor = .white
        // color of background
        self.tabBar.barTintColor = UIColor(red: 37.0 / 255.0, green: 39.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)
        // disable translucent
        self.tabBar.isTranslucent = false
        //select search vc
        self.selectedIndex = 1
        self.removeTabbarItemsText()
    }
    
    func setupUINavBar() {
        self.navigationController?.navigationBar.topItem?.title = "#limonade".uppercased()
        // color of title at the top in nav controller
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        // color of buttons in nav controller
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 18.0 / 255.0, green: 86.0 / 255.0, blue: 136.0 / 255.0, alpha: 1)
        //back button
        self.navigationItem.leftBarButtonItem = leftBarItem
        //forward button
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func customButtonUpload(){
        // custom button
        let itemWidth = self.view.frame.size.width / 5
        let itemHeight = self.tabBar.frame.size.height
        let button = UIButton(frame: CGRect(x: itemWidth * 2, y: self.view.frame.size.height - itemHeight, width: itemWidth - 10, height: itemHeight))
        button.setBackgroundImage(UIImage(named: "upload"), for: .normal)
        button.adjustsImageWhenHighlighted = false
        self.view.addSubview(button)
    }
    
}

extension UITabBarController {
    func removeTabbarItemsText() {
        tabBar.items?.forEach {
            $0.title = ""
            $0.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
}
