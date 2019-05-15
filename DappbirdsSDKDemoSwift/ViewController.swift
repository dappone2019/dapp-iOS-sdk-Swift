//
//  ViewController.swift
//  DappbirdsSDKDemoSwift
//
//  Created by 区块链 on 2019/5/8.
//  Copyright © 2019 com.blockchain.dappbirdssdk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    fileprivate var tableView: UITableView!
    
    var addressLabel: UILabel!
    var addressCopyLabel: UILabel!
    var ongBalance: UILabel!
    var manager:DBWalletManager!
    
    var flagInit = false
    
    var flagHasWallet = false
    
    fileprivate var dataList = [["name": "钱包", "data":["查看钱包"]],
                                ["name": "支付", "data":["支付0.1个ONG"]],
                                ["name": "刷新", "data":["刷新余额"]],
                                ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dappbirds Demo"
        view.backgroundColor = UIColor.borderColor()
        self.manager = DBWalletManager.shared()

        self.manager.setApp_id("1", openid: "5X9qHSUPQgrZQ84mD188sd9kD3WkQN8vx", chain_type: "7", debugMode: true)
        
        self.initView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.manager != nil {
            self.queryIsExitWallet()
        }
        if self.tableView != nil {
            self.tableView.reloadData()
        }
    }
    
    /**
     * 1.查询当前钱包余额
     */
    func getBalanceWithAddress() {
        self.manager.getCurrentWalletBalanceCallback { (balanceDict, error) in
            let dict = balanceDict as! [String: String]
            self.ongBalance.text = "ONG余额：\(dict["ONG"] ?? "暂无")"
        }
    }
    
    
    /**
     * 2.查询是否存在钱包
     */
    func queryIsExitWallet() {
        self.manager.getAccountCallBack({ (hasWallet, address, msg) in
            self.flagHasWallet = hasWallet
            if hasWallet && self.addressLabel != nil {
                self.addressLabel.text = address
                self.addressLabel.textColor = UIColor.blackStyleColor()
                self.getBalanceWithAddress()
                self.addressCopyLabel.isHidden = false
            } else {
                self.addressLabel.text = "暂无钱包，点击创建"
                self.addressLabel.textColor = UIColor.mainColor()
                self.ongBalance.text = "ONG余额：暂无"
                self.addressCopyLabel.isHidden = true
            }
        })
    }
    
    /**
     * 3.创建钱包
     */
    func modalToCreateWalletVC() {
        // modal创建钱包页面
        self.manager.createdNewWallet()
        // 获取用户创建钱包的h回调 （成功后开发者保存地址）
        self.manager.accountCallBack = { [weak self] (success, address, msg) in
            Tprint(messsage: success)
            Tprint(messsage: msg)
            if success {
                MBProgressHUD.showMessage("创建成功")
            }
        }
    }
    
    /**
     * 4.统一支付
     */
    func modalToPayViewController() {
        let random = Int(arc4random() % 1000000)
        let order_no = "ordernomber\(random)"
        self.manager.createdPayWallet(withContract_address: "48628e2aa44a7e7f2d8e9fbe4001d731713789ca", _signature: "cf38f9b6d2dc07784e727066f2fdac77", order_no: order_no, amount: "0.1", _timestamp: "1556543707")
        self.manager.payCallBack = { [weak self] (success, msg) in
            Tprint(messsage: success)
            if success {
                MBProgressHUD.showMessage("支付成功")
            }
        }
    }
    
    /**
     * 5.查看钱包明细
     */
    func modalToQueryWalletViewController() {
        self.manager.queryWalletDetails()
    }
    
    @objc func onTapCreatWalletOrCopy() {
        if flagHasWallet {
            self.copyAddress()
        } else {
            self.modalToCreateWalletVC()
        }
    }
    
    func copyAddress() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = self.addressLabel.text
        Tprint(messsage: pasteboard.string)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dataArr = self.dataList[section]["data"] as! [String]
        return dataArr.count;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataList.count
    }
    
    static let reuseID = "HomeTableViewCellID"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ViewController.reuseID)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: ViewController.reuseID)
        }
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 14)
        let dataArr = self.dataList[indexPath.section]["data"] as! [String]
        cell!.textLabel?.text = dataArr[indexPath.row]
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.flagHasWallet {
            if indexPath.section == 0 {
                self.modalToQueryWalletViewController()
            } else if indexPath.section == 1 {
                self.modalToPayViewController()
            } else if indexPath.section == 2 {
                self.getBalanceWithAddress()
            }
        } else {
            self.alertCreateWalletActionMsg(msg: "您还没有钱包，是否立刻创建？", title: "提示")
        }
    }
    

}


