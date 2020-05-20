//
//  ViewController.swift
//  Algorithm
//
//  Created by 哈哈哥 on 2020/5/7.
//  Copyright © 2020 com.hahage.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tree = BinarySearchTree<Int>()
        tree.add(element: 5)
        tree.add(element: 4)
        tree.add(element: 1)
        tree.add(element: 3)
        tree.add(element: 2)
        tree.add(element: 6)
        tree.add(element: 8)
        tree.add(element: 7)
        tree.add(element: 9)
        tree.add(element: 10)
        
        tree.postorderTraversal(node: tree.searchNode(element: 5))//后
        print("\n\n")
        tree.inorderTraversal(node: tree.searchNode(element: 5))//中
        print("\n\n")
        tree.preorderTraversal(node: tree.searchNode(element: 5))//前
        print("\n\n")
        tree.levelOrderTranversal()//层


        //不用第三个变量交换两个数...2 11
        var a = 1
        var b = 2
        a = a + b
        b = a - b
        a = a - b
        print(a,b)
    }


}

