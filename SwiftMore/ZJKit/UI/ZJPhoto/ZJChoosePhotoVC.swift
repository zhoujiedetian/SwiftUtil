//
//  ZJChoosePhotoVC.swift
//  YXPve
//
//  Created by 精灵要跳舞 on 2020/2/12.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

import UIKit
import Photos

class ZJChoosePhotoVC: ZJBaseVC {
    
    @IBOutlet weak var myCollection: UICollectionView!
    
    var photoData : PHFetchResult<PHAsset>?
    
    var colum : Int = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "所有图片"
        setLeftBtn(withTitle: "取消", EventResponse: #selector(cancel))
        myCollection.register(UINib.init(nibName: "ZJPhotoCell", bundle: nil), forCellWithReuseIdentifier: "ZJPhotoCell")
        let auth = isAuthorized()
        if !auth {
            ZJTip.showTip(content: "暂无权限")
        }else {
            // 获取所有系统图片信息集合
               let allOptions = PHFetchOptions()
            // 按照时间排序
               allOptions.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: true)]
            //  将元素集合拆解开，此时 allResults 内部是一个个的PHAsset单元
               photoData = PHAsset.fetchAssets(with: allOptions)
               myCollection.reloadData()
        }
    }
    
    //取消
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //判断是否授权
    func isAuthorized() -> Bool {
        return PHPhotoLibrary.authorizationStatus() == .authorized ||
            PHPhotoLibrary.authorizationStatus() == .notDetermined
    }

}

//UICollectionViewDelegate
extension ZJChoosePhotoVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = KScreenWidth - 2 * 2 - CGFloat(colum * 2)
        let width = totalWidth / CGFloat(colum)
        return CGSize.init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZJPhotoCell", for: indexPath) as! ZJPhotoCell
        let photo = photoData?.object(at: indexPath.row)
       
        PHCachingImageManager.default().requestImage(for: photo!, targetSize: CGSize.zero, contentMode: .aspectFit, options: nil) { (result: UIImage?, dictionry: Dictionary?) in
            // 展示图片
            cell.photoIgv.image = result
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photoData?.object(at: indexPath.row)
        
         PHCachingImageManager.default().requestImage(for: photo!, targetSize: CGSize.zero, contentMode: .aspectFit, options: nil) { (result: UIImage?, dictionry: Dictionary?) in
             // 展示图片
            self.dismiss(animated: true, completion: nil)
         }
    }
}
