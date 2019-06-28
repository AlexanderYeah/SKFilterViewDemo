//
//  ViewController.swift
//  SKSideFilterView
//
//  Created by coder on 2019/6/28.
//  Copyright © 2019 AlexanderYeah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        

        
        
    }
    
    
    @IBAction func showAction(_ sender: UIButton) {
        
        let view = UINib.init(nibName: "SKFilterEdgeView", bundle: nil).instantiate(withOwner: self, options: nil).last as! SKFilterEdgeView;
        view.type = 0;
        self.view.frame = CGRect(x: 0, y: 0, width:self.view.frame.width, height: self.view.frame.height);
        view.setBackClosure {
            view.removeFromSuperview();
        }
        self.view.addSubview(view);
        
    }
    
    


}

