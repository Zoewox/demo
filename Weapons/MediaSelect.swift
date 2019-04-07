import UIKit
import MobileCoreServices
import AVFoundation


extension NewWeaponController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.

let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        //1.在字典info中查询媒体类型取出转化为string
        
        let mediaType = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.mediaType)] as! String
        
        if mediaType == (kUTTypeMovie as String) {
            
            videoUrl = (info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.mediaURL)] as! URL)
//             import avfoundation取视频的缩略图
            
            
            let asset = AVAsset(url: videoUrl) //把视频地址转化为视频资源
           
            let gen = AVAssetImageGenerator(asset: asset)
            
            let time = CMTime(seconds: 0, preferredTimescale: 3)//第二秒截图
            
            let image = try! gen.copyCGImage(at: time, actualTime: nil)
            
            bgImage.image = UIImage(cgImage: image)//cgImage是内存中的图不同于UIImage
            
            playBtn.isHidden = false

        } else {
            bgImage.image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage //相册返回的原始图
            
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}


extension  NewWeaponController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.section == 0 {
       
            let actionSheet = UIAlertController(title: "选择一个媒体作为武器的封面", message: nil, preferredStyle: .actionSheet)
            
            let photoAction = UIAlertAction(title: "Photo", style: .default, handler: { (_)in
                guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                    print("相册授权失败！")
                    return
                }
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
                
            } )
            
            let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: { (_)in
                guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                    print("打开摄像头失败！")
                    return
                }
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                self.present(picker, animated: true)
                
            })
            
            let videoAction = UIAlertAction(title: "Video", style: .default, handler: { (_)in
                guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                    return
                }
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.mediaTypes = [kUTTypeMovie as String]
                self.present(picker, animated: true, completion: nil)
            })
            
            let recordAction = UIAlertAction(title: "Record a video", style: .default, handler: { (_)in
                guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                    print("打卡摄像头失败！")
                    return
                }
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.mediaTypes = [kUTTypeMovie as String]
                picker.videoQuality = .typeHigh //视频质量
                picker.videoMaximumDuration = 10 //视频时长
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            })
            
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
            
            
            actionSheet.addAction(photoAction)
            actionSheet.addAction(takePhotoAction)
            actionSheet.addAction(recordAction)
            actionSheet.addAction(videoAction)
            actionSheet.addAction(cancelAction)
            
            present(actionSheet, animated: true )
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true )
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
