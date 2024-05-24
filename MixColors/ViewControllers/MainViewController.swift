//
//  MainViewController.swift
//  MixColors
//
//  Created by Иван Семикин on 24/05/2024.
//

import UIKit

enum ColorSelection {
    case first
    case second
    case noOne
}

final class MainViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var mixedColorView: UIView!
    @IBOutlet var nameMixedColorLabel: UILabel!
    @IBOutlet var firstColorView: UIView!
    @IBOutlet var secondColorView: UIView!
    
    @IBOutlet var chooseFirstColorButton: UIButton!
    @IBOutlet var chooseSecondColorButton: UIButton!
    
    @IBOutlet var mixButton: UIButton!
    
    private let dataStore = DataStore.shared
    private let hiddenTextField = UITextField(frame: .zero)
    private let pickerView = UIPickerView()
    private var currentColor: ColorSelection = .noOne
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func chooseColorButtonAction(_ sender: UIButton) {
        currentColor = sender.tag == 0 ? .first : .second
        hiddenTextField.becomeFirstResponder()
    }
    
    @IBAction func mixButtonAction(_ sender: UIButton) {
        guard let firstColor = firstColorView.backgroundColor,
              let secondColor = secondColorView.backgroundColor else { return }

        let mixedColor = mixColors(color1: firstColor, color2: secondColor)
        
        UIView.transition(with: mixedColorView, duration: 0.5, options: .transitionCrossDissolve, animations: { [unowned self] in
            mixedColorView.backgroundColor = mixedColor
        }, completion: nil)

        UIView.transition(with: nameMixedColorLabel, duration: 0.5, options: .transitionCrossDissolve, animations: { [unowned self] in
            nameMixedColorLabel.text = nameForMixedColor(color1: firstColor, color2: secondColor)
        }, completion: nil)
    }
}

// MARK: - Private Methods
private extension MainViewController {
    func setUI() {
        mixButton.layer.cornerRadius = 10
        
        mixedColorView.setShadow()
        firstColorView.setShadow()
        secondColorView.setShadow()
        
        pickerView.delegate = self
        hiddenTextField.delegate = self
        view.addSubview(hiddenTextField)
        hiddenTextField.inputView = pickerView
        hiddenTextField.inputAccessoryView = createToolBar()
    }
    
    func createToolBar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let chooseButton = UIBarButtonItem(
            title: "Готово",
            style: .done,
            target: self,
            action: #selector(chooseButtonPressed)
        )
        
        toolbar.setItems([.flexibleSpace(), chooseButton], animated: false)
        return toolbar
    }
    
    @objc func chooseButtonPressed() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let selectedColor = dataStore.colors[selectedRow].color
        
        switch currentColor {
        case .first:
            firstColorView.backgroundColor = selectedColor
        default:
            secondColorView.backgroundColor = selectedColor
        }
        
        view.endEditing(true)
    }
    
    func mixColors(color1: UIColor, color2: UIColor) -> UIColor {
        var red1: CGFloat = 0
        var green1: CGFloat = 0
        var blue1: CGFloat = 0
        var alpha1: CGFloat = 0
        
        var red2: CGFloat = 0
        var green2: CGFloat = 0
        var blue2: CGFloat = 0
        var alpha2: CGFloat = 0
        
        color1.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        
        let red = (red1 + red2) / 2
        let green = (green1 + green2) / 2
        let blue = (blue1 + blue2) / 2
        let alpha = (alpha1 + alpha2) / 2

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func nameForMixedColor(color1: UIColor, color2: UIColor) -> String? {
        if let mix = dataStore.colorMixes.first(where: { ($0.color1 == color1 && $0.color2 == color2) || ($0.color1 == color2 && $0.color2 == color1) }) {
            print(mix.resultName)
            return mix.resultName
        }
        return nil
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataStore.colors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width, height: 30))
        
        let colorView = UIView(frame: CGRect(x: (view.bounds.width - 80) / 2, y: 5, width: 20, height: 20))
        colorView.layer.cornerRadius = 10
        colorView.backgroundColor = dataStore.colors[row].color
        colorView.clipsToBounds = false
        
        let label = UILabel(frame: CGRect(x: colorView.frame.maxX + 10, y: 0, width: 600, height: 30))
        label.text = dataStore.colors[row].name
        label.textAlignment = .left
        label.textColor = .black
        
        view.addSubview(colorView)
        view.addSubview(label)
        
        return view
    }
}
