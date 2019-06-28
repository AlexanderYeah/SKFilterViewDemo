//
//  SKFilterEdgeView.swift
//  SKSideFilterView
//
//  Created by coder on 2019/6/28.
//  Copyright © 2019 AlexanderYeah. All rights reserved.
//

import UIKit


// 屏幕的宽高
let screenWidth = UIScreen.main.bounds.size.width;
let screenHeight = UIScreen.main.bounds.size.height;

// iPhoneXR
let iPhoneXR:Bool = __CGSizeEqualToSize(CGSize(width: 828, height: 1792), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));

// iPhoneX
let iPhoneX:Bool = __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));


// iPhoneXSMAX
let iPhoneXSMAX:Bool = __CGSizeEqualToSize(CGSize(width: 1242, height: 2688), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));




// 判断是否是X系列的
let is_X_Seris:Bool = iPhoneXR || iPhoneXSMAX || iPhoneX;

class SKFilterEdgeView: UIView {
    
    // 黑色背景视图
    @IBOutlet weak var blackView: UIView!
    
    // 白色liveView
    @IBOutlet weak var whiteLiveView: UIView!
    // 标题
    @IBOutlet weak var titleLbl: UILabel!
    
    // 标题上边的约束
    @IBOutlet weak var titleTopConstraint: NSLayoutConstraint!
    
    // 间隔的约束
    @IBOutlet weak var sepViewTopConstraint: NSLayoutConstraint!
    
    
    // btnView 的底部约束        
    @IBOutlet weak var btnBottomCostraint: NSLayoutConstraint!
    
    // collectiomView
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 返回的操作
    
    var backClosure:(()->Void)?;
    
    
    func setBackClosure(temp:@escaping (()->Void)){
        self.backClosure  = temp;
    }
    
    // var
    
    var type:NSInteger?{
        
        didSet{
            
            if type == 0{
                loadData();
                
                // 做一个划入的动画
                
                self.backgroundColor = UIColor.black.withAlphaComponent(0);
            
                self.whiteLiveView.frame = CGRect(x: screenWidth, y: 0, width: self.whiteLiveView.frame.width, height: self.whiteLiveView.frame.height);
                
                UIView.animate(withDuration: 0.3) {
                    self.backgroundColor = UIColor.black.withAlphaComponent(0.5);
                    self.whiteLiveView.frame = CGRect(x: 0, y: 0, width: self.whiteLiveView.frame.width, height: self.whiteLiveView.frame.height);
                };
            }
        }
    }
    
    
    // 模型数组
    var modelArr = [[SKFilterModel]]();
    
    
    override func awakeFromNib() {
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5);
        self.blackView.backgroundColor = UIColor.white.withAlphaComponent(0);
        
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick));
        tap.numberOfTapsRequired = 1;
        self.blackView.isUserInteractionEnabled = true;
        self.blackView.addGestureRecognizer(tap);
        
        
      
        createUI();
    }
    
    
    // MARK:0 设置UI
    func createUI() {
        
        if is_X_Seris {
            self.titleTopConstraint.constant = 44;
            self.sepViewTopConstraint.constant = 84;
            self.btnBottomCostraint.constant = 34;
        }
        
        
        
        let layout = UICollectionViewFlowLayout.init();
        layout.scrollDirection = .vertical;
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.collectionViewLayout = layout;
        self.collectionView.backgroundColor = UIColor.white;
        self.collectionView.register(UINib.init(nibName: "SKFilterCell", bundle: nil), forCellWithReuseIdentifier: "SKFilterCell");
        
        
        self.collectionView.register(UINib.init(nibName: "SKFilterHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SKFilterHeaderView");
        
        self.collectionView.register(UINib.init(nibName: "SKFilterFooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SKFilterFooterView");
        
        
        
    }
    // MARK:1 数据加载
    // 可以根据类型的不同 加载不同的内容
    func loadData()  {
        
        let contentArr = [["选择客户"], ["全款", "月结", "货到付款", "付定到清"], ["已结清", "未结清"], ["自提", "送货", "第三方物流"], ["上午8点", "上午9点","上午10点","上午11点","上午12点","下午1点","下午2点","下午3点","下午4点","下午5点","下午6点"], ["周一", "周二","周三", "周四","周五", "周六","周日"]];
        
        let headerArr = ["选择客户", "结算方式", "结算状态", "送货方式", "下单时间", "送货日期"];
        
        
        for i in 0 ..< headerArr.count {
            
            let headerStr = headerArr[i];
            let sectionArr = contentArr[i];
            var subArr = [SKFilterModel]();
            
            for j in 0 ..< sectionArr.count{
                
                let model = SKFilterModel();
                model.name = headerStr;
                model.title = sectionArr[j];
                model.isSelected = false;
                subArr.append(model);
            }
            
            self.modelArr.append(subArr);
            
        }
        
        
        self.collectionView.reloadData();
        
        
        
    }
    
    // MARK:2 事件响应
    @objc func tapClick() {
 
        self.backAction();
    }
    
    
    
    
    // MARK:3 懒加载
    
    // 重置按钮的点击
    @IBAction func resetBtnClick(_ sender: UIButton) {
        
        for i in 0 ..< self.modelArr.count {

            let sectionArr = self.modelArr[i];
            for j in 0 ..< sectionArr.count{
                let model = sectionArr[j];
                model.isSelected = false;
            }
        }
        
        self.collectionView.reloadData();
        
    }
    // 确认按钮的点击 循环遍历将结果返回即可
    @IBAction func ensureBtnClick(_ sender: UIButton) {
        
        
    }
    
    // MARK:4 方法抽取
    func backAction() {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0);
            self.whiteLiveView.frame = CGRect(x: screenWidth, y: 0, width: self.whiteLiveView.frame.width, height: self.whiteLiveView.frame.height);
        }) { (finished) in
            self.backClosure!();
        }
    }
}


