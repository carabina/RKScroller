//
//  ViewController.swift
//  RKScroller
//
//  Created by tahseen0amin@gmail.com on 06/05/2017.
//  Copyright (c) 2017 tahseen0amin@gmail.com. All rights reserved.
//

import UIKit
import RKScroller

class ViewController: UIViewController {
    
    
    var scroller : RKHorizontalScroller {
        get {
            return self.view as! RKHorizontalScroller
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let additem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addOne))
        self.navigationItem.rightBarButtonItem = additem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addOne() {
        self.scroller.setting.itemSize = CGSize.init(width: 300, height: 400)
        scroller.bounces = true
        let page = UIView.init(frame: self.view.frame)
        page.backgroundColor = UIColor.random()
        self.scroller.addItem(item: page)
    }
    
}


extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   CGFloat(arc4random()) / CGFloat(UInt32.max),
                       green: CGFloat(arc4random()) / CGFloat(UInt32.max),
                       blue:  CGFloat(arc4random()) / CGFloat(UInt32.max),
                       alpha: 1.0)
    }
}

