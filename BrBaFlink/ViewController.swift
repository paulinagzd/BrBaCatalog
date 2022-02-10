//
//  ViewController.swift
//  BrBaFlink
//
//  Created by Paulina González Dávalos on 09/02/22.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func sendData(f: Array<Int>, ff: Array<Characters>)
}

class ViewController: UIViewController {
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbBday: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbNickname: UILabel!
    @IBOutlet weak var lbPortrayedBy: UILabel!
    @IBOutlet weak var btFavorites: UIButton!
    @IBOutlet weak var lbCategory: UILabel!
    
    var name: String!
    var photo: String!
    var birthday: String!
    var status: String!
    var nickname: String!
    var actor: String!
    var category: String!
    var ide: Int!
    
    var imgFromUrl: UIImage!
    var favs: Array<Int>!
    var full: Array<Characters>!
    var individual: Characters!

    var favorited: Bool!
    
    weak var delegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbName.text = individual.name
        lbBday.text = individual.birthday
        lbStatus.text = individual.status
        lbNickname.text = "\"" + individual.nickname + "\""
        lbPortrayedBy.text = individual.portrayed
        lbCategory.text = individual.category
        imgView.image =
        UIImage(data: try! Data(contentsOf: URL(string: individual.img)!))
        if favorited {
            btFavorites.setTitle("Remove from favorites", for: .normal)
            btFavorites.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    
    @IBAction func onClick(_ sender: Any) {
        if favorited {
            let ideIndex: Int = favs.firstIndex(of: ide)!
            favs.remove(at: ideIndex)
            let toRemove: Int = full.firstIndex(where: { c in
                c.char_id == ide
             })!
            full.remove(at: toRemove)
            favorited = false
            btFavorites.setTitle("Add to favorites", for: .normal)
            btFavorites.setTitleColor(UIColor.blue, for: .normal)
        } else {
            favs.append(ide)
            full.append(individual)
            favorited = true
            btFavorites.setTitle("Remove from favorites", for: .normal)
            btFavorites.setTitleColor(UIColor.red, for: .normal)
        }
        self.delegate?.sendData(f: favs, ff: full)
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