extension SKFilterEdgeView:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
 
    
    // sections count
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.modelArr.count;
    }
    
    // rows count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.modelArr[section].count;
    }
    
    
    // itemSize
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 因为是左右边距各为10  为 20
        // 如果是一行 3个 item 的话，有两个间隙，那么减去 20
        // 如果是一行 2个 item 的话, 有一个间隙，再去减去 10
        // 如果是一行 1个 item 的话,没有间隙 不用减
        let width = self.collectionView.frame.width - 40;
        
        return CGSize(width: width / 3, height: 30);
        
    }
    
    // header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 40);
    }
    
    // footer Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.width , height: 0.7);
        
    }
    
    // minimumLineSpacing 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 12;
    }
    
    // minimumInteritemSpacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    
    // insetForSection
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10);
    }
    
    // header 或者 footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind ==  UICollectionView.elementKindSectionHeader
        {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SKFilterHeaderView", for: indexPath) as! SKFilterHeaderView;
            
            let model =  self.modelArr[indexPath.section].first;
            header.titleLbl!.text = model?.name;
            return header;
        }else{
            
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier:"SKFilterFooterView", for: indexPath);
            
            return footer;
        }

        
    }
    
    // collection Cell
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SKFilterCell", for: indexPath) as! SKFilterCell;
        
        
        if self.modelArr.count > indexPath.section {
            
            let sectionArr = self.modelArr[indexPath.section];
            
            if sectionArr.count >  indexPath.row {
                
                let model = sectionArr[indexPath.row];
                cell.model = model;
            }
            
            
        }
        
        return cell;
        
    }
    
    // didselected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if self.modelArr.count > indexPath.section {
            
            let sectionArr = self.modelArr[indexPath.section];
            
            if sectionArr.count >  indexPath.row {
                
                let model = sectionArr[indexPath.row];
                model.isSelected = !model.isSelected!;
                // 如果是单选操作的话 遍历把其他的置位no
                
                for item in sectionArr{
                    if item != model {
                        item.isSelected = false;
                    }
                }
                
                // 刷新
               
                let set = NSIndexSet(index: indexPath.section);
                self.collectionView.reloadSections(set as IndexSet);
                
            }
            
            
        }
        
    }
    
    
}
