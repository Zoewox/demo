//
//  DetailController.swift
//  Weapons
//
//  Created by wox on 2018/8/30.
//  Copyright © 2018年 wox. All rights reserved.
//

import UIKit

class DetailController: UITableViewController {
    
    
    
    @IBOutlet var headerImageView: UIImageView!
    
    var  weapon : Weapon!
    var headerView : UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerImageView.image = UIImage(named: weapon.image)
        navigationItem.largeTitleDisplayMode = .never
        //设置导航条
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor(named: "theme")
        
        headerView = tableView.tableHeaderView //单独提取表头保存
        tableView.tableHeaderView = nil //架空原来的表头
        tableView.addSubview(headerView)
        
        tableView.contentInset = UIEdgeInsets (top: 300, left: 0, bottom: 0, right: 0) //内边距
       
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        print("纵向位移了：", offsetY)
        headerView.frame = CGRect(x: 0, y: offsetY, width: scrollView.bounds.width, height: -offsetY)
        
    }
    
    //计算属性
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = String(describing: DetailCell.self)
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DetailCell
        
        switch indexPath.row  {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = weapon.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = weapon.type
        case 2:
            cell.fieldLabel.text = "Origin"
            cell.valueLabel.text = weapon.origin
        case 3:
            cell.fieldLabel.text = "Bullet"
            cell.valueLabel.text = weapon.bullet.description //description将整数或者小数直接转换为字符串
        case 4:
            cell.fieldLabel.text = "Muzzle Voelcity" //子弹的射速
            cell.valueLabel.text = weapon.mv.description
        default:
            cell.fieldLabel.isHidden = true //带is的是bool类型
            cell.valueLabel.text = weapon.text
        }

        // Configure the cell...重用单元格

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //打分按钮
    @IBOutlet weak var ratingBtn: UIButton!
    @IBAction func backToDetail(segue: UIStoryboardSegue) {
        if let rating = segue.identifier {
            weapon.rating = rating
            ratingBtn.setTitle("打分\(rating)星", for:.normal)
        }
        
    }

}
