//
//  ViewController.swift
//  fruitsSlot_3reels
//
//  Created by 丹羽 雄大 on 2018/06/23.
//  Copyright © 2018年 丹羽 雄大. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var reel1: UIPickerView!
    @IBOutlet weak var reel2: UIPickerView!
    @IBOutlet weak var reel3: UIPickerView!
    @IBOutlet weak var result: UILabel!
    
    var reel1Count:Int = 0
    var reel2Count:Int = 0
    var reel3Count:Int = 0
    
    var reel1Element:Int = 0
    var reel2Element:Int = 0
    var reel3Element:Int = 0
    
    @IBOutlet weak var startButton: UIButton!
    
    var allReelsStop:Bool = false
    
    var timer1:Timer = Timer()
    var timer2:Timer = Timer()
    var timer3:Timer = Timer()
    
    var numOfCompos:Int = 10;
    
    let compos = [["🍓", "🍊", "🍎", "🍒", "🍍", "🍉", "🍇", "🍑", "🥝", "🍏"], ["🍓", "🍊", "🍎", "🍒", "🍍", "🍉", "🍇", "🍑", "🥝", "🍏"], ["🍓", "🍊", "🍎", "🍒", "🍍", "🍉", "🍇", "🍑", "🥝", "🍏"]]
    
    var unionCompos = [["🍓", "🍊", "🍎", "🍒", "🍍", "🍉", "🍇", "🍑", "🥝", "🍏"], ["🍓", "🍊", "🍎", "🍒", "🍍", "🍉", "🍇", "🍑", "🥝", "🍏"], ["🍓", "🍊", "🍎", "🍒", "🍍", "🍉", "🍇", "🍑", "🥝", "🍏"]]
    
    //start押した時のふるまい
    @IBAction func start(_ sender: Any) {
        
        startButton.isEnabled = false
        
        //リールのリセット
        pickerViewLoaded(reelNum: 0, row: reel1.selectedRow(inComponent: 0))
        pickerViewLoaded(reelNum: 1, row: reel2.selectedRow(inComponent: 0))
        pickerViewLoaded(reelNum: 2, row: reel3.selectedRow(inComponent: 0))
        
        reel1Count = 0
        reel2Count = 0
        reel3Count = 0
        
        reel1Element = 0
        reel2Element = 0
        reel3Element = 0
        
        result.text = "GOOD LUCK"
        
        reel1Element = Int(Int(arc4random())%numOfCompos)
        reel2Element = Int(Int(arc4random())%numOfCompos)
        reel3Element = Int(Int(arc4random())%numOfCompos)
        
        self.timer1 = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(reel1Stop), userInfo: nil, repeats: true)
        
        self.timer2 = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(reel2Stop), userInfo: nil, repeats: true)
        
        self.timer3 = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(reel3Stop), userInfo: nil, repeats: true)
        
        //リールが止まる瞬間だんだんゆっくりになるようなアニメーション設定
//        UIView.animate(withDuration: 10.0, delay: 0, options: .curveEaseInOut, animations: {
//            self.reel1.selectRow(8000+num1, inComponent: 0, animated: true)
//            self.reel2.selectRow(9000+num2, inComponent: 0, animated: true)
//            self.reel3.selectRow(7000+num3, inComponent: 0, animated: true)
//        }, completion: nil)
        
        
        //リールストップ
//        self.reel1.selectRow(6000+num1, inComponent: 0, animated: true)
//        self.reel2.selectRow(9000+num2, inComponent: 0, animated: true)
//        self.reel3.selectRow(7000+num3, inComponent: 0, animated: true)

        //結果表示
        //showResult(reel1, reel2, reel3)
        
    }
    
    @objc func reel1Stop(){
        if(reel1Count == 3){
            self.reel1.selectRow(6000+reel1Element+1, inComponent: 0, animated: true)
            reel1Count = reel1Count + 1
        }else if(reel1Count<4){
            self.reel1.selectRow(5100+reel1Count*100+reel1Element, inComponent: 0, animated: true)
            reel1Count = reel1Count + 1
        } else{
            self.reel1.selectRow(6000+reel1Element, inComponent: 0, animated: true)
            self.timer1.invalidate()
        }
    }
    
    @objc func reel2Stop(){
        if(reel2Count == 6){
            self.reel2.selectRow(9000+reel2Element+1, inComponent: 0, animated: true)
            reel2Count = reel2Count + 1
        }else if(reel2Count<7){
            self.reel2.selectRow(5100+reel2Count*100+reel2Element, inComponent: 0, animated: true)
            reel2Count = reel2Count + 1
        } else{
            self.reel2.selectRow(9000+reel2Element, inComponent: 0, animated: true)
            self.timer2.invalidate()
        }
    }
    
    @objc func reel3Stop(){
        if(reel3Count == 9){
            self.reel3.selectRow(7000+reel3Element+1, inComponent: 0, animated: true)
            reel3Count = reel3Count + 1
        }else if(reel3Count<10){
            self.reel3.selectRow(5100+reel3Count*100+reel3Element, inComponent: 0, animated: true)
            reel3Count = reel3Count + 1
        } else if(reel3Count == 10){
            self.reel3.selectRow(7000+reel3Element, inComponent: 0, animated: true)
            reel3Count = reel3Count + 1
        }else{
            showResult(reel1, reel2, reel3)
            self.timer3.invalidate()
            startButton.isEnabled = true
        }
    }
    
    //コンポーネント数（列数component）
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return compos.count;
    }
    
    //要素数（行数row）
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //あるコンポーネント（どれでもいい）の列数が欲しいので[component]がついている
        let unionCompo = self.unionCompos[component]
        
        //確認用
        //print(unionCompo.count)
        
        return unionCompo.count
    }
    
    //コンポーネントの横幅
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 70
    }
    
    //コンポーネントの縦幅
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 70
    }
    
    //表示するラベル設定
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        //x, y: 位置      width, height: ラベルの大きさ
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.textAlignment = .center
        label.text = unionCompos[component][row]
        //フォントサイズ
        label.font = UIFont.systemFont(ofSize: 50)
        return label
    }
    
    //行、列で指定された項目を取ってくる（今の所は使わない）
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = unionCompos[component][row]
        return item
    }
    
    //項目が選択された瞬間に実行されるメソッド
    //真ん中辺りの要素に瞬間的に移し替える
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //真ん中辺りに戻す
        pickerViewLoaded(reelNum: component, row: row)
    }
    
    func showResult(_ pickerView1: UIPickerView, _ pickerView2: UIPickerView, _ pickerView3: UIPickerView) {
        if(
            (pickerView1.selectedRow(inComponent: 0)%10 == pickerView2.selectedRow(inComponent: 0)%10) && (pickerView2.selectedRow(inComponent: 0)%10 == pickerView3.selectedRow(inComponent: 0)%10)
            ) {
            result.text = "YOU WIN!!!"
        }
        else{
            result.text = "TRY AGAIN!!!"
        }
//        pickerView(reel1, didSelectRow: reel1.selectedRow(inComponent: 0), inComponent: 0)
//        pickerView(reel2, didSelectRow: reel2.selectedRow(inComponent: 0), inComponent: 1)
//        pickerView(reel3, didSelectRow: reel3.selectedRow(inComponent: 0), inComponent: 2)
        
    }
    
    func pickerViewLoaded(reelNum num: Int, row row:Int) {
        //要素数（列数）
        let max:Int = 10000
        //1の位を0にしたい（配列の先頭に合わせるため）
        let base10:Int = (max/2)-(max/2)%10
        //選択された項目が変更しないように微調整しながらしれっと真ん中辺りに戻す
        switch num {
        case 0:
            reel1.selectRow(row%numOfCompos+base10, inComponent: 0, animated: false)
            break
        case 1:
            reel2.selectRow(row%numOfCompos+base10, inComponent: 0, animated: false)
            break
        case 2:
            reel3.selectRow(row%numOfCompos+base10, inComponent: 0, animated: false)
            break
        default: break
        }
    }
    
    //アプリ起動時最初に実行されるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        reel1.delegate = self
        reel1.dataSource = self
        reel2.delegate = self
        reel2.dataSource = self
        reel3.delegate = self
        reel3.dataSource = self
        
        //初期化（各コンポーネントの要素数が1000になるように頑張っている）
        for count in 0..<999 {
            for componentNum in 0..<3 {
                self.unionCompos[componentNum] = self.unionCompos[componentNum] + self.compos[componentNum]
            }
        }
        
        //最初から真ん中辺りにいるようにする
        pickerViewLoaded(reelNum: 0, row: 0)
        pickerViewLoaded(reelNum: 1, row: 0)
        pickerViewLoaded(reelNum: 2, row: 0)
        
        result.text = "ENJOY!!!"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


