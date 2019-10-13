//
//  NewsTextViewController.swift
//  NewsReader
//
//  Created by Georgy Khaydenko on 12/10/2019.
//  Copyright © 2019 Georgy Khaydenko. All rights reserved.
//

import UIKit

protocol TextPresenter {
    var textToShow: String { get set }
}

class NewsTextViewController: UIViewController, TextPresenter {

    var textToShow: String = ""
    
    @IBOutlet weak var newsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTextView.text = textToShow
    }
    



}


