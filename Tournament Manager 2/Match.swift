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
            else if (Int(matchNumber!) == 62){
                next_winner = matches[125]
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
                    next_loser?.hasBye = Int((next_loser?.hasBye)!) + 1
                }
            }
            else if (Int(matchNumber!) >= 63 && Int(matchNumber!) <= 78){
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2
            }
            else if (Int(matchNumber!) >= 79 && Int(matchNumber!) <= 94){
                if(Int(matchNumber!)%2 == 1) {
                    next_winner?.player1 = player2
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1

                }
                else{
                    next_winner?.player2 = player2
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2
                }
            }
            else if (Int(matchNumber!) >= 95 && Int(matchNumber!) <= 102){
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2
            }
            else if (Int(matchNumber!) >= 103 && Int(matchNumber!) <= 110){
                if(Int(matchNumber!)%2 == 1) {
                    next_winner?.player1 = player2
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1
                }
                else{
                    next_winner?.player2 = player2
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2
                }
            }
            else if (Int(matchNumber!) >= 111 && Int(matchNumber!) <= 114){
                next_winner?.player1 = player2
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

            }
            else if (Int(matchNumber!) >= 115 && Int(matchNumber!) <= 118) {
                if(Int(matchNumber!)%2 == 1) {
                    next_winner?.player1 = player2
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1
                }
                else{
                    next_winner?.player2 = player2
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

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
                    next_loser?.hasBye = Int((next_loser?.hasBye)!) + 1
                }
                
            }
            else if (Int(matchNumber!) >= 63 && Int(matchNumber!) <= 78){
                next_winner?.player1 = player1
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2
            }
            else if (Int(matchNumber!) >= 79 && Int(matchNumber!) <= 94){
                if(Int(matchNumber!)%2 == 1) {
                    next_winner?.player1 = player1
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1

                }
                else{
                    next_winner?.player2 = player1
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

                }
            }
            else if (Int(matchNumber!) >= 95 && Int(matchNumber!) <= 102){
                next_winner?.player1 = player1
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

            }
            else if (Int(matchNumber!) >= 103 && Int(matchNumber!) <= 110){
                if(Int(matchNumber!)%2 == 1) {
                    next_winner?.player1 = player1
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1

                }
                else{
                    next_winner?.player2 = player1
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2
                }
            }
            else if (Int(matchNumber!) >= 111 && Int(matchNumber!) <= 114){
                next_winner?.player1 = player1
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

            }
            else if (Int(matchNumber!) >= 115 && Int(matchNumber!) <= 118) {
                if(Int(matchNumber!)%2 == 1) {
                    next_winner?.player1 = player1
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 1
                }
                else{
                    next_winner?.player2 = player1
                    next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2

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
            if Int(matchNumber!) < 32 {
                if(Int(matchNumber!)%2 == 0){
                    next_winner?.hasBye = 0
                    next_loser?.hasBye = Int((next_loser?.hasBye)!) - 1
                }
                else {
                    next_winner?.hasBye = 0
                    next_loser?.hasBye = Int((next_loser?.hasBye)!) - 2
                }
            }
            else if (Int(matchNumber!) >= 32 && Int(matchNumber!) <= 62){
                next_winner?.hasBye = 0
                next_loser?.hasBye = Int((next_loser?.hasBye)!) - 1
            }
            else if (Int(matchNumber!) >= 63 && Int(matchNumber!) <= 78){
                next_winner?.player1 = nil
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2
            }
            else if (Int(matchNumber!) >= 95 && Int(matchNumber!) <= 102){
                next_winner?.player1 = nil
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2
            }
            else if (Int(matchNumber!) >= 111 && Int(matchNumber!) <= 114){
                next_winner?.player1 = nil
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2
            }
            else if (Int(matchNumber!) >= 119 && Int(matchNumber!) <= 120){
                next_winner?.player1 = nil
                next_winner?.hasBye = Int((next_winner?.hasBye)!) - 2
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
    
    
    func resolveWinLoss(winner: Participant, loser: Participant){
        
        if currentBracket?.singleElim == true {
            if lastMatch == true{
                currentBracket?.winner = winner
                winner.wins = Int(winner.wins!) + 1
                loser.losses = Int(loser.losses!) + 1
                currentBracket?.active = 2
                assignRank(Int(matchNumber!), loser: loser)
                loser.result_bracket = currentBracket
                results.append(loser)
                winner.rank = 1
                winner.result_bracket = currentBracket
                results.append(winner)
            }
            else{
                if Int(matchNumber!)%2==0{
                    next_winner?.player1 = winner
                    winner.wins = Int(winner.wins!) + 1
                    loser.losses = Int(loser.losses!) + 1
                    assignRank(Int(matchNumber!), loser: loser)
                    loser.result_bracket = currentBracket
                    results.append(loser)
                }
                else {
                    next_winner?.player2 = winner
                    winner.wins = Int(winner.wins!) + 1
                    loser.losses = Int(loser.losses!) + 1
                    assignRank(Int(matchNumber!), loser: loser)
                    loser.result_bracket = currentBracket
                    results.append(loser)
                }
            }
            inProgress = 2
        }
        else {
            //double elim 
            if lastMatch == true{
                currentBracket?.winner = winner
                winner.wins = Int(winner.wins!) + 1
                currentBracket?.active = 2
                loser.losses = Int(loser.losses!) + 1
                assignRank(Int(matchNumber!), loser: loser)
                loser.result_bracket = currentBracket
                results.append(loser)
                winner.rank = 1
                winner.result_bracket = currentBracket
                results.append(winner)
            }
            else if Int(matchNumber!) == 125 {
                if Int(loser.losses!) == 1{
                    //tournament done 
                    winner.wins = Int(winner.wins!) + 1
                    currentBracket?.winner = winner
                    currentBracket?.active = 2
                    next_winner?.hasBye = 3
                    loser.losses = Int(loser.losses!) + 1
                    assignRank(Int(matchNumber!), loser: loser)
                    loser.result_bracket = currentBracket
                    results.append(loser)
                    winner.rank = 1
                    winner.result_bracket = currentBracket
                    results.append(winner)
                }
                else {
                    next_winner?.player1 = loser
                    next_winner?.player2 = winner
                    winner.wins = Int(winner.wins!) + 1
                    loser.losses = Int(loser.losses!) + 1
                }
            }
            else if Int(matchNumber!) >= 0 && Int(matchNumber!) <= 31 {
                //first loss in winner bracket
                if Int(matchNumber!)%2 == 0{
                    winner.wins = Int(winner.wins!) + 1
                    loser.losses = Int(loser.losses!) + 1
                    next_winner?.player1 = winner
                    next_loser?.player1 = loser
                }
                else {
                    winner.wins = Int(winner.wins!) + 1
                    loser.losses = Int(loser.losses!) + 1
                    next_winner?.player2 = winner
                    next_loser?.player2 = loser
                }
            }
            else if Int(matchNumber!) >= 32 && Int(matchNumber!) <= 61{
                if Int(matchNumber!)%2 == 0{
                    winner.wins = Int(winner.wins!) + 1
                    loser.losses = Int(loser.losses!) + 1
                    next_winner?.player1 = winner
                    next_loser?.player2 = loser
                    next_loser?.resolveByes()
                }
                else {
                    winner.wins = Int(winner.wins!) + 1
                    loser.losses = Int(loser.losses!) + 1
                    next_winner?.player2 = winner
                    next_loser?.player2 = loser
                    next_loser?.resolveByes()
                }
            }
            else if Int(matchNumber!) == 62{
                winner.wins = Int(winner.wins!) + 1
                loser.losses = Int(loser.losses!) + 1
                next_winner?.player2 = winner
                next_loser?.player2 = loser
                next_loser?.resolveByes()
            }
            else if Int(matchNumber!) >= 63 && Int(matchNumber!) <= 78{
                winner.wins = Int(winner.wins!) + 1
                loser.losses = Int(loser.losses!) + 1
                next_winner?.player1 = winner
                assignRank(Int(matchNumber!), loser: loser)

                loser.result_bracket = currentBracket
                results.append(loser)
                next_winner?.resolveByes()
            }
            else if Int(matchNumber!) >= 79 && Int(matchNumber!) <= 94{
                if Int(matchNumber!)%2 == 0{
                    winner.wins = Int(winner.wins!) + 1
                    loser.losses = Int(loser.losses!) + 1
                    next_winner?.player2 = winner
                    assignRank(Int(matchNumber!), loser: loser)

                    loser.result_bracket = currentBracket
                    results.append(loser)
                    next_winner?.resolveByes()

                }
                else{
                    winner.wins = Int(winner.wins!) + 1
                    loser.losses = Int(loser.losses!) + 1
                    next_winner?.player1 = winner
                    assignRank(Int(matchNumber!), loser: loser)

                    loser.result_bracket = currentBracket
                    results.append(loser)
                    next_winner?.resolveByes()

                }
            }
            else if Int(matchNumber!) >= 95 && Int(matchNumber!) <= 102{
                winner.wins = Int(winner.wins!) + 1
                loser.losses = Int(loser.losses!) + 1
                next_winner?.player1 = winner
                assignRank(Int(matchNumber!), loser: loser)

                loser.result_bracket = currentBracket
                results.append(loser)
                next_winner?.resolveByes()

            }
            else if Int(matchNumber!) >= 103 && Int(matchNumber!) <= 110{
                if Int(matchNumber!)%2 == 0{
                    winner.wins = Int(winner.wins!) + 1
                    loser.losses = Int(loser.losses!) + 1
                    next_winner?.player2 = winner
                    assignRank(Int(matchNumber!), loser: loser)

                    loser.result_bracket = currentBracket
                    results.append(loser)
                    next_winner?.resolveByes()

                }
                else{
                    winner.wins = Int(winner.wins!) + 1
                    loser.losses = Int(loser.losses!) + 1
                    next_winner?.player1 = winner
                    assignRank(Int(matchNumber!), loser: loser)

                    loser.result_bracket = currentBracket
                    results.append(loser)
                    next_winner?.resolveByes()

                }
            }
            else if Int(matchNumber!) >= 111 && Int(matchNumber!) <= 114{
                winner.wins = Int(winner.wins!) + 1
                loser.losses = Int(loser.losses!) + 1
                next_winner?.player1 = winner
                assignRank(Int(matchNumber!), loser: loser)

                loser.result_bracket = currentBracket
                results.append(loser)
                next_winner?.resolveByes()

            }
            else if Int(matchNumber!) >= 115 && Int(matchNumber!) <= 118{
                if Int(matchNumber!)%2 == 0{
                    winner.wins = Int(winner.wins!) + 1
                    loser.losses = Int(loser.losses!) + 1
                    next_winner?.player2 = winner
                    assignRank(Int(matchNumber!), loser: loser)

                    loser.result_bracket = currentBracket
                    results.append(loser)
                    next_winner?.resolveByes()
                }
                else{
                    winner.wins = Int(winner.wins!) + 1
                    loser.losses = Int(loser.losses!) + 1
                    next_winner?.player1 = winner
                    assignRank(Int(matchNumber!), loser: loser)

                    loser.result_bracket = currentBracket
                    results.append(loser)
                    next_winner?.resolveByes()

                }
            }
            else if Int(matchNumber!) >= 119 && Int(matchNumber!) <= 120{
                winner.wins = Int(winner.wins!) + 1
                loser.losses = Int(loser.losses!) + 1
                next_winner?.player1 = winner
                assignRank(Int(matchNumber!), loser: loser)

                loser.result_bracket = currentBracket
                results.append(loser)
                next_winner?.resolveByes()
            }
            else if Int(matchNumber!) >= 121 && Int(matchNumber!) <= 122{
                if Int(matchNumber!)%2 == 0{
                    winner.wins = Int(winner.wins!) + 1
                    loser.losses = Int(loser.losses!) + 1
                    next_winner?.player2 = winner
                    assignRank(Int(matchNumber!), loser: loser)

                    loser.result_bracket = currentBracket
                    results.append(loser)
                    next_winner?.resolveByes()

                }
                else{
                    winner.wins = Int(winner.wins!) + 1
                    loser.losses = Int(loser.losses!) + 1
                    next_winner?.player1 = winner
                    assignRank(Int(matchNumber!), loser: loser)

                    loser.result_bracket = currentBracket
                    results.append(loser)
                    next_winner?.resolveByes()

                }
            }
            else if Int(matchNumber!) == 123{
                winner.wins = Int(winner.wins!) + 1
                loser.losses = Int(loser.losses!) + 1
                next_winner?.player1 = winner
                assignRank(Int(matchNumber!), loser: loser)

                loser.result_bracket = currentBracket
                results.append(loser)
                next_winner?.resolveByes()
            }
            else if Int(matchNumber!) == 124{
                winner.wins = Int(winner.wins!) + 1
                loser.losses = Int(loser.losses!) + 1
                next_winner?.player1 = winner
                assignRank(Int(matchNumber!), loser: loser)

                loser.result_bracket = currentBracket
                results.append(loser)
                next_winner?.resolveByes()
            }
            inProgress = 2
        }
    }
    
    func resolveByes(){
        if hasBye == 1{
            if Int(matchNumber!) >= 63 && Int(matchNumber!) <= 78{
                next_winner?.player1 = player2
                next_winner?.resolveByes()
            }
            else if Int(matchNumber!) >= 95 && Int(matchNumber!) <= 102{
                next_winner?.player1 = player2
                next_winner?.resolveByes()
            }
            else if Int(matchNumber!) >= 111 && Int(matchNumber!) <= 114{
                next_winner?.player1 = player2
                next_winner?.resolveByes()
            }
            else if Int(matchNumber!) >= 119 && Int(matchNumber!) <= 120{
                next_winner?.player1 = player2
                next_winner?.resolveByes()
            }
            else if Int(matchNumber!) == 123 {
                next_winner?.player1 = player2
                next_winner?.resolveByes()
            }
            else if Int(matchNumber!)%2 == 0 {
                next_winner?.player2 = player2
                next_winner?.resolveByes()
            }
            else {
                next_winner?.player1 = player2
                next_winner?.resolveByes()
            }
        }
        else if hasBye == 2{
            if Int(matchNumber!) >= 63 && Int(matchNumber!) <= 78{
                next_winner?.player1 = player1
                next_winner?.resolveByes()
            }
            else if Int(matchNumber!) >= 95 && Int(matchNumber!) <= 102{
                next_winner?.player1 = player1
                next_winner?.resolveByes()
            }
            else if Int(matchNumber!) >= 111 && Int(matchNumber!) <= 114{
                next_winner?.player1 = player1
                next_winner?.resolveByes()
            }
            else if Int(matchNumber!) >= 119 && Int(matchNumber!) <= 120{
                next_winner?.player1 = player1
                next_winner?.resolveByes()
            }
            else if Int(matchNumber!) == 123 {
                next_winner?.player1 = player1
                next_winner?.resolveByes()
            }
            else if Int(matchNumber!)%2 == 0 {
                next_winner?.player2 = player1
                next_winner?.resolveByes()
            }
            else {
                next_winner?.player1 = player1
                next_winner?.resolveByes()
            }
        }
    }
    
    func assignRank(lostMatchID: Int, loser: Participant){
        if currentBracket?.singleElim == true {
            if lostMatchID == 62 {
                loser.rank = 2
            }
            else if lostMatchID == 61 {
                loser.rank = 3
            }
            else if lostMatchID == 60{
                loser.rank = 3
            }
            else if lostMatchID > 55 {
                loser.rank = 5
            }
            else if lostMatchID > 47 {
                loser.rank = 9
            }
            else if lostMatchID > 33 {
                loser.rank = 17
            }
            else{
                loser.rank = 33
            }
        }
        else {
            if lostMatchID == 126 {
                loser.rank = 2
            }
            else if lostMatchID == 125 {
                loser.rank = 2
            }
            else if lostMatchID == 124 {
                loser.rank = 3
            }
            else if lostMatchID == 123 {
                loser.rank = 4
            }
            else if lostMatchID > 120 {
                loser.rank = 5
            }
            else if lostMatchID > 118 {
                loser.rank = 7
            }
            else if lostMatchID > 114 {
                loser.rank = 9
            }
            else if lostMatchID > 110 {
                loser.rank = 13
            }
            else if lostMatchID > 102 {
                loser.rank = 17
            }
            else if lostMatchID > 94 {
                loser.rank = 25
            }
            else if lostMatchID > 78{
                loser.rank = 33
            }
            else {
                loser.rank = 49
            }
        }
    }
    
}