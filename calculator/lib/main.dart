import 'package:flutter/material.dart';
import 'dart:math' as Math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'calc app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum CALC_TYPE { add, sub, multi, div }

class _MyHomePageState extends State<MyHomePage> {
  int _displayNumber = 0; // 表示用
  List<int> _numberList = [0];
  int _index = 0;
  List<CALC_TYPE> _calcTypeList = [];

  void _setNum(int num) {
    if (10000000000 > _displayNumber) {
      setState(() {
        _displayNumber = _displayNumber * 10 + num;
        _numberList[_index] = _displayNumber;
      });
    }
  }

  void _calcBtnPressed(CALC_TYPE type) {
    setState(() {
      _index++;
      _numberList.add(0);
      _calcTypeList.add(type);
      _displayNumber = 0;
    });
  }

  String _displayFormula() {
    String _formula = "";
    for(int i = 0; _numberList.length > i; i++) {
      _formula += _numberList[i].toString();
      if (_calcTypeList.length > i) {
        switch(_calcTypeList[i]) {
          case CALC_TYPE.add:
            _formula += "+";
            break;
          case CALC_TYPE.sub:
            _formula += "-";
            break;
          case CALC_TYPE.multi:
          case CALC_TYPE.div:
          default:
            break;
        }
      }
    }
    return _formula;
  }

  void _clearNum() {
    setState(() {
      _displayNumber = 0;
      _index = 0;
      _numberList.clear();
      _numberList.add(0);
      _calcTypeList.clear();
      _displayNumber = 0;
    });
  }

  void _calcFormula() {
    int _number;
    for(int i = 0; _numberList.length > i; i++) {
      if (i == 0) _number = _numberList.first;
      else if (_calcTypeList.length > i - 1) {
        switch(_calcTypeList[i - 1]) {
          case CALC_TYPE.add:
            _number += _numberList[i];
            break;
          case CALC_TYPE.sub:
            _number -= _numberList[i];
            break;
          case CALC_TYPE.multi:
          case CALC_TYPE.div:
          default:
            break;
        }
      }
    }
    setState(() {
      _index = 0;
      _numberList.clear();
      _numberList.add(_number);
      _calcTypeList.clear();
      _displayNumber = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            _displayFormula(),
            style: TextStyle(
              fontSize: 60,
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              _clearNum();
                            },
                            child: Text(
                              "CE",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              _clearNum();
                            },
                            child: Text(
                              "C",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                            },
                            child: Text(
                              "÷",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              _setNum(7);
                            },
                            child: Text(
                              "7",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              _setNum(8);
                            },
                            child: Text(
                              "8",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              _setNum(9);
                            },
                            child: Text(
                              "9",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                            },
                            child: Text(
                              "×",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              _setNum(4);
                            },
                            child: Text(
                              "4",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              _setNum(5);
                            },
                            child: Text(
                              "5",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              _setNum(6);
                            },
                            child: Text(
                              "6",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              _calcBtnPressed(CALC_TYPE.sub);
                            },
                            child: Text(
                              "-",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              _setNum(1);
                            },
                            child: Text(
                              "1",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              _setNum(2);
                            },
                            child: Text(
                              "2",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              _setNum(3);
                            },
                            child: Text(
                              "3",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              _calcBtnPressed(CALC_TYPE.add);
                            },
                            child: Text(
                              "+",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              "+/-",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              _setNum(0);
                            },
                            child: Text(
                              "0",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              ".",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              _calcFormula();
                            },
                            child: Text(
                              "=",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
