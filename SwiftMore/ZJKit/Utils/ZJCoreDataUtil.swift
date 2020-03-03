//
//  ZJCoreDataUtil.swift
//  YXPve
//
//  Created by 精灵要跳舞 on 2020/2/12.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

import UIKit
import CoreData

class ZJCoreDataUtil {
    static let shared = ZJCoreDataUtil()
    
    //增
    func save(personData : Dictionary<String, Any>) {
        //获取上下文
        let context = getContext()
        //在Person中创建一条记录
        let newRecord = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as! Person
        //写入新纪录的值
        newRecord.name = (personData["name"] as! String)
        newRecord.age = Int16(personData["age"] as! Int)
        //保存
        do{
            try context.save()
        }catch{
            fatalError()
        }
    }
    
    //删
    func delete(personData : Dictionary<String, Any>) {
        //获取上下文
        let context = getContext()
        //抓取Person内容
        let fetchRequest:NSFetchRequest = Person.fetchRequest()
        //按要求过滤
        fetchRequest.predicate = NSPredicate(format: "name == %@", personData["name"] as! String)
        do{
            //保存过滤出的结果
            let result:[Person] = try context.fetch(fetchRequest)
            for one in result{
                //结果全部删除
                context.delete(one)
            }
            try context.save()
        }catch{
            fatalError()
        }
    }
    
    //改
    func update(personData : Dictionary<String, Any>, newPersonData : Dictionary<String, Any>) {
        //获取上下文
        let context = getContext()
        //抓取Person内容
        let fetchRequest:NSFetchRequest = Person.fetchRequest()
        //按要求过滤
        fetchRequest.predicate = NSPredicate(format: "name == %@", personData["name"] as! String)
        do{
            //保存过滤出的结果
            let result:[Person] = try context.fetch(fetchRequest)
            for one in result{
                //结果全部删除
                one.name = (newPersonData["name"] as! String)
                one.age = Int16(newPersonData["age"] as! Int)
            }
            try context.save()
        }catch{
            fatalError()
        }
    }
    
    //查所有
    func queryAll() -> Array<Person>{
        let context = getContext()
        let fetchRequest:NSFetchRequest = Person.fetchRequest()
        do{
            let result = try context.fetch(fetchRequest)
            return result
        }catch{
            fatalError("读取失败")
        }
    }
    
    //根据查询条件查
    func query(personData : Dictionary<String, Any>) -> Array<Person> {
        //获取上下文
        let context = getContext()
        //抓取Person内容
        let fetchRequest:NSFetchRequest = Person.fetchRequest()
        //按要求过滤
        fetchRequest.predicate = NSPredicate(format: "name == %@", personData["name"] as! String)
        do{
            //保存过滤出的结果
            let result:[Person] = try context.fetch(fetchRequest)
            return result
        }catch{
            fatalError()
        }
    }
    
    //获取上下文对象
    func getContext()->NSManagedObjectContext{
        //获取总代理
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //获取托管对象总管
        //let managedObjectContect = appDelegate.persistentContainer.viewContext
        //返回托管对象总管
        return appDelegate.persistentContainer.viewContext
    }
}
