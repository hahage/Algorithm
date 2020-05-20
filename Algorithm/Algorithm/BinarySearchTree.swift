//
//  BinarySearchTree.swift
//  Algorithm
//
//  Created by 哈哈哥 on 2020/5/7.
//  Copyright © 2020 com.hahage.com. All rights reserved.
//

import Foundation

enum NodeError: Error {
    case nodeNil //node为nil
}

class TreeNode <E: Comparable>: Equatable {
    var element: E
    var left: TreeNode?
    var right: TreeNode?
    var parent: TreeNode?
    
    init(element: E, parent: TreeNode?) {
        self.element = element
        self.parent  = parent
    }
    
    static func == (lhs: TreeNode<E>, rhs: TreeNode<E>) -> Bool {
        return lhs.element == rhs.element
    }
    
    func hasTwoChildren() -> Bool {
        return self.left != nil && self.right != nil
    }
}

class BinarySearchTree <E: Comparable> {
    private var size_t = 0
    private var root: TreeNode<E>?

    /// 元素的数量
    func size() -> Int {
        return size_t
    }
    
    /// 是否为空
    func isEmpty() -> Bool {
        return size_t == 0
    }

    /// 清空所有元素
    func clear() {
        
    }
    
    /// 是否包含某元素
    func searchNode(element: E) -> TreeNode<E>? {
        if root == nil {return nil}
        return searchNode_p(startNode: root!, element: element)
    }
    private func searchNode_p(startNode: TreeNode<E>, element: E) -> TreeNode<E>? {
        if element == startNode.element {
            return startNode
        }else if element < startNode.element {
            if startNode.left == nil {return nil}
            return searchNode_p(startNode: startNode.left!, element: element)
        }else {
            if startNode.right == nil {return nil}
            return searchNode_p(startNode: startNode.right!, element: element)
        }
    }
    
//    /// 检查node是否为nil
//    func elementNilCheck(element: E) throws {
//        if element == nil {
//            throw NodeError.nodeNil
//        }
//    }
    
    /// 添加元素
    func add(element: E) {
//        // 判断节点的值是否为空。
//        try elementNilCheck(element: element)
        // 添加第一个节点
        if root == nil {
            root = TreeNode(element: element, parent: nil)
            size_t += 1
            return
        }
        // 添加的不是第一个节点
        var parent = root
        var node = root
        
        while node != nil {
            //保存node的父节点
            parent = node
            
            if element > node!.element {
                // 右子节点
                node = node!.right
            }else if element < node!.element {
                //左子节点
                node = node!.left;
            }else {
                // 相等
                node!.element = element;
                return;
            }
        }
        
        // 看看插入到父节点的哪个位置
        let newNode = TreeNode(element: element, parent: parent);
        if (element > parent!.element) {
            parent!.right = newNode;
        } else {
            parent!.left = newNode;
        }
        size_t += 1
    }
    
    /// 删除元素
    func remove(element: E) {
        var node = searchNode(element: element)
        if node == nil {return}
        
        size_t -= 1
        
        if node!.hasTwoChildren() {
            // 找到后继节点
            if let s = successor(node: &node) {
                // 用后继节点的值覆盖度为2的节点的值
                node!.element = s.element;
                // 删除后继节点
                node = s;
            }
        }
        
        // 删除node节点（node的度必然是1或者0）
        let replacement = node!.left != nil ? node!.left : node!.right;
            
        if replacement != nil { // node是度为1的节点
            // 更改parent
            replacement!.parent = node!.parent;
            // 更改parent的left、right的指向
            if node!.parent == nil { // node是度为1的节点并且是根节点
                root = replacement;
            } else if node == node!.parent!.left {
                node!.parent!.left = replacement;
            } else { // node == node.parent.right
                node!.parent!.right = replacement;
            }
        } else if node!.parent == nil { // node是叶子节点并且是根节点
            root = nil;
        } else { // node是叶子节点，但不是根节点
            if node == node!.parent!.left {
                node!.parent!.left = nil;
            } else { // node == node.parent.right
                node!.parent!.right = nil;
            }
        }
    }
}

extension BinarySearchTree {
    /// 递归实现前序遍历
    func preorderTraversal(node: TreeNode<E>?) {
        // 退出条件
        if node == nil {return}
        // 打印节点值
        print(node!.element);
        // 前序遍历左子树
        preorderTraversal(node: node!.left);
        // 前序遍历右子树
        preorderTraversal(node: node!.right);
    }
    
    /// 递归实现中序遍历
    func inorderTraversal(node: TreeNode<E>?) {
        // 退出条件
        if node == nil {return}
        // 中序遍历左子树
        inorderTraversal(node: node!.left);
        // 打印节点值
        print(node!.element);
        // 中序遍历右子树
        inorderTraversal(node: node!.right);
    }
    
    /// 递归实现后序遍历
    func postorderTraversal(node: TreeNode<E>?) {
        // 退出条件
        if node == nil {return}
        // 后序遍历左子树
        postorderTraversal(node: node!.left);
        // 后序遍历右子树
        postorderTraversal(node: node!.right);
        // 打印节点值
        print(node!.element);
    }

    /// 层序遍历
    func levelOrderTranversal() {
        // 如果根节点为空，直接返回
        if root == nil {return}
        // 创建存储节点的数组 (此处用队列实现更好)
        var arr = Array<TreeNode<E>>()
        //将头节点加入数组
        arr.append(root!)

//        var result = Array<Any>()
//        var levelArr = Array<Any>()
//        var start = 0, end = 1
        
        //退出条件，当数组为空
        while (!arr.isEmpty) {
            //取出数组头元素
            let node = arr.first
            arr.remove(at: 0)
            //打印头元素
            print(node!.element)
//            levelArr.append(node!.element)
//            start += 1
            //如果头元素左子树不为空
            if node!.left != nil {
                //将头元素左子树加入数组
                arr.append(node!.left!)
            }
            //如果头元素右子树不为空
            if node!.right != nil {
                //将头元素右子树加入数组
                arr.append(node!.right!)
            }
            
//            if start == end {
//                end = arr.count
//                start = 0
//                result.append(levelArr)
//                levelArr = Array<Any>()
//                print(result.last!)
//            }
        }
    }
}

extension BinarySearchTree {
    ///中序遍历的前驱结点
    func predecessor(node: inout TreeNode<E>?) -> TreeNode<E>? {
        if node == nil {return nil}
        // 前驱节点在左子树当中（left.right.right.right....）
        var p = node!.left;
        if p != nil {
            while p!.right != nil {
                p = p!.right;
            }
            return p;
        }
        // 从父节点、祖父节点中寻找前驱节点
        while node!.parent != nil && node == node!.parent!.left {
            node = node!.parent;
        }
        // node.parent == nil
        // node == node.parent.right
        return node!.parent;
    }

    ///中序遍历的后继结点
    func successor(node: inout TreeNode<E>?) -> TreeNode<E>? {
        if node == nil {return nil}
        // 前驱节点在左子树当中（right.left.left.left....）
        var p = node!.left;
        if p != nil {
            while p!.left != nil {
                p = p!.left;
            }
            return p;
        }
        // 从父节点、祖父节点中寻找前驱节点
        while node!.parent != nil && node == node!.parent!.right {
            node = node!.parent;
        }
        return node!.parent;
    }
}
