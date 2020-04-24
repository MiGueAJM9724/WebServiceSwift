//
//  ViewController.swift
//  WebService
//
//  Created by Miguel Angel Jimenez Melendez on 4/21/20.
//  Copyright © 2020 Miguel Angel Jimenez Melendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var moneda = [Moneda]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func btnConsulta(_ sender: UIButton) {
        moneda.removeAll()
        let urlWiki = "https://api.coindesk.com/v1/bpi/currentprice.json"
        let urlObjeto = URL(string: urlWiki)
        let tarea = URLSession.shared.dataTask(with: urlObjeto!) { (datos, respuesta, error) in
            if error == nil {
                do{
                    let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                    let querySubJson = json["bpi"] as! [String:Any]
                    
                    for money in querySubJson{
                        let pagesSubJson = querySubJson[money.key] as! [String:Any]
                        let desc = pagesSubJson["description"] as! String
                        let cod = pagesSubJson["code"] as! String
                        let rat = pagesSubJson["rate"] as! String
                        
                        self.moneda.append(Moneda(description: desc, rate: rat, code: cod))
                    }
                    DispatchQueue.main.sync(execute: {
                        self.performSegue(withIdentifier: "seguelist", sender: self)
                        })
                } catch let jsonErr{
                    print("El procesamiento del JSON tuvo un error", jsonErr)
                }
            }else{
                print(error!)
            }
        }
        tarea.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguelist"{
            let seguex = segue.destination as! TableViewController
            seguex.monedaC = moneda
        }
    }
}

