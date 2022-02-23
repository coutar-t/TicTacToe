//
//  ContentView.swift
//  TicTacToe
//
//  Created by Thibaut Coutard on 15/12/2021.
//

import SwiftUI

struct ContentView: View {


    @ObservedObject var vm = TicTacToeViewModel()
    private var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            Text("TicTacToe")
                .font(.title)
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 16,
                pinnedViews: [.sectionHeaders, .sectionFooters]
            ) {
                ForEach(0..<9, id: \.self) { index in
                    ZStack {
                        Color.blue
                        Text(vm.board[index/3][index%3])
                    }.aspectRatio(1, contentMode: .fit)
                        .onTapGesture {
                            vm.didTapCase(x: index/3, y: index%3)
                        }
                }
        }.padding()
        }
//        HStack(alignment: .center) {
//        ForEach(0..<vm.board.endIndex, id: \.self) { column in
//
//            VStack {
//                ForEach(0..<vm.board[column].endIndex, id: \.self) { row in
//                    Text(vm.board[column][row])
//                    Text("|")
//                }
//            }
//            .background(Color.blue)
//            VStack {
//                ForEach(0..<vm.board[column].endIndex, id: \.self) { row in
//                    Text("-")
//                }
//            }
//        }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

    }
}
