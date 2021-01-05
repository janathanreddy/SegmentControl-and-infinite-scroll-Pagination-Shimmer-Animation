//
//  ViewController.swift
//  SegmentControlandLoadindDataShimmerEffect
//
//  Created by Janarthan Subburaj on 05/01/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var data = [["Apple","Pear","Strawberry","Avocado","Banana","Grape","Melon","Orange","Peach","Kiwi","Apple","Pear","Strawberry","Avocado","Banana","Grape","Melon","Orange","Peach","Kiwi","Apple","Pear","Strawberry","Avocado","Banana","Grape","Melon","Orange","Peach","Kiwi"],["Pistachios","Hazelnuts","Cashews","Walnuts","Marcona Almonds","Macadamia Nuts","Peanuts","Almonds","Pine Nuts","Pecans","Pistachios","Hazelnuts","Cashews","Walnuts","Marcona Almonds","Macadamia Nuts","Peanuts","Almonds","Pine Nuts","Pecans","Pistachios","Hazelnuts","Cashews","Walnuts","Marcona Almonds","Macadamia Nuts","Peanuts","Almonds","Pine Nuts","Pecans"],["Amaranth","Barnyard ","Buckwheat","Finger Millet","Foxtail Millet","Kodu","Little Millet","Pearl millet","Proso Millet","Sorghum","Amaranth","Barnyard ","Buckwheat","Finger Millet","Foxtail Millet","Kodu","Little Millet","Pearl millet","Proso Millet","Sorghum","Amaranth","Barnyard ","Buckwheat","Finger Millet","Foxtail Millet","Kodu","Little Millet","Pearl millet","Proso Millet","Sorghum"],["Barley","Brown Rice","Buckwheat","Bulgur","Triticale","Oatmeal","Whole-wheat bread","Pasta","crackers","Quinoa","Barley","Brown Rice","Buckwheat","Bulgur","Triticale","Oatmeal","Whole-wheat bread","Pasta","crackers","Quinoa","Barley","Brown Rice","Buckwheat","Bulgur","Triticale","Oatmeal","Whole-wheat bread","Pasta","crackers","Quinoa",]]
    var countint:Int!
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        countint = 0
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: "LoadingTableViewCell")
        tableView.rowHeight = 70
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func SegmentControl(_ sender: UISegmentedControl) {
        countint = sender.selectedSegmentIndex
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[countint].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{

            let TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            TableViewCell.LabelImage.text = data[countint][indexPath.row]
            return TableViewCell
        }else{
            let LoadingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LoadingTableViewCell", for: indexPath) as! LoadingTableViewCell
            LoadingTableViewCell.ActivityIndicateLoading.startAnimating()
            return LoadingTableViewCell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        } else {
            return 80
        }
    }
    
    func loadData() {
        self.isLoading = false
        for i in 0...40 {
            data[countint].append(contentsOf: data[countint])

        }
        self.tableView.reloadData()
    }

    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            let start = data[countint].count
            let end = start + 16
            DispatchQueue.global().async { [self] in
                sleep(2)
                for i in start...end {
                    self.data[countint].append(contentsOf: data[countint])
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            loadMoreData()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let roatationTransForm = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = roatationTransForm
        UIView.animate(withDuration: 1.0){
            cell.layer.transform = CATransform3DIdentity
        }
    }
}

