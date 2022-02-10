//
//  TableViewController.swift
//  BrBaFlink
//
//  Created by Paulina González Dávalos on 09/02/22.
//

import UIKit
import SwiftUI

class TableViewController: UITableViewController, SendDataDelegate {
    func sendData(f: Array<Int>, ff: Array<Characters>) {
        self.dismiss(animated: true, completion: nil)
        self.f = f
        self.fullF = ff
        self.tableView.reloadData()
    }
    
    @IBOutlet weak var sc: UISegmentedControl!
    let urlData = DataHandler().characters
    let network = DataHandler()
    
    var c: [Characters] = []
    var cc: [Characters] = []
    var f: [Int] = []
    var fullF: [Characters] = []
    
    weak var delegate: SendDataDelegate?
    var l: UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        l = self.loader()
        fetchChars()
    }
    
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
        
    func stopLoader(loader: UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
    
    func fetchChars() {
        network.getChars() { [self] result in
            switch result {
                case .failure(let error):
                    print(error)

                case .success(let chars):
                    self.c = chars
                    self.cc = self.c
                    // print(chars)
                    self.stopLoader(loader: self.l!)
                }
            self.tableView.reloadData()
        }
    }

    @IBAction func onTabChange(_ sender: Any) {
        if sc.selectedSegmentIndex == 0 {
            c = cc
        } else {
            c = fullF
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return c.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "data",
            for: indexPath)
        cell.imageView?.image =
          UIImage(data: try! Data(contentsOf: URL(string: c[indexPath.row].img)!))  // image
        cell.textLabel?.text = c[indexPath.row].name
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let initialView = segue.destination as! ViewController
        
        let i = tableView.indexPathForSelectedRow!
        initialView.ide = c[i.row].char_id
        initialView.favorited = f.firstIndex(of: c[i.row].char_id) != nil
        initialView.favs = f
        initialView.full = fullF
        initialView.individual = c[i.row]
        initialView.delegate = self
    }
}

