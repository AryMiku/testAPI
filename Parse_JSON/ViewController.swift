//
//  ViewController.swift
//  Parse_JSON
//
//  Created by Admin on 26/3/2562 BE.
//  Copyright © 2562 AryMiku. All rights reserved.
//

import UIKit

struct Country:Decodable{
    let Title : String
    let Year: String
    let Poster : String
    let Ratings: [Ratings]
}

struct Ratings:Decodable{
    let Source : String
    let Value : String
}

class ViewController: UIViewController {

    @IBOutlet weak var datatext: UITextField!
    @IBOutlet weak var moviepic: UIImageView!
    @IBOutlet weak var namemovie: UILabel!
    @IBOutlet weak var yearmovie: UILabel!
    @IBOutlet weak var ratemovie: UILabel!
    @IBAction func datasent(_ sender: Any) {
        print(datatext.text)
        let aString = datatext.text
        var picturelink = ""
        var name = ""
        var year = ""
        var rateing = ""
        let newString = aString!.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        print(newString)
        let url = "http://www.omdbapi.com/?apikey=BanMePlz&t=\(newString)"
        let urlObj = URL(string:url)
        //print (urlObj)
        URLSession.shared.dataTask(with:urlObj!){(data,response,error) in
            do{
                let countries = try JSONDecoder().decode(Country.self,from:data!)
                //for country in countries{
                picturelink = countries.Poster
                name = countries.Title
                year = countries.Year
                rateing = countries.Ratings[0].Value
                print(countries.Poster)
                print(countries.Ratings[0].Value)
                
                //}
            }catch{
                print (error)
            }
            }.resume()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if(picturelink == "") {
                picturelink = "https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png"
            }
            let picter = URL(string: picturelink)
            let data = try? Data(contentsOf: picter!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            self.moviepic.image = UIImage(data: data!)
            self.namemovie.text = name
            self.yearmovie.text = year
            self.ratemovie.text = rateing
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        let url = "http://www.omdbapi.com/?t=fate+grand&apikey=BanMePlz"
//        let urlObj = URL(string:url)
//        URLSession.shared.dataTask(with:urlObj!){(data,response,error) in
//            do{
//                let countries = try JSONDecoder().decode(Country.self,from:data!)
//                //for country in countries{
//                    //print(country.Title)
//                print(countries.Ratings[0].Source)
//                //}
//            }catch{
//                print (error)
//            }
//        }.resume()
    }


}

