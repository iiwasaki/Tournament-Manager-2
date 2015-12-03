//
//  Match.swift
//  Tournament Manager 2
//
//  Created by Macbook on 11/15/15.
//  Copyright © 2015 Arturo Bustamante. All rights reserved.
//

import Foundation
import CoreData

//class for a match data type that will be used in a bracket tree

class Match: NSManagedObject {
    
    //set the winning bracket progression
    func assignWinner(){
        if currentBracket?.singleElim == true {
            if (Int(matchNumber!) < 62){
                let div = Int(matchNumber!)/2
                next_winner = matches[div + 32]
            }
        }
        else{
            //double elimination winners 
            if (Int(matchNumber!) < 62){
                let div = Int(matchNumber!)/2
                next_winner = matches[div + 32]
                
            }
            else if (Int(matchNumber!) >= 63 && Int(matchNumber!) <= 78){
                next_winner = matches[Int(matchNumber!) + 16]
            }
            else if (Int(matchNumber!) >= 79 && Int(matchNumber!) <= 94){
                if(Int(matchNumber!)%2 == 0){
                    let temp = (Double(Int(matchNumber!))-0.5)/2
                    next_winner = matches[Int(temp) + 56]
                }
                else{
                    next_winner = matches[(Int(matchNumber!)/2) + 56]
                }
                
            }
            else if (Int(matchNumber!) >= 95 && Int(matchNumber!) <= 102){
                next_winner = matches[Int(matchNumber!) + 8]
            }
            else if (Int(matchNumber!) >= 103 && Int(matchNumber!) <= 110){
                if(Int(matchNumber!)%2 == 0){
                    let temp = (Double(Int(matchNumber!))-0.5)/2
                    next_winner = matches[Int(temp) + 60]
                }
                else{
                    next_winner = matches[(Int(matchNumber!)/2) + 60]
                }
            }
            else if (Int(matchNumber!) >= 111 && Int(matchNumber!) <= 114){
                next_winner = matches[Int(matchNumber!) + 4]
            }
            else if (Int(matchNumber!) >= 115 && Int(matchNumber!) <= 118){
                if(Int(matchNumber!)%2 == 0){
                    let temp = (Double(Int(matchNumber!))-0.5)/2
                    next_winner = matches[Int(temp) + 62]
                }
                else{
                    next_winner = matches[(Int(matchNumber!)/2) + 62]
                }
            }
            else if (Int(matchNumber!) >= 119 && Int(matchNumber!) <= 120) {
                next_winner = matches[Int(matchNumber!) + 2]
            }
            else if (Int(matchNumber!) >= 121 && Int(matchNumber!) <= 122){
                next_winner = matches[123]
            }
            else if (Int(matchNumber!) >= 123 && Int(matchNumber!) <= 125){
                //123 and above till 125
                next_winner = matches[Int(matchNumber!) + 1]
            }
            else{
                // final bracket
                next_winner = nil
            }
        }
    }
    
    
    //set the losing bracket progression
    func assignLoser(){
        if currentBracket?.singleElim == true{
            next_loser = nil
        }
        else {
            //double elimination, set the losers
            //program in the next loser bracket number
            if (Int(matchNumber!) >= 0 && Int(matchNumber!) <= 31){
                let div = Int(matchNumber!)/2
                next_loser = matches[div + 63]
            }
            else if (Int(matchNumber!) >= 32 && Int(matchNumber!) <= 47){
                let temp = Int(matchNumber!)-32
                let mult = temp * 2
                let additiveFactor = 62-mult
                next_loser = matches[Int(matchNumber!) + additiveFactor]
            }
            else if (Int(matchNumber!) >= 48 && Int(matchNumber!) <= 51){
                let temp = Int(matchNumber!)-48
                let mult = temp * 2
                let additiveFactor = 58-mult
                next_loser = matches[Int(matchNumber!) + additiveFactor]
            }
            else if (Int(matchNumber!) >= 52 && Int(matchNumber!) <= 55){
                let temp = Int(matchNumber!)-52
                let mult = temp * 2
                let additiveFactor = 58-mult
                next_loser = matches[Int(matchNumber!) + additiveFactor]
            }
            else if (Int(matchNumber!) >= 56 && Int(matchNumber!) <= 57){
                next_loser = matches[Int(matchNumber!) + 61]
            }
            else if (Int(matchNumber!) >= 58 && Int(matchNumber!) <= 59){
                next_loser = matches[Int(matchNumber!) + 57]
            }
            else if (Int(matchNumber!) >= 60 && Int(matchNumber!) <= 61){
                next_loser = matches[Int(matchNumber!) + 61]
            }
            else if (Int(matchNumber!) == 62){
                next_loser = matches[124]
            }
            else if (Int(matchNumber!) == 125){
                next_loser = matches[126]
            }
            else {
                next_loser = nil
            }

        }
    }
    
