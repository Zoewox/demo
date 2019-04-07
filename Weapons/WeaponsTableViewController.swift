//
//  WeaponsTableViewController.swift
//  Weapons
//
//  Created by wox on 2018/8/13.
//  Copyright © 2018年 wox. All rights reserved.
//

import UIKit

class WeaponsTableViewController: UITableViewController {
    //三引号"""换行保留
    
    var weapons: [Weapon] = []
   
    @IBAction func favBtnTap(_ sender: UIButton) {
        //1.知道所在单元格位置：获取坐标，由坐标推导出indexpath（单元格中的位置）
        //2.更新数据状态：更新收藏数组，状态取反（因为反复收藏或取消） ，再把当前单元格状态更新
        
        let btnPos = sender.convert(CGPoint.zero, to: self.tableView)//convert()把容器中的坐标转换为父容器中的坐标
        print("❤️在table view中的位置", btnPos)
        
        let indexPath = tableView.indexPathForRow(at: btnPos)!//从坐标获取它在单元格中的位置，在第几行。。。一定是有值的
        print("❤️所在行", indexPath)
        
        self.weapons[indexPath.row].favorite = !self.weapons[indexPath.row].favorite//将原来的值取反
        let cell = tableView.cellForRow(at: indexPath) as! CardCell
        cell.favorite = self.weapons[indexPath.row].favorite
     
    }
    
    func loadJson()  {
        let  coder = JSONDecoder() //解码器的实例化
        
        do {
            
            let url = Bundle.main.url(forResource: "weapons", withExtension: "json")! //bundel包
            let data = try Data(contentsOf: url)
            weapons = try coder.decode([Weapon].self, from: data)
            
        } catch  {
            print("解码错误",error)
        }
        
    }
    
//    func saveToJson() {
//        let coder = JSONEncoder()
//
//        do {
//            let data = try coder.encode(weapons)
//            let saveUrl = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("weapons.json")//将编码完成后的数组保存到根目录下
//            try data.write(to: saveUrl) //尝试保存
//            print("保存成功！路径：", saveUrl)
//
//
//        } catch  {
//            print("编码错误", error )
//        }
//
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "theme")!]
        
        loadJson()
//        saveToJson() //在视图载入时编码保存
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        weapons.remove(at: indexPath.row)
//        weaponTypes.remove(at: indexPath.row)
//        origins.remove(at: indexPath.row)
//        weaponImages.remove(at: indexPath.row)
//        favorites.remove(at: indexPath.row)
//        print(weapons.count)
//        tableView.deleteRows(at: [indexPath], with: .automatic)
//    }
    //左侧出现的滑动
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let favAction = UIContextualAction(style: .normal, title: "Like" ){(_, _, completion) in
            self.weapons[indexPath.row].favorite = !self.weapons[indexPath.row].favorite
            
            let cell = tableView.cellForRow(at: indexPath) as! CardCell
            cell.favorite = self.weapons[indexPath.row].favorite
            
            completion(true)
       }
        
        favAction.image = #imageLiteral(resourceName: "fav")
        favAction.backgroundColor = UIColor.purple
        
        let config = UISwipeActionsConfiguration(actions: [favAction])

        return config
//
    }
    
    
    //右侧出现的滑动,删除按钮
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delAction = UIContextualAction(style: .destructive, title: "Delete"){(_,_, completion) in
            
            self.weapons.remove(at: indexPath.row)
           
            
           
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completion(true)//菜单收起，完成整个操作
            
        }
        //分享按钮
        let shareAction = UIContextualAction(style: .normal, title: "Share"){(_,_, completion) in
            //生成分享的内容
            let text = " 这是绝地求生中的超骚\(self.weapons[indexPath.row].name)！！"
            //生成分享的图片
            let image = UIImage (named: self.weapons[indexPath.row].image)! //加上！强制有image
            let ac = UIActivityViewController (activityItems: [text,image], applicationActivities: nil)
            
            if let pc = ac.popoverPresentationController {
                
                if let  cell = tableView.cellForRow(at: indexPath) {
                    pc.sourceView = cell //弹窗的来源
                    pc.sourceRect = cell.bounds //弹窗源视图的大小
                    
                }
            }
            
            
            self.present(ac, animated: true)//弹出页面
            
            completion(true)
            
        }
        
        
        shareAction.backgroundColor = UIColor.orange
        let config = UISwipeActionsConfiguration(actions: [delAction,shareAction])//告诉它有几个按钮
        return config
        
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weapons.count
    }

    //每行显示什么
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//      string的构造器方法
        let id = String(describing: CardCell.self)
        //强制转换
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! CardCell
        
        let weapon = weapons[indexPath.row]
        
        
        cell.typeLabel.text = weapon.type
        cell.originLabel.text = weapon.origin
        cell.weaponLabel.text = weapon.name
        cell.backImgView.image = UIImage(named: weapon.image)
        //cell中favorite收藏与否状态是数组中当前那一行的状态
        cell.favorite = weapon.favorite
     
        
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeaponDetail"{
            let row = tableView.indexPathForSelectedRow!.row //step1:把所在单元格的位置信息提取出来
            let destination = segue.destination as! DetailController
            destination.weapon = weapons[row]//把对应的module传过去，所有的属性都包含在module中了
        }
    }
    
    @IBAction func backToHome(segue: UIStoryboardSegue)  {
        
    }
    

}
