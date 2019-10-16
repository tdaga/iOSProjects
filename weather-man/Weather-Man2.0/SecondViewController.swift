//
//  SecondViewController.swift
//  Weather-Man2.0
//
//  Created by Tanvi Daga on 4/13/19.
//  Copyright © 2019 Tanvi Daga. All rights reserved.
//

import UIKit

struct line {
    var textField : UITextField
    var switchButton : UISwitch
    var slider : UISlider
    var label : UILabel
}

struct clothing {
    var name : String
    var temperature : Double
    var precipitationType : [Precipitation]
    var type: ClothingType
    var worn: Bool
}

enum Precipitation {
    case RAIN, SNOW, SLEET
}

enum ClothingType {
    case TOP, BOTTOM, OUTERWEAR
}

var shorts = clothing.init(name: "shorts", temperature: 0, precipitationType: [], type: ClothingType.BOTTOM, worn: true);
var tshirt = clothing.init(name: "t-shirt", temperature: 0, precipitationType: [], type: ClothingType.TOP, worn: true);
var pants = clothing.init(name: "pants", temperature: 0, precipitationType: [], type: ClothingType.BOTTOM, worn: true);
var skirt = clothing.init(name: "skirt", temperature: 0, precipitationType: [], type: ClothingType.BOTTOM, worn: true);
var longSleeves = clothing.init(name: "long sleeves", temperature: 0, precipitationType: [], type: ClothingType.TOP, worn: true);
var capris = clothing.init(name: "capris", temperature: 0, precipitationType: [], type: ClothingType.BOTTOM, worn: true);
var jacket = clothing.init(name: "jacket", temperature: 0, precipitationType: [], type: ClothingType.OUTERWEAR, worn: true);
var raincoat = clothing.init(name: "raincoat", temperature: 0, precipitationType: [], type: ClothingType.OUTERWEAR, worn: true);
var hoodie = clothing.init(name: "hoodie", temperature: 0, precipitationType: [], type: ClothingType.OUTERWEAR, worn: true);


 var topList = [tshirt, longSleeves];
 var bottomList = [shorts, skirt, pants, capris];
 var outerwearList = [jacket, raincoat, hoodie];
 var preferences = [shorts, tshirt, pants, skirt, longSleeves, capris, jacket, raincoat, hoodie];

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var shortsSwitch: UISwitch!
    @IBOutlet weak var shortsSlider: UISlider!
    
    
    @IBOutlet weak var tshirtSwitch: UISwitch!
    @IBOutlet weak var tshirtSlider: UISlider!
    
    
    @IBOutlet weak var pantsSwitch: UISwitch!
    @IBOutlet weak var pantsSlider: UISlider!
    
    
    @IBOutlet weak var skirtSwitch: UISwitch!
    @IBOutlet weak var skirtSlider: UISlider!
    
    @IBOutlet weak var longSleevesSwitch: UISwitch!
    @IBOutlet weak var longSleevesSlider: UISlider!
    
    
    @IBOutlet weak var caprisSwitch: UISwitch!
    @IBOutlet weak var caprisSlider: UISlider!
    
    
    @IBOutlet weak var jacketSwitch: UISwitch!
    @IBOutlet weak var jacketSlider: UISlider!
    
    @IBOutlet weak var raincoatSwitch: UISwitch!
    @IBOutlet weak var raincoatSlider: UISlider!
    
    @IBOutlet weak var hoodieSwitch: UISwitch!
    @IBOutlet weak var hoodieSlider: UISlider!
    
    @IBOutlet weak var otherTF1: UITextField!
    @IBOutlet weak var otherLabel1: UILabel!
    @IBOutlet weak var switchOther1: UISwitch!
    @IBOutlet weak var sliderOther1: UISlider!
    
    @IBOutlet weak var otherTF2: UITextField!
    @IBOutlet weak var otherLabel2: UILabel!
    @IBOutlet weak var switchOther2: UISwitch!
    @IBOutlet weak var sliderOther2: UISlider!
    
    
    @IBOutlet weak var otherTF3: UITextField!
    @IBOutlet weak var otherLabel3: UILabel!
    @IBOutlet weak var switchOther3: UISwitch!
    @IBOutlet weak var sliderOther3: UISlider!
    
    
    @IBOutlet weak var otherTF4: UITextField!
    @IBOutlet weak var otherLabel4: UILabel!
    @IBOutlet weak var switchOther4: UISwitch!
    @IBOutlet weak var sliderOther4: UISlider!
    
    
    @IBOutlet weak var tempVal: UILabel!