    func advanceWinnersInitial(){
        if (hasBye == 1){
            //P1 is a BYE 
            if Int(matchNumber!) < 63 {
                if(Int(matchNumber!)%2 == 0){
                    next_winner?.player1 = player2
                    next_winner?.refreshByes()
                    next_loser?.hasBye = Int((next_loser?.hasBye)!) + 1
                }
                else {
                    next_winner?.player2 = player2
                    next_winner?.refreshByes()
                    next_loser?.hasBye = Int((next_loser?.hasBye)!) + 2
                }
            }
            else if (Int(matchNumber!) >= 63 && Int(matchNumber!) <= 78){
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2
            }
            else if (Int(matchNumber!) >= 79 && Int(matchNumber!) <= 94){
                if(Int(matchNumber!)%2 == 1) {
                    next_winner?.player1 = player2
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

                }
                else{
                    next_winner?.player2 = player2
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1
                }
            }
            else if (Int(matchNumber!) >= 95 && Int(matchNumber!) <= 102){
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2
            }
            else if (Int(matchNumber!) >= 103 && Int(matchNumber!) <= 110){
                if(Int(matchNumber!)%2 == 1) {
                    next_winner?.player1 = player2
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2
                }
                else{
                    next_winner?.player2 = player2
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1
                }
            }
            else if (Int(matchNumber!) >= 111 && Int(matchNumber!) <= 114){
                next_winner?.player1 = player2
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

            }
            else if (Int(matchNumber!) >= 115 && Int(matchNumber!) <= 118) {
                if(Int(matchNumber!)%2 == 1) {
                    next_winner?.player1 = player2
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2
                }
                else{
                    next_winner?.player2 = player2
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1

                }
            }
            else if (Int(matchNumber!) >= 119 && Int(matchNumber!) <= 120){
                next_winner?.player1 = player2
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

            }
            else if (Int(matchNumber!) == 121){
                next_winner?.player1 = player2
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1

            }
            else if (Int(matchNumber!) == 122){
                next_winner?.player2 = player2
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

            }
            else if (Int(matchNumber!) == 123){
                next_winner?.player1 = player2
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

            }
            else if (Int(matchNumber!) == 124){
                next_winner?.player2 = player2
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1

            }
            else if (Int(matchNumber!) == 125){
                next_winner?.player2 = player2
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1
            }
            else {
                print("Error resolving bye 1")
            }
        }
        else if (hasBye == 2){
            //P2 is a BYE
            if Int(matchNumber!) < 63 {
                if(Int(matchNumber!)%2 == 0){
                    next_winner?.player1 = player1
                    next_winner?.refreshByes()
                    next_loser?.hasBye = Int((next_loser?.hasBye)!) + 1
                }
                else {
                    next_winner?.player2 = player1
                    next_winner?.refreshByes()
                    next_loser?.hasBye = Int((next_loser?.hasBye)!) + 2
                }
                
            }
            else if (Int(matchNumber!) >= 63 && Int(matchNumber!) <= 78){
                next_winner?.player1 = player1
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2
            }
            else if (Int(matchNumber!) >= 79 && Int(matchNumber!) <= 94){
                if(Int(matchNumber!)%2 == 1) {
                    next_winner?.player1 = player1
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

                }
                else{
                    next_winner?.player2 = player1
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1

                }
            }
            else if (Int(matchNumber!) >= 95 && Int(matchNumber!) <= 102){
                next_winner?.player1 = player1
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

            }
            else if (Int(matchNumber!) >= 103 && Int(matchNumber!) <= 110){
                if(Int(matchNumber!)%2 == 1) {
                    next_winner?.player1 = player1
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

                }
                else{
                    next_winner?.player2 = player1
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1
                }
            }
            else if (Int(matchNumber!) >= 111 && Int(matchNumber!) <= 114){
                next_winner?.player1 = player1
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

            }
            else if (Int(matchNumber!) >= 115 && Int(matchNumber!) <= 118) {
                if(Int(matchNumber!)%2 == 1) {
                    next_winner?.player1 = player1
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2
                }
                else{
                    next_winner?.player2 = player1
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1

                }
            }
            else if (Int(matchNumber!) >= 119 && Int(matchNumber!) <= 120){
                next_winner?.player1 = player1
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

            }
            else if (Int(matchNumber!) == 121){
                next_winner?.player1 = player1
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1

            }
            else if (Int(matchNumber!) == 122){
                next_winner?.player2 = player1
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

            }
            else if (Int(matchNumber!) == 123){
                next_winner?.player1 = player1
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

            }
            else if (Int(matchNumber!) == 124){
                next_winner?.player2 = player1
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1

            }
            else if (Int(matchNumber!) == 125){
                next_winner?.player2 = player1
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1

            }
            else {
                print("Error resolving bye 1")
            }
        }
        else if (hasBye == 3){
            //Both are BYES - empty match
            if Int(matchNumber!) < 63 {
                if(Int(matchNumber!)%2 == 0){
                    next_winner?.player1 = nil
                    next_winner?.refreshByes()
                    //next_loser?.hasBye = Int((next_loser?.hasBye)!) + 2

                }
                else {
                    next_winner?.player2 = nil
                    next_winner?.refreshByes()
                    //next_loser?.hasBye = Int((next_loser?.hasBye)!) + 2
                }
            }
            else if (Int(matchNumber!) >= 63 && Int(matchNumber!) <= 78){
                next_winner?.player1 = nil
                //next_winner?.hasBye = Int((next_winner?.hasBye)!) + 1
            }
            else if (Int(matchNumber!) >= 79 && Int(matchNumber!) <= 94){
                if(Int(matchNumber!)%2 == 1) {
                    next_winner?.player1 = nil
                   // next_winner?.hasBye = Int((next_winner?.hasBye)!) + 1

                }
                else{
                    next_winner?.player2 = nil
                   // next_winner?.hasBye = Int((next_winner?.hasBye)!) + 2

                }
            }
            else if (Int(matchNumber!) >= 95 && Int(matchNumber!) <= 102){
                next_winner?.player1 = nil
               // next_winner?.hasBye = Int((next_winner?.hasBye)!) + 1

            }
            else if (Int(matchNumber!) >= 103 && Int(matchNumber!) <= 110){
                if(Int(matchNumber!)%2 == 1) {
                    next_winner?.player1 = nil
                 //   next_winner?.hasBye = Int((next_winner?.hasBye)!) + 1

                }
                else{
                    next_winner?.player2 = nil
                //    next_winner?.hasBye = Int((next_winner?.hasBye)!) + 2

                }
            }
            else if (Int(matchNumber!) >= 111 && Int(matchNumber!) <= 114){
                next_winner?.player1 = nil
             //   next_winner?.hasBye = Int((next_winner?.hasBye)!) + 1

            }
            else if (Int(matchNumber!) >= 115 && Int(matchNumber!) <= 118) {
                if(Int(matchNumber!)%2 == 1) {
                    next_winner?.player1 = nil
              //      next_winner?.hasBye = Int((next_winner?.hasBye)!) + 1

                }
                else{
                    next_winner?.player2 = nil
              //      next_winner?.hasBye = Int((next_winner?.hasBye)!) + 2

                }
            }
            else if (Int(matchNumber!) >= 119 && Int(matchNumber!) <= 120){
                next_winner?.player1 = nil
             //   next_winner?.hasBye = Int((next_winner?.hasBye)!) + 1

            }
            else if (Int(matchNumber!) == 121){
                next_winner?.player1 = nil
          //      next_winner?.hasBye = Int((next_winner?.hasBye)!) + 1

            }
            else if (Int(matchNumber!) == 122){
                next_winner?.player2 = nil
        //        next_winner?.hasBye = Int((next_winner?.hasBye)!) + 2

            }
            else if (Int(matchNumber!) == 123){
                next_winner?.player1 = nil
        //        next_winner?.hasBye = Int((next_winner?.hasBye)!) + 1

            }
            else if (Int(matchNumber!) == 124){
                next_winner?.player2 = nil
        //        next_winner?.hasBye = Int((next_winner?.hasBye)!) + 2

            }
            else if (Int(matchNumber!) == 125){
                next_winner?.player2 = nil
       //         next_winner?.hasBye = Int((next_winner?.hasBye)!) + 2

            }
            else if (Int(matchNumber!) == 126){
                
            }
            else {
                print("Error resolving bye 1")
            }
        }
        else{
            if Int(matchNumber!) < 63 {
                if(Int(matchNumber!)%2 == 0){
                    next_winner?.hasBye = 0
                    next_loser?.hasBye = Int((next_loser?.hasBye)!) - 1
                }
                else {
                    next_winner?.hasBye = 0
                    next_loser?.hasBye = Int((next_loser?.hasBye)!) - 1
                }
            }
            else {
                
            }

        }
    }
    
    func refreshByes(){
        if player1 == nil && player2 == nil {
            hasBye = 3
        }
        else if player1 != nil && player2 == nil{
            hasBye = 2
        }
        else if player1 == nil && player2 != nil {
            hasBye = 1
        }
        else {
            hasBye = 0
        }
    }
    
}