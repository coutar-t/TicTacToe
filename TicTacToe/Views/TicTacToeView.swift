//
//  TicTacToeView.swift
//  TicTacToe
//
//  Created by Thibaut Coutard on 15/12/2021.
//

import SwiftUI

struct TicTacToeView: View {


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

            Text(vm.gameStatus)
                .font(.body)
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
            Button("rejouer", action: {
                vm.didTapResetGame()
            })
        }
        .alert(isPresented: $vm.showAlert) {
            Alert(title: Text("Error"),
                  message: Text(vm.errorMessage),
                  dismissButton: .default(Text("ok")))
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()

    }
}
