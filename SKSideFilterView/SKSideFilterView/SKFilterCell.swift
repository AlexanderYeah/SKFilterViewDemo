//
//  SKFilterCell.swift
//  SKSideFilterView
//
//  Created by coder on 2019/6/28.
//  Copyright © 2019 AlexanderYeah. All rights reserved.
//

import UIKit

class SKFilterCell: UICollectionViewCell {
    
    
    @IBOutlet weak var selectedImgView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    
    //
    var model:SKFilterModel?{
        
        didSet{
            
            self.titleLbl.text = model!.title!;
            
            self.selectedImgView.isHidden = true;
            self.titleLbl.textColor = UIColor.init(red: 153/255, green: 153/255, blue: 153/255, alpha: 1);
            self.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1);
            
            if model!.isSelected! {
                
                self.selectedImgView.isHidden = false;
                self.titleLbl.textColor = UIColor.init(red: 56/255, green: 160/255, blue: 255/255, alpha: 1);
                self.backgroundColor = UIColor.init(red: 225/255, green: 241/255, blue: 255/255, alpha: 1);
            }                        
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
