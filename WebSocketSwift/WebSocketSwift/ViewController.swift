//
//  ViewController.swift
//  WebSocketSwift
//
//  Created by OFweek01 on 2021/5/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        WebSocketManager.shard.connectSocket(nil);
    }


}

