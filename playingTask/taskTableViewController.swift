//
//  taskTableViewController.swift
//  playingTask
//
//  Created by 松田陽佑 on 2019/03/03.
//  Copyright © 2019 松田陽佑. All rights reserved.
//

import UIKit

class taskTableViewController: UITableViewController {

    // ToDoを格納する配列
    var todoList = [MyTodo]()
    
    @IBOutlet var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableViewの背景画像を設定する
        let image = UIImage(named: "color")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.taskTableView.frame.width, height: self.taskTableView.frame.height))
        imageView.image = image
        self.taskTableView.backgroundView = imageView
        
        addResultButtonView()
        
        // 保存しているToDoを読み込む
        let userDefaults = UserDefaults.standard
        if let storedTodoList = userDefaults.object(forKey: "todoList") as? Data {
            do {
                if let unarchiveTodoList = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, MyTodo.self], from: storedTodoList) as? [MyTodo] {
                    todoList.append(contentsOf: unarchiveTodoList)
                }
            } catch {
                print(error)
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                print("リセット")
                // エラー処理なし
            }
        }
        
        taskTableView.register(UINib(nibName: "AdvencedTaskTableViewCell", bundle: nil), forCellReuseIdentifier: "reusableCell")
    }
    
    private func addResultButtonView() {
        let resultButton = addTaskButton()
        
        resultButton.backgroundColor = .red
        resultButton.setTitle("＋", for: .normal)
        resultButton.titleLabel?.font = UIFont.systemFont(ofSize: 42)
        resultButton.layer.cornerRadius = 30
        resultButton.layer.shadowOpacity = 0.5
        resultButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        resultButton.addTarget(self, action: #selector(tapAddTask(_:)), for: UIControl.Event.touchUpInside)
        
        taskTableView.addSubview(resultButton)
        
        // set position
        resultButton.translatesAutoresizingMaskIntoConstraints = false
        resultButton.rightAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        resultButton.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        resultButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        resultButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.clear
    }
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.clear
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    // ボタンが押された時に呼ばれるメソッド
    @objc func tapAddTask(_ sender: UIButton) {
        // 移動先のコントローラ情報取得
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "createTask")
        // 映像効果
        nextVC?.modalTransitionStyle = .coverVertical
        // 画面遷移
        present(nextVC!, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as! AdvencedTaskTableViewCell
        content.dataOutputToLabel(indexPath: indexPath)
        content.setIcon(name: "undou")
        content.layer.cornerRadius = 10.0
        content.layer.borderWidth = 1.5
        content.layer.borderColor = UIColor.white.cgColor
        content.backgroundColor = UIColor.clear
        return content
    }
    

//    // MARK: - Table view data source
//
//    // テーブルの行数
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return todoList.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = taskTableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
//        // 行番号に合ったToDoの情報を取得
//        let todo = todoList[indexPath.row]
//
//        let formatter = DateComponentsFormatter()
//        formatter.unitsStyle = .positional
//        formatter.allowedUnits = [.minute,.hour,.second]
//
//        cell.taskTitle.text = todo.todoTitle
//        cell.willTime.text = formatter.string(from: TimeInterval(todo.willTime!))
//        cell.didTime.text = formatter.string(from: TimeInterval(todo.didTime!))
//        cell.category.text = todo.category
//        if todo.monday == true {
//            cell.mondayLabel.alpha = 1.0
//        } else {
//            cell.mondayLabel.alpha = 0.2
//        }
//        if todo.tuesday == true {
//            cell.tuesdayLabel.alpha = 1.0
//        } else {
//            cell.tuesdayLabel.alpha = 0.2
//        }
//        if todo.wednesday == true {
//            cell.wednesdayLabel.alpha = 1.0
//        } else {
//            cell.wednesdayLabel.alpha = 0.2
//        }
//        if todo.thursday == true {
//            cell.thursdayLabel.alpha = 1.0
//        } else {
//            cell.thursdayLabel.alpha = 0.2
//        }
//        if todo.friday == true {
//            cell.fridayLabel.alpha = 1.0
//        } else {
//            cell.fridayLabel.alpha = 0.2
//        }
//        if todo.saturday == true {
//            cell.saturdayLabel.alpha = 1.0
//        } else {
//            cell.saturdayLabel.alpha = 0.2
//        }
//        if todo.sunday == true {
//            cell.sundayLabel.alpha = 1.0
//        } else {
//            cell.sundayLabel.alpha = 0.2
//        }
//
//        let progressWidth = (Float(cell.frame.width) * (Float(todo.didTime!)/Float(todo.willTime!)))
//        print(cell.frame.width)
//        print(todo.didTime!)
//        print(todo.willTime!)
//        print(Float(todo.didTime!)/Float(todo.willTime!))
//        print(progressWidth)
//        cell.progressBar.frame.size = CGSize(width: Int(progressWidth), height: 20)
//
//        let dTime = Int(todo.didTime!)
//        let wTime = Int(todo.willTime!)
//
//        // クリアしたか？
//        if todo.isDone == false {
//            if dTime >= wTime {
//                todo.isDone = true
//
//                // おめでとうページに遷移
//                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "omedetou") as? ClearViewController
//                nextVC?.modalTransitionStyle = .flipHorizontal
//                nextVC?.data = todo
//                present(nextVC!, animated: true, completion: nil)
//            }
//        }
//
//        if todo.isDone == true {
//            cell.clearMask.alpha = 0.8
//            cell.clearLabel.alpha = 1.0
//            cell.clearLabel.text = "CLEAR"
//            cell.isUserInteractionEnabled = false
//        } else {
//            cell.clearMask.alpha = 0.0
//            cell.clearLabel.alpha = 0.0
//            cell.clearLabel.text = ""
//        }
//
//        return cell
//    }
//
//    // セルが編集可能か
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    // セルを削除
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        // 削除処理かどうか
//        if editingStyle == UITableViewCell.EditingStyle.delete {
//            // ToDoリストから削除
//            todoList.remove(at: indexPath.row)
//            // セルを削除
//            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
//            // データ保存
//            do {
//                let data: Data =  try NSKeyedArchiver.archivedData(withRootObject: todoList, requiringSecureCoding: true)
//                // userDefaultsに保存
//                let userDefaults = UserDefaults.standard
//                userDefaults.set(data, forKey: "todoList")
//                userDefaults.synchronize()
//            } catch {
//
//            }
//        }
//    }

    // MARK: - Navigation

    // セグエで移動するときにわたす
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // セグエがshowDoTaskだった場合の処理
        if segue.identifier == "showDoTask" {
            // タップした行番号を取得
            if let indexPath = self.taskTableView.indexPathForSelectedRow {
                // 行のデータを取り出す
                let todo = todoList[(indexPath as NSIndexPath).row]
                print(todo.todoTitle)
                // 移動先のビューコントローラのdataプロパティに値を設定する
                (segue.destination as! DoTaskViewController).data = todo
                (segue.destination as! DoTaskViewController).index = indexPath.row
            }
        }
    }

}

