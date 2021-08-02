//
//  QuizViewController.swift
//  SampleQuiz
//
//  Created by muffin man on 2021/07/22.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet var quizNumberLabel: UILabel!
    @IBOutlet var quizTextView: UITextView!
    @IBOutlet var answerButton1: UIButton!
    @IBOutlet var answerButton2: UIButton!
    @IBOutlet var answerButton3: UIButton!
    @IBOutlet var answerButton4: UIButton!
    @IBOutlet var judgeImageView: UIImageView!
    
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0
    var selectLevel = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // レベルが受け取れているか確認
        print("選択したのはレベル\(selectLevel)")
        
        
        // csvArrayに代入(csvファイル)
        // 難易度の番号 (selectLevel)
        csvArray = loadCSV(fileName: "quiz\(selectLevel)")
        
        // 問題をシャッフルする
        csvArray.shuffle()

        // quizArrayに1問文のデータを代入
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        
        // Label,TextView,Buttonに代入
        quizNumberLabel.text = "第\(quizCount + 1)門"
        quizTextView.text = quizArray[0]
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)
        
        answerButton1.layer.borderWidth = 2
        answerButton1.layer.borderColor = UIColor.black.cgColor
        answerButton2.layer.borderWidth = 2
        answerButton2.layer.borderColor = UIColor.black.cgColor
        answerButton3.layer.borderWidth = 2
        answerButton3.layer.borderColor = UIColor.black.cgColor
        answerButton4.layer.borderWidth = 2
        answerButton4.layer.borderColor = UIColor.black.cgColor

        // Do any additional setup after loading the view.
    }
    
    // スコア画面に移動したときに値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctCount
    }
    
    // Buttonを押したときに呼ばれる
    @IBAction func btnAction(sender: UIButton) {
        // 正誤判定
        if sender.tag == Int(quizArray[1]) {
            correctCount += 1
            print("正解")
            // ○画像
            judgeImageView.image = UIImage(named: "correct")
            
        } else {
            print("不正解")
            // ×画像
            judgeImageView.image = UIImage(named: "incorrect")
        }
        print("スコア:\(correctCount)")
        // 2問目以降も○×を表示する
        judgeImageView.isHidden = false
        // ○×が非表示になるまでButtonを押せなくする (ダブルタップ防止)
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        // ○×を0.5秒後に非表示する
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.judgeImageView.isHidden = true
            // ○×が非表示になったらButtonを押せるようにする
            self.answerButton1.isEnabled = true
            self.answerButton2.isEnabled = true
            self.answerButton3.isEnabled = true
            self.answerButton4.isEnabled = true
            // ○×が非表示になってから次の問題をセット
            self.nextQuiz()
        }
    }
    
    // 次の問題を表示させるブロック
    func nextQuiz() {
        quizCount += 1
        if quizCount < csvArray.count {
            quizArray = csvArray[quizCount].components(separatedBy: ",")
            quizNumberLabel.text = "第\(quizCount + 1)門"
            quizTextView.text = quizArray[0]
            answerButton1.setTitle(quizArray[2], for: .normal)
            answerButton2.setTitle(quizArray[3], for: .normal)
            answerButton3.setTitle(quizArray[4], for: .normal)
            answerButton4.setTitle(quizArray[5], for: .normal)
        } else {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
    }
    
    // csvファイルを読み込むブロック
    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvDate = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
            let lineChange = csvDate.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast()
        } catch {
            print("エラー")
        }
        return csvArray
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
