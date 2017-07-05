//
//  ViewController.swift
//  Cau2b_13110085_NguyenAnhKiet
//
//  Created by Kiet Nguyen on 7/5/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var txtLink1: UITextField!
    @IBOutlet weak var txtLink2: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLoadImage(_ sender: Any) {
        if (txtLink1.text == "" || txtLink2.text == "")
        {
            showAlertDialog(message: "Please enter 2 link")
        }
        else{
            let thread1 = DispatchQueue(label: "thread1")
            let thread2 = DispatchQueue(label: "thread2")
            
            thread1.async {
                let imageUrl1: URL = URL(string: self.txtLink1.text!)!
                (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageUrl1, completionHandler: {(imageData, response, error) in
                    if let data = imageData {
                        DispatchQueue.main.async {
                            self.img1.image = UIImage(data: data)
                        }
                    }
                    
                }).resume()
            }
            thread2.async {
                let imageUrl2: URL = URL(string: self.txtLink2.text!)!
                (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageUrl2, completionHandler: {(imageData, response, error) in
                    if let data = imageData {
                        DispatchQueue.main.async {
                            self.img2.image = UIImage(data: data)
                        }
                    }
                    
                }).resume()
            }
        }
    }

    //show alertView
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: "Notification!!!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
}

