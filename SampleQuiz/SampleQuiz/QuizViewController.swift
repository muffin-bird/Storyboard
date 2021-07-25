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
    
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // csvArrayに代入(csvファイル)
        csvArray = loadCSV(fileName: "quiz")
        print(csvArray)
        
        // quizArrayに1問文のデータを代入
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        
        // Label,TextView,Buttonに代入
        

        // Do any additional setup after loading the view.
    }
    
    // Buttonを押したときに呼ばれる
    @IBAction func btnAction(sender: UIButton) {
        print(sender.tag)
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
