import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: Calculator(),
  ));
}

class statemngmnt extends ChangeNotifier {

  String disply = "";
  String process = "";
  String first = "";
  String second = "";
  String third = "";
  int cnt = 0;

  NumaricButton(String buttonname,
      [int backgroundcolor = 0xff505050, int textcolor = 0xffFFFFFF]) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (buttonname != "0") {
            if (disply == "0") {
              disply = "";
            }
            disply = disply + "$buttonname";
            process += buttonname;
          } else {
            disply = disply + "$buttonname";
            process += buttonname;
          }

          notifyListeners();
        },
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Color(backgroundcolor)),
          child: Center(
              child: Text(buttonname,
                  style: TextStyle(color: Color(textcolor), fontSize: 30))),
        ),
      ),
    ));
  }

  FunctionButton(String buttoname,
      [int backgroundcolor = 0xffD4D4D2, int textcolor = 0xff000000]) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: InkWell(
          onTap: () {
            print("gfcgfccbbcbcbcbcbbbbbbbbbbbbbbb");
            if (buttoname == "+") {
              process += buttoname;

              if (cnt == 0) {
                first = disply;
                disply = "";
              } else {
                Run();
              }
              cnt = 1;
            } else if (buttoname == "-") {
              process += buttoname;
              if (cnt == 0) {
                first = disply;
                disply = "";
              } else {
                Run();
              }
              cnt = 2;
            } else if (buttoname == "X") {
              process += buttoname;
              if (cnt == 0) {
                first = disply;
                disply = "";
              } else {
                Run();
              }
              cnt = 3;
            } else if (buttoname == "/") {
              process += buttoname;
              if (cnt == 0) {
                first = disply;
                disply = "";
              } else {
                Run();
              }
              cnt = 4;
            } else if (buttoname == "AC") {
              process = "";
              cnt = 0;
              disply = "";
            } else if (buttoname == "\.") {
              if (!disply.contains("\.")) {
                process += buttoname;

                disply = disply + buttoname;
              }
            } else if (buttoname == "+/-") {
              if (disply[0] != "-") {
                disply = "-" + disply;
              } else {
                disply = disply.substring(1);
              }

              if (process[0] != "-") {
                process = "-" + process;
              }
            } else if (buttoname == "%") {
              process = process + buttoname;

              if (first == "") {
                first = "1";
              }

              second = disply;

              if (cnt == 1) {
                disply =
                    "${(double.parse(first)) + (double.parse(first) * double.parse(second) / 100)}";
              }

              if (cnt == 2) {
                disply =
                    "${(double.parse(first)) - (double.parse(first) * double.parse(second) / 100)}";
              }

              if (cnt == 3) {
                disply =
                    "${(double.parse(first) * double.parse(second) / 100)}";
              }

              if (cnt == 4) {
                disply =
                    "${((double.parse(first)) / (double.parse(second) / 100))}";
              }
            } else if (buttoname == "=") {
              second = disply;

              if (cnt == 1) {
                disply = "${double.parse(first) + double.parse(second)}";
              } else if (cnt == 2) {
                disply = "${double.parse(first) - double.parse(second)}";
              } else if (cnt == 3) {
                print("first::::$first");
                print("second::::$second");
                disply = "${double.parse(first) * double.parse(second)}";
              } else if (cnt == 4) {
                disply = "${double.parse(first) / double.parse(second)}";
              }

              cnt = 0;
            }

            notifyListeners();
          },
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Color(backgroundcolor)),
            child: Center(
                child: Text(buttoname,
                    style: TextStyle(color: Color(textcolor), fontSize: 30))),
          ),
        ),
      ),
    );
  }

  void Run() {
    if (cnt == 1) {
      second = disply;

      third = "${double.parse(first) + double.parse(second)}";
      first = third;
      disply = "";
    }

    if (cnt == 2) {
      second = disply;

      third = "${double.parse(first) - double.parse(second)}";
      first = third;
      disply = "";
    }

    if (cnt == 3) {
      print("disply=======$disply");

      second = disply;

      print("++++++first = $first");
      print("++++++second = $second");

      third = "${double.parse(first) * double.parse(second)}";

      first = third;

      disply = "";
    }

    if (cnt == 4) {
      second = disply;

      third = "${double.parse(first) / double.parse(second)}";

      first = third;

      disply = "";
    }

    notifyListeners();
  }
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
          create: (context) => statemngmnt(),
          child: Consumer<statemngmnt>(
            builder: (context, value, child) {
              return Column(children: [
                Expanded(
                    flex: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Text("${value.process}",
                            style: TextStyle(
                                fontSize: 25, fontStyle: FontStyle.italic)),
                      ),
                    )),
                Expanded(
                    flex: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Text("${value.disply}",
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold)),
                      ),
                    )),
                Expanded(
                  flex: 10,
                  child: Row(
                    children: [
                      value.FunctionButton("AC"),
                      value.FunctionButton("+/-"),
                      value.FunctionButton("%"),
                      value.FunctionButton("/", 0xffFF9500, 0xffFFFFFF),
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Row(
                    children: [
                      value.NumaricButton("7"),
                      value.NumaricButton("8"),
                      value.NumaricButton("9"),
                      value.FunctionButton("X", 0xffFF9500, 0xffFFFFFF),
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Row(
                    children: [
                      value.NumaricButton("4"),
                      value.NumaricButton("5"),
                      value.NumaricButton("6"),
                      value.FunctionButton("-", 0xffFF9500, 0xffFFFFFF),
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Row(
                    children: [
                      value.NumaricButton("1"),
                      value.NumaricButton("2"),
                      value.NumaricButton("3"),
                      value.FunctionButton("+", 0xffFF9500, 0xffFFFFFF),
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Row(
                    children: [
                      value.NumaricButton("0"),
                      value.NumaricButton("00"),
                      value.NumaricButton("\."),
                      value.FunctionButton("=", 0xffFF9500, 0xffFFFFFF),
                    ],
                  ),
                )
              ]);
            },
          )),
    );
  }
}
