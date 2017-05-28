//
//  ViewController_TT_Weather.swift
//  How is the weather today
//
//  Created by kpugame on 2017. 5. 24..
//  Copyright © 2017년 LEESEUL. All rights reserved.
//

import UIKit

class ViewController_WO_Weather: UIViewController, XMLParserDelegate
{
    
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var main = NSMutableString()
    var date = NSMutableString()
    
    var imageurl = NSMutableString()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.beginParsing()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf:(URL(string:"api.openweathermap.org/data/2.5/forecast?id=1835848&appid=7d872044b2fa580d43b45a2e4bf536a3&mode=json"))!)!
        parser.delegate = self
        parser.parse()
        
        tbData!.reloadData()
    }
    
    //XMLParser Methods
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "weather")
        {
            elements = NSMutableDictionary()
            elements = [:]
            main = NSMutableString()
            main = ""
            date = NSMutableString()
            date = ""
            
            imageurl = NSMutableString()
            imageurl = ""
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "weather") {
            if !main.isEqual(nil) {
                elements.setObject(main, forKey: "main" as NSCopying)
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "date" as NSCopying)
            }
            if !imageurl.isEqual(nil) {
                elements.setObject(imageurl, forKey: "imageurl" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "weather.main") {
            main.append(string)
        } /* else if element.isEqual(to: "origNm") {
            date.append(string)
        } else if element.isEqual(to: "jpgLink") {
            imageurl.append(string)
        } */
    }
    
    //Tableview Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TT_Weather")!
        
        if(cell.isEqual(NSNull)) {
            cell = Bundle.main.loadNibNamed("TT_Weather", owner: self, options: nil)?[0] as! UITableViewCell;
        }
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "main") as! NSString as String
        /*
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "time.from") as! NSString as String

        if let url = URL(string: (posts.object(at: indexPath.row) as AnyObject).value(forKey: "imageurl") as! NSString as String)
        {
            if let data = try? Data(contentsOf: url)
            {
                cell.imageView!.image = UIImage(data: data)
            }
        } */
        
        return cell as UITableViewCell
    }
}
