import 'dart:math';
import 'package:tic_tac_toe/theme.dart';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Game_button.dart';
import 'package:tic_tac_toe/custom_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameButton> buttonsList = [];
  var player1;
  var player2;
  var activePlayer;

  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    player1 = [];
    player2 = [];
    activePlayer = 1;

    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = "X";
        gb.bg = Colors.red;
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = "0";
        gb.bg = Colors.blue;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      int winner = checkWinner();
      if (winner == -1) {
        if (buttonsList.every((p) => p.text != "")) {
          showDialog(
              context: context,
              builder: (_) => new CustomDialog("Game Tied",
                  "Press the reset button to start again.", resetGame));
        } else {
          activePlayer == 2 ? autoPlay() : null;
        }
      }
    });
  }

  void autoPlay() {
    var emptyCells = [];
    var list = new List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if (!(player1.contains(cellID) || player2.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }

    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length - 1);
    var cellID = emptyCells[randIndex];
    int i = buttonsList.indexWhere((p) => p.id == cellID);
    playGame(buttonsList[i]);
  }

  int checkWinner() {
    var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }

    // row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }

    // row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    // col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    // col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    // col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog("Hurray!You Won",
                "Press the reset button to start again.", resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog("Oops Computer Won",
                "Press the reset button to start again.", resetGame));
      }
    }

    return winner;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: MainColor.primaryColor,
          appBar: AppBar(
            title: const Text('Tic Tac Toe'),
            backgroundColor: MainColor.secondaryColor,
            elevation: 0,
          ),
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/dealmartadminapp.appspot.com/o/TicTacToe%2FUntitled%20design%20(9).png?alt=media&token=3b08826f-91a3-4349-9e2c-6b7d2d7c3adc'),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/dealmartadminapp.appspot.com/o/TicTacToe%2F1641568423057.png?alt=media&token=f9dcdfb1-22d8-44d7-a001-5d727e1126da',
                  height: 200.0,
                  scale: 1,
                ),
                Expanded(
                  child: Container(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(45.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.0,
                              crossAxisSpacing: 9,
                              mainAxisSpacing: 9),
                      itemCount: buttonsList.length,
                      itemBuilder: (context, i) => SizedBox(
                        width: 100.0,
                        height: 100.0,
                        child: RaisedButton(
                          onPressed: buttonsList[i].enabled
                              ? () => playGame(buttonsList[i])
                              : null,
                          child: Text(
                            buttonsList[i].text,
                            style: TextStyle(
                                color: buttonsList[i].bg, fontSize: 64.0),
                          ),
                          color: MainColor.secondaryColor,
                          disabledColor: MainColor.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50.0,
                  // alignment: Alignment.topCenter,
                  color: MainColor.primaryColor,
                  child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.replay,
                        color: Colors.red,
                      ),
                      onPressed: resetGame,
                      label: Text(
                        'Reset',
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(MainColor.secondaryColor),
                        elevation: MaterialStateProperty.all(0),
                        // padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                        // textStyle: MaterialStateProperty.all(
                        //TextStyle(fontSize: 20))
                      )),
                ),
              ],
            ),
          )),
    );
  }
}