extension ViewController {
    func alertCreateWalletActionMsg(msg: String, title: String) {
        let alertVC = UIAlertController.init(title: title, message: msg, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: "去创建", style: .default, handler: { (action) in
            self.modalToCreateWalletVC()
        }))
        alertVC.addAction(UIAlertAction.init(title: "取消", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func initView() {
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: NAVIGATION_HEIGHT, width: SCREENWIDTH, height: SCREENHEIGHT), style: .grouped);
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        tableView.backgroundColor = UIColor.borderColor()
        self.view.addSubview(self.tableView)
        
        let headerView = UIView.init()
        headerView.backgroundColor = UIColor.white
        var innerY: CGFloat = 0
        
        let sepView1 = UIView.init(frame: CGRect.init(x: 0, y: innerY, width: SCREENWIDTH, height: 20))
        sepView1.backgroundColor = UIColor.borderColor()
        headerView.addSubview(sepView1)
        innerY += sepView1.frame.height
        
        let ongBalance = self.getCommonLabel(rect: CGRect.init(x: 15, y: innerY, width: (SCREENWIDTH - 30) * 0.5, height: 35))
        ongBalance.text = "ONG余额：暂无"
        self.ongBalance = ongBalance;
        headerView.addSubview(ongBalance)
        
        let copyLabel = self.getCommonLabel(rect: CGRect.init(x: SCREENWIDTH * 0.5, y: innerY, width: (SCREENWIDTH - 30) * 0.5, height: 35))
        copyLabel.text = "复制地址"
        self.addressCopyLabel = copyLabel
        copyLabel.textAlignment = .right
        copyLabel.textColor = UIColor.mainColor()
        copyLabel.isUserInteractionEnabled = true
        let tapCopy = UITapGestureRecognizer.init(target: self, action: #selector(onTapCreatWalletOrCopy))
        copyLabel.addGestureRecognizer(tapCopy)
        headerView.addSubview(copyLabel)
        innerY += copyLabel.frame.height
        
        let addressTitle = self.getCommonLabel(rect: CGRect.init(x: 15, y: innerY, width: 70, height: 35))
        addressTitle.text = "钱包地址："
        headerView.addSubview(addressTitle)
        
        let addressLabel = self.getCommonLabel(rect: CGRect.init(x: 85, y: innerY, width: SCREENWIDTH - 85, height: 35))
        addressLabel.text = "address"
        addressLabel.isUserInteractionEnabled = true
        let tapCreat = UITapGestureRecognizer.init(target: self, action: #selector(onTapCreatWalletOrCopy))
        addressLabel.addGestureRecognizer(tapCreat)
        self.addressLabel = addressLabel
        headerView.addSubview(addressLabel)
        innerY += addressLabel.frame.height
        
        let sepView2 = UIView.init(frame: CGRect.init(x: 0, y: innerY, width: SCREENWIDTH, height: 20))
        sepView2.backgroundColor = UIColor.borderGrayStyleColor()
        headerView.addSubview(sepView2)
        innerY += sepView2.frame.height
        
        headerView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: innerY)
        self.tableView.tableHeaderView = headerView
    }
    
    func getCommonLabel(rect: CGRect) -> UILabel {
        let label = UILabel.init(frame: rect)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.blackStyleColor()
        label.textAlignment = .left
        return label
    }

}

