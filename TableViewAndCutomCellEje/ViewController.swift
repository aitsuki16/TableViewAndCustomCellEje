//
//  ViewController.swift
//  TableViewAndCutomCellEje
//
//  Created by user on 2023/09/30.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var TableView: UITableView!
    
    let af = APIFetchHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        TableView.delegate = self
        
        TableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        TableView.rowHeight = 70
        af.fetchData(completion: { _,_ in })
        
    }
    let rainbow: [UIColor] = [.red, .yellow, .green, .orange, .blue, .purple, .magenta]

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
                   return 2
               }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rainbow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomCell.self), for: indexPath)
        cell.backgroundColor = rainbow[indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let articleVC = storyboard?.instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController {
            articleVC.modalPresentationStyle = .fullScreen
            present(articleVC, animated: true, completion: nil)


        }
    }
}
