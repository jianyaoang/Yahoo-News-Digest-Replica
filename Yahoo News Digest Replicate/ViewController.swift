//
//  ViewController.swift
//  Yahoo News Digest Replicate
//

//  Copyright (c) 2015 JayAng. All rights reserved.
//

import UIKit

private let kTableHeightHeader: CGFloat = 400
private let kTableToBeCutOff: CGFloat = 70

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    @IBOutlet var bigHeaderImageView: UIImageView!
    @IBOutlet var newsTableView: UITableView!
    @IBOutlet var dateLabel: UILabel!

    
    var tableHeaderView: UIView!
    var tableHeaderMaskToBeVisible: CAShapeLayer!
    var newsArray = [News]()
    var arrayCheckCellHasLoaded = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatingSampleNews()
        stylingDateLabel()
        configureNewsTable()
        updatingTableHeaderView()
        
        self.arrayCheckCellHasLoaded = [Bool](count: self.newsArray.count, repeatedValue: false)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func creatingSampleNews() {
        
        let news1 = News(newsTitle: "Google apologises after photo app labels couple Gorillas", newsCategory: "Technology")
        let news2 = News(newsTitle: "'Steve Jobs' trailer shows a different side of Apple co-founder's genius", newsCategory: "Entertainment")
        let news3 = News(newsTitle: "Chelsea takes English Premier League title", newsCategory: "Sports")
        let news4 = News(newsTitle: "Shares falls as Euro plunges", newsCategory: "Business")
        let news5 = News(newsTitle: "SpaceX failure shows that we need more commercial space travel", newsCategory: "Science")
        let news6 = News(newsTitle: "Mac Rumor: Apple installs finger print detector on MacBooks", newsCategory: "Technology")
        let news7 = News(newsTitle: "Eclipse mints release new Blackcurrent flavor", newsCategory: "World")
        let news8 = News(newsTitle: "Aetna and Humana close to multi-billion dollar deal", newsCategory: "Finance")
        
        newsArray = [news1, news2, news3, news4, news5, news6, news7, news8]
        
    }
    
    func stylingDateLabel() {
        
        self.dateLabel.text = "July 5"
        self.dateLabel.font = UIFont(name: "HelveticaNeue", size: 30)
        self.dateLabel.textColor = UIColor.whiteColor()
    }
    
    //MARK: table
    func configureNewsTable() {
    
        self.bigHeaderImageView.image = UIImage(named: "mac")
        
        self.tableHeaderView = self.newsTableView.tableHeaderView!
        self.newsTableView.tableHeaderView = nil
        self.newsTableView.addSubview(self.tableHeaderView)
        self.newsTableView.sendSubviewToBack(self.tableHeaderView)
        
        self.newsTableView.contentInset = UIEdgeInsetsMake(kTableHeightHeader, 0, 0, 0)
        self.newsTableView.contentOffset = CGPoint(x: 0, y: -kTableHeightHeader)
        
    }
    
    func updatingTableHeaderView() {
        var newsHeaderTableRect = CGRect(x: 0, y: -kTableHeightHeader, width: self.view.frame.size.width, height: kTableHeightHeader)
        
        if self.newsTableView.contentOffset.y < -kTableHeightHeader {
            newsHeaderTableRect.origin.y = self.newsTableView.contentOffset.y
            newsHeaderTableRect.size.height = -self.newsTableView.contentOffset.y
        }
        
        self.tableHeaderView.frame = newsHeaderTableRect
        
        visiblePortionOfNewsTableHeader(newsHeaderTableRect: newsHeaderTableRect)
    }
    
    func visiblePortionOfNewsTableHeader(#newsHeaderTableRect: CGRect) {
        
        self.tableHeaderMaskToBeVisible = CAShapeLayer()
        self.tableHeaderMaskToBeVisible.fillColor = UIColor.blackColor().CGColor
        self.tableHeaderView.layer.mask = self.tableHeaderMaskToBeVisible
        
        let trapeziumHeaderMask = UIBezierPath()
        trapeziumHeaderMask.moveToPoint(CGPointMake(0, 0))
        trapeziumHeaderMask.addLineToPoint(CGPointMake(newsHeaderTableRect.width, 0))
        trapeziumHeaderMask.addLineToPoint(CGPointMake(newsHeaderTableRect.width, newsHeaderTableRect.height))
        trapeziumHeaderMask.addLineToPoint(CGPointMake(0, newsHeaderTableRect.height - kTableToBeCutOff))
        self.tableHeaderMaskToBeVisible.path = trapeziumHeaderMask.CGPath
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let newsItem = newsArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("NewsCell") as! NewsTableViewCell
        cell.newsCategory.text = newsItem.newsCategory
        cell.newsTitle.text = newsItem.newsTitle
        
        if indexPath.row % 2 == 0 {
            cell.newsCategory.textColor = UIColor.orangeColor()
        } else {
            cell.newsCategory.textColor = UIColor.purpleColor()
        }

        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.arrayCheckCellHasLoaded[indexPath.row] == false {
            cell.alpha = 0
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                cell.alpha = 1

            });
            self.arrayCheckCellHasLoaded[indexPath.row] = true
        }
    }
    
    //MARK: ScrollView
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        updatingTableHeaderView()
      
    }

    
}

