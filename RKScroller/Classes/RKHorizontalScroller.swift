//
//  RKHorizontalScroller.swift
//  DemoScrolling
//
//  Created by ramesh on 5/31/17.
//  Copyright © 2017 ramesh. All rights reserved.
//

import UIKit

protocol HorizontalScrollerDelegate {
    func itemDidAppear(page:UIView)
}

public struct ScrollerSetting {
    var minimumLeftPadding = 0.0 as CGFloat
    var minimumRightPadding = 0.0 as CGFloat
    var minimumTopPadding = 0.0 as CGFloat
    var minimumBottomPadding = 0.0 as CGFloat
    var seperatorWidth = 0.0 as CGFloat
    var seperatorColor: UIColor?
    var numberOfPagesPerScreen = 1
    public var itemSize = CGSize.init(width: 100.0, height: 100.0)
    var keepItemInCenter = true
}

open class RKHorizontalScroller: UIScrollView, UIScrollViewDelegate {
    
    var scrollerDelegate: HorizontalScrollerDelegate?
    open var setting = ScrollerSetting()
    open var currentIndex: Int {
        get {
            return Int(self.contentOffset.x/scrollSize.width)
        }
    }
    open var totalItems: Int {
        get{
            return items.count
        }
    }
    open var scrollSize: CGSize {
        get {
            return self.frame.size
        }
    }
    
    internal var items = [UIView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    open override func awakeFromNib() {
        self.commonInit()
    }
    
    private func commonInit() {
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.bounces = false
        self.isPagingEnabled = true
        self.delegate = self
    }
    
    public func addItem(item:UIView) {
        item.frame = self.calculateFrame(idx: totalItems)
        self.addSubview(item)
        self.items.append(item)
        self.contentSize = CGSize.init(width: self.scrollSize.width*CGFloat(totalItems),
                                       height: self.scrollSize.height)
    }
    func addItems(items:[UIView]) {
        for item in items {
            self.addItem(item: item)
        }
    }
    func removeAllItems() {
        for item in items.reversed() {
            item.removeFromSuperview()
        }
        items = []
    }
    
    //MARK: Private functions
    private func calculateFrame(idx:Int) -> CGRect {
        let rect = CGRect.init(x: leftPadding(idx: idx), y: topPadding(), width: setting.itemSize.width, height: setting.itemSize.height)
        return rect
    }
    
    private func leftPadding(idx:Int)->CGFloat {
        let maxPadding = (self.scrollSize.width/2.0 - setting.itemSize.width/2.0)+CGFloat(idx)*self.scrollSize.width
        return maxPadding < setting.minimumLeftPadding ? setting.minimumLeftPadding : maxPadding
    }
    private func topPadding()->CGFloat {
        let maxPadding = self.scrollSize.height/2.0 - setting.itemSize.height/2.0
        return maxPadding < setting.minimumTopPadding ? setting.minimumTopPadding : maxPadding
    }

    
    //MARK: Scrolling
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset
        let page = Int(offSet.x/scrollSize.width)
        self.scrollerDelegate?.itemDidAppear(page: items[page])
    }
    
    
}