//    var shorts: clothing
//    var tshirt: clothing
//    var pants: clothing
//    var skirt: clothing
//    var longSleeves: clothing
//    var capris: clothing
//    var jacket: clothing
//    var raincoat: clothing
//    var hoodie: clothing
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: self.view.frame.width - 100, height: self.view.frame.height + 50);
        scrollView.isScrollEnabled = true
        // Do any additional setup after loading the view.
        let line1 = line.init(textField: otherTF1, switchButton: switchOther1, slider: sliderOther1, label: otherLabel1)
        let line2 = line.init(textField: otherTF2, switchButton: switchOther2, slider: sliderOther2, label: otherLabel2)
        let line3 = line.init(textField: otherTF3, switchButton: switchOther3, slider: sliderOther3, label: otherLabel3)
        let line4 = line.init(textField: otherTF4, switchButton: switchOther4, slider: sliderOther4, label: otherLabel4)
        var buttonList = [line1, line2, line3, line4]
        for num in 1...buttonList.count - 1 {
            buttonList[num].textField.isHidden = true
            buttonList[num].switchButton.isHidden = true
            buttonList[num].slider.isHidden = true
            buttonList[num].label.isHidden = true
        }
        let sliderList = [shortsSlider, tshirtSlider, pantsSlider, skirtSlider, longSleevesSlider, caprisSlider, jacketSlider, hoodieSlider, raincoatSlider, sliderOther1, sliderOther2, sliderOther3, sliderOther4]
        for slider in sliderList {
            slider?.maximumValue = 100
            slider?.minimumValue = 0
            slider?.value = 0;
        }
    }
    
    func updatePreferences(newClothing: clothing) {
        for ind in 0...(preferences.count - 1) {
            let clothing = preferences[ind]
            if (clothing.name == newClothing.name) {
                preferences[ind] = newClothing
            }
        }
        var topListTemp:[clothing] = []
        var bottomListTemp: [clothing] = []
        var outerListTemp: [clothing] = []
        for clothing in preferences {
            if (clothing.type == ClothingType.TOP) {
                topListTemp.append(clothing)
            } else if (clothing.type == ClothingType.BOTTOM) {
                bottomListTemp.append(clothing)
            } else if (clothing.type == ClothingType.OUTERWEAR) {
                outerListTemp.append(clothing)
            }
        }
        topList = topListTemp
        bottomList = bottomListTemp
        outerwearList = outerListTemp
    }
    
   
    
    
    @IBAction func shortsSliderChanged(_ sender: Any) {
        tempVal.text = String(shortsSlider.value.rounded())
        shorts.temperature = Double(shortsSlider.value.rounded())
        updatePreferences(newClothing: shorts)
    }
    
    @IBAction func shortsSwitchToggled(_ sender: Any) {
        if (shortsSwitch.isOn) {
            shorts.worn = true
        } else {
            shorts.worn = false
        }
        updatePreferences(newClothing: shorts)
    }
    @IBAction func tshirtSliderChanged(_ sender: Any) {
        tempVal.text = String(tshirtSlider.value.rounded())
        tshirt.temperature = Double(tshirtSlider.value.rounded())
        updatePreferences(newClothing: tshirt)
    }
    
    @IBAction func tShirtSwitchToggled(_ sender: Any) {
        if (tshirtSwitch.isOn) {
            tshirt.worn = true;
        } else {
            tshirt.worn = false;
        }
        updatePreferences(newClothing: tshirt)
    }
    
    @IBAction func pantsSwitchToggled(_ sender: Any) {
        if (pantsSwitch.isOn) {
            pants.worn = true;
        } else {
            pants.worn = false;
        }
        updatePreferences(newClothing: pants)
        
    }
    @IBAction func pantsSliderChanged(_ sender: Any) {
        tempVal.text = String(pantsSlider.value.rounded())
        pants.temperature = Double(pantsSlider.value.rounded())
        updatePreferences(newClothing: pants)
    }
    
    
    @IBAction func skirtSliderChanged(_ sender: Any) {
        tempVal.text = String(skirtSlider.value.rounded())
        skirt.temperature = Double(skirtSlider.value.rounded())
        updatePreferences(newClothing: skirt)
    }
    
    @IBAction func skirtSwitchToggled(_ sender: Any) {
        if (skirtSwitch.isOn) {
            skirt.worn = true;
        } else {
            skirt.worn = false;
        }
        updatePreferences(newClothing: skirt)
    }
    
    @IBAction func longsleevesSliderChanged(_ sender: Any) {
        tempVal.text = String(longSleevesSlider.value.rounded())
        longSleeves.temperature = Double(longSleevesSlider.value.rounded())
        updatePreferences(newClothing: longSleeves)
    }
    
    
    @IBAction func longsleevesSwitchToggled(_ sender: Any) {
        if (longSleevesSwitch.isOn) {
            longSleeves.worn = true
        } else {
            longSleeves.worn = false
        }
        updatePreferences(newClothing: longSleeves)
    }
    
    @IBAction func caprisSliderChanged(_ sender: Any) {
        tempVal.text = String(caprisSlider.value.rounded())
        capris.temperature = Double(caprisSlider.value.rounded())
        updatePreferences(newClothing: capris)
    }
    
    @IBAction func caprisSwitchToggled(_ sender: Any) {
        if (caprisSwitch.isOn) {
            longSleeves.worn = true
        } else {
            longSleeves.worn = false
        }
        updatePreferences(newClothing: capris)
    }
    
    @IBAction func jacketSliderChanged(_ sender: Any) {
        tempVal.text = String(jacketSlider.value.rounded())
        jacket.temperature = Double(jacketSlider.value.rounded())
        updatePreferences(newClothing: jacket)
    }
    
    @IBAction func jacketSwitchToggled(_ sender: Any) {
        if (jacketSwitch.isOn) {
            jacket.worn = true
        } else {
            jacket.worn = false
        }
        updatePreferences(newClothing: jacket)
    }
    
    @IBAction func raincoatSliderChanged(_ sender: Any) {
        tempVal.text =
            String(raincoatSlider.value.rounded())
        raincoat.temperature =
            Double(raincoatSlider.value.rounded())
        updatePreferences(newClothing: raincoat)
    }
    
    @IBAction func raincoatSwitchToggled(_ sender: Any) {
        if (raincoatSwitch.isOn) {
            raincoat.worn = true
        } else {
            raincoat.worn = false
        }
        updatePreferences(newClothing: raincoat)
    }
    
    
    @IBAction func hoodieSliderChanged(_ sender: Any) {
        tempVal.text = String(hoodieSlider.value.rounded())
        hoodie.temperature =
            Double(hoodieSlider.value.rounded())
        updatePreferences(newClothing: hoodie)
    }
    
    @IBAction func hoodieSwitchToggled(_ sender: Any) {
        if (hoodieSwitch.isOn) {
            hoodie.worn = true
        } else {
            hoodie.worn = false
        }
        updatePreferences(newClothing: hoodie)
    }
    
    
    
    @IBAction func sliderOther1Changed(_ sender: Any) {
        tempVal.text = String(sliderOther1.value.rounded())
    }
    
    
    @IBAction func sliderOther2Changed(_ sender: Any) {
    tempVal.text = String(sliderOther2.value.rounded())
    }
    
    
    @IBAction func sliderOther3Changed(_ sender: Any) {
    tempVal.text = String(sliderOther3.value.rounded())
    }
    
    @IBAction func sliderOther4Changed(_ sender: Any) {
    tempVal.text = String(sliderOther4.value.rounded())
    }
    
}