// タスクを管理するクラス
class MyTodo: NSObject,  NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    // Todoのタイトル
    var todoTitle:String?
    // 目標時間（秒数）
    var willTime:Int?
    // 実施時間（秒数）
    var didTime:Int?
    // ジャンル
    var category:String?
    // 完了フラグ
    var isDone:Bool = false
    
    // 曜日
    var monday:Bool = false
    var tuesday:Bool = false
    var wednesday:Bool = false
    var thursday:Bool = false
    var friday:Bool = false
    var saturday:Bool = false
    var sunday:Bool = false
    
    // コンストラクタ
    override init() {
        
    }
    
    // デコード処理の実装
    required init?(coder aDecoder: NSCoder) {
        todoTitle = aDecoder.decodeObject(forKey: "todoTitle") as? String
        category = aDecoder.decodeObject(forKey: "category") as? String
        willTime = aDecoder.decodeObject(forKey: "willTime") as? Int
        didTime = aDecoder.decodeObject(forKey: "didTime") as? Int
        monday = aDecoder.decodeBool(forKey: "monday")
        tuesday = aDecoder.decodeBool(forKey: "tuesday")
        wednesday = aDecoder.decodeBool(forKey: "wednesday")
        thursday = aDecoder.decodeBool(forKey: "thursday")
        friday = aDecoder.decodeBool(forKey: "friday")
        saturday = aDecoder.decodeBool(forKey: "saturday")
        sunday = aDecoder.decodeBool(forKey: "sunday")
        isDone = aDecoder.decodeBool(forKey: "isDone")
    }
    // エンコード処理
    func encode(with aCoder: NSCoder) {
        aCoder.encode(todoTitle, forKey: "todoTitle")
        aCoder.encode(category, forKey: "category")
        aCoder.encode(willTime, forKey: "willTime")
        aCoder.encode(didTime, forKey: "didTime")
        aCoder.encode(monday, forKey: "monday")
        aCoder.encode(tuesday, forKey: "tuesday")
        aCoder.encode(wednesday, forKey: "wednesday")
        aCoder.encode(thursday, forKey: "thursday")
        aCoder.encode(friday, forKey: "friday")
        aCoder.encode(saturday, forKey: "saturday")
        aCoder.encode(sunday, forKey: "sunday")
        aCoder.encode(isDone, forKey: "isDone")
    }
}
