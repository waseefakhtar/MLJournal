//
//  DetailViewController.swift
//  MLJournal
//
//  Created by Waseef Akhtar on 7/21/17.
//  Copyright © 2017 Waseef Akhtar. All rights reserved.
//

import UIKit
import DTCoreText

class DetailViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var journalTitle: String!
    var journalSubtitle: String!
    var journalDescription: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar Style
        self.navigationItem.title = journalSubtitle
        
        let htmlText = journalDescription!
        
        /*let content = "<p><b>Welcome</b> to the <a href=\"https://www.apple.com\">Apple Machine Learning</a> Journal.</p> <p>Here, you can read posts written by Apple engineers about their work using machine learning technologies <span> to help build innovative products </span> for millions of people around the world. If you’re a machine learning researcher or student, an engineer or developer, we’d love to hear your questions and feedback. Write us at <a href=\"mailto:machine-learning@apple.com\">machine-learning@apple.com</a></p><p><b>Welcome</b> to the <a href=\"https://www.apple.com\">Apple Machine Learning</a> Journal.</p> <p>Here, you can read posts written by Apple engineers about their work using machine learning technologies <span> to help build innovative products </span> for millions of people around the world. If you’re a machine learning researcher or student, an engineer or developer, we’d love to hear your questions and feedback. Write us at <a href=\"mailto:machine-learning@apple.com\">machine-learning@apple.com</a></p><p><b>Welcome</b> to the <a href=\"https://www.apple.com\">Apple Machine Learning</a> Journal.</p> <p>Here, you can read posts written by Apple engineers about their work using machine learning technologies <span> to help build innovative products </span> for millions of people around the world. If you’re a machine learning researcher or student, an engineer or developer, we’d love to hear your questions and feedback. Write us at <a href=\"mailto:machine-learning@apple.com\">machine-learning@apple.com</a></p><p><b>Welcome</b> to the <a href=\"https://www.apple.com\">Apple Machine Learning</a> Journal.</p> <p>Here, you can read posts written by Apple engineers about their work using machine learning technologies <span> to help build innovative products </span> for millions of people around the world. If you’re a machine learning researcher or student, an engineer or developer, we’d love to hear your questions and feedback. Write us at <a href=\"mailto:machine-learning@apple.com\">machine-learning@apple.com</a></p>"*/
        
        let data:NSData = htmlText.data(using: String.Encoding.utf8)! as NSData
        let options = [NSTextSizeMultiplierDocumentOption: NSNumber.init(value: 1.3),
                       DTUseiOS6Attributes: true, DTDefaultFontFamily: "SF UI Text"] as [String : Any]
        
        let attributedString = NSMutableAttributedString.init(htmlData: data as Data!, options: options, documentAttributes: nil)
        
        // Purely aesthetic, without this the text goes right up to the edge
        textView.contentSize = CGSize(width: textView.frame.size.height, height: textView.contentSize.height)
        textView.showsHorizontalScrollIndicator = false
        textView.attributedText = attributedString
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        if #available(iOS 9.0, *) {
            textView.isScrollEnabled = false
        }
        
        self.textView.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if #available(iOS 9.0, *) {
            textView.isScrollEnabled = true
        }
    }
    
}
