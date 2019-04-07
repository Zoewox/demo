import UIKit

extension NewWeaponController: UIPickerViewDelegate, UIPickerViewDataSource{
    //列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView.tag {
        case 10...11:
            return 1
        default:
            return 2
        }
    }
    //每列的行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 10:
            return self.specs.types.count //武器的类型
        case 11:
            return self.specs.bullets.count
        default:
            //判断：根据所选择的大洲，国家不同
            //先判断哪一列
            if component == 0{
                return self.origin.count //返回产地的数目
                
            }else{
                return self.origin[pickerView.selectedRow(inComponent: 0)].countries.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 10:
            return self.specs.types[row]
        case 11:
            return self.specs.bullets[row].description //description快捷转换为string
        default:
            if component == 0{
                return self.origin[row].continent //哪个洲
            }else{
                return self.origin[pickerView.selectedRow(inComponent: 0)].countries[row]
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 12 {
            if component == 0{
                pickerView.reloadComponent(1) //选中第一列后刷新第二列
            }
        }
    }
    
}

