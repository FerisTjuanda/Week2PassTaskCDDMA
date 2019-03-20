//
//  main.swift
//  week2PassTask
//
//  Created by FERIS TJUANDA on 18/3/19.
//  Copyright © 2019 FERIS TJUANDA. All rights reserved.
//
import Foundation


//TASK 1.1
print("-------------------TASK 1.1---------------------")

print("What's your name?")
var myName = "feris"
var check : Bool = false
//let name = readLine()
while(!check){
    if let name = readLine(){
        if(name == ""){
            print("Please enter your name!")
        }else if (name == myName){
            print("Awesome name!")
            check = true
        }else{
            print(name + " is a", terminator: " ")
            for _ in 1...100 {
                print("silly ", terminator: " ")
            }
            print("name")
            check = true
        }
    }
        
}


print(" ")
print("-------------------TASK 1.2---------------------")


//TASK 1.2
struct Profile{
    let firstName: String
    let lastName: String
    let age: Int?
}


func validate(firstName: String, lastName: String, age: Int?) -> Profile? {
    guard let ag = age else{
        print ("Please enter your age!")
        return nil
    }
    
    guard (age! >= 18 && age! < 999) else{
        print("You have to be older than 18 and younger than 999 years old!")
        return nil
    }
    
    return  Profile(firstName: firstName,lastName: lastName, age: Int(ag))
}
print ("")
print("Please enter your first name : ")
let first = readLine()
print("Please enter your last name : ")
let last = readLine()
print("Please enter your age : ")
let agee = readLine()
let profileOne = validate(firstName: first!, lastName: last!, age: Int(agee!))
print(profileOne!)


//Task 2.1
struct Cat{
    let name: String
    //: - Note: nil to represent that cat is in a super-position, true and false means the cat is alive and not respectively.
    var isAlive: Bool?
    
}

protocol Explosive {
    //: - TODO: when detonated, the explosives should go off 50% of the time
    //var hasExplode: Bool {get set}
    func detonate () -> Bool
}

struct Explode: Explosive {
    //50% chance for the explosive to explode
    func detonate () -> Bool {
        let probability = Int.random(in:0...1)
        if(probability == 1){
            return true; // explode
        }else{
            return false // nope
        }
    }
}

protocol Bunker {
    //: - TODO: when initialising cat's `isAlive` should be set to nil, to represent that cat is in a super-position
    init(occupent: Cat, explosive: Explosive)
    
    var occupent: Cat { get set }
    var explosive: Explosive { get }
    
    //: - TODO: By the mere action of opening the bunker door, determines the state of the cat's life.
    func open()
}

class Bunkers: Bunker {
    var bunkerOcc : Cat
    var bunkerEx : Explosive
    
    required init (occupent: Cat, explosive: Explosive){
        bunkerOcc = occupent
        bunkerEx = explosive
    }
    
    var occupent: Cat {
        get {
            return bunkerOcc
        }
        set (newBunkerOcc) {
            bunkerOcc.isAlive = newBunkerOcc.isAlive
        }
        
    }
    
    var explosive: Explosive {
        get {
            return bunkerEx
        }
    }

    func open(){
        
        // CHECK WHETHER THE BUNKER EXPLODE OR NOT
        // if the tnt explode (return true) = cat will die, so basically "true" detonate is equal to "false" cat.isAlive
        self.occupent = Cat(name: self.bunkerOcc.name, isAlive: !explosive.detonate())
        if(bunkerOcc.isAlive!){
            print("The TNT did not explode")
            print("It's alive!!!")
        }else{
            print("The TNT exploded!")
            print("Oh no :(")
        }
        
    }
}

protocol DangerousBunker {
    
    init(occupent: Cat, explosives: [Explosive])
    var occupent: Cat {get set}
    var explosives: [Explosive] {get}
    
    func open()
    
}

class DangBunker : DangerousBunker {
    
    var dangBunkerOcc : Cat
    var dangBunkerExploArr : [Explosive]
    
    required init(occupent: Cat, explosives: [Explosive]) {
        dangBunkerOcc = occupent
        dangBunkerExploArr = explosives
    }
    
    var occupent : Cat {
        
        get{
        
            return dangBunkerOcc
            
        }set (newDangBunkerOcc){
            
            dangBunkerOcc.isAlive = newDangBunkerOcc.isAlive
    
        }
        
    }
    
    var explosives: [Explosive] {
        get {
            return dangBunkerExploArr
        }
        
    }
    
    func open() {
        //var isExplode : Bool = false;
        var index = 1;
        for explosion in dangBunkerExploArr {
            // if one of the tnt explode (return true) = cat will die, so basically "true" detonate is equal to "false" cat.isAlive.
            // does not need to check the other explosives if one of the tnt already exploded.
            self.occupent = Cat(name: self.dangBunkerOcc.name, isAlive: !explosion.detonate())
            if(dangBunkerOcc.isAlive!){
                print("TNT number \(index) did not explode")
                print("It's alive!!!")
            }else{
                print("TNT number \(index) exploded!!")
                print("Oh no :(")
                break;
            }
            index += 1;
        }
    }
    
}



func checkIfTheCatIsAlive(cat: Cat) {
    // TODO: if the cat is alive, print "Its alive!!! 😸"
    // TODO: if the cat is dead, print "Oh no 😿"
    // TODO: if the cat is neither alive nor dead, print "Its cat-tum superposition! 🤷‍♂️😼"
    guard let alive = cat.isAlive else{
        print("It's cat-tum superposition")
        return
    }
    
    if(alive){
        print("Its alive!!!")
    }else {
        print("Oh no")
    }
}

//TASK 2.2
print("")
print("-------------------TASK 2.2---------------------")
print("")
var bunkerr = Bunkers(occupent: Cat(name: "Jellie", isAlive: nil), explosive: Explode())
checkIfTheCatIsAlive(cat: bunkerr.occupent)
bunkerr.open()

//TASK 2.3
print("")
print("-------------------TASK 2.3---------------------")
print("")
var explosivesArr = [Explode]()
explosivesArr.append(Explode())
explosivesArr.append(Explode())
explosivesArr.append(Explode())
explosivesArr.append(Explode())
explosivesArr.append(Explode())
var dangBunker = DangBunker(occupent : Cat(name:"Jennie", isAlive: nil),explosives: explosivesArr)
checkIfTheCatIsAlive(cat: dangBunker.dangBunkerOcc)
dangBunker.open()


