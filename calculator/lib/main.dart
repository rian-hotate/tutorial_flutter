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
  double _setNumber = 0; // 計算用
  double _displayNumber = 0; // 表示用
  double _firstNum = 0;
  CALC_TYPE _calcType;
  int _displayPow = 0;
  bool _decimalFlag = false;

  void _setNum(double num) {
    _displayPow = 0;
    if (_displayNumber == _setNumber) {
      if (10000000000 > _displayNumber) {
        setState(() {
          if (!_decimalFlag) _displayNumber = _displayNumber * 10 + num;
          else {
            int count = 1;
            for (int i = 0;
            _displayNumber * Math.pow(10, i) != (_displayNumber * Math.pow(10, i)).ceil();
            i++) {
              count++;
            }
            _displayNumber = double.parse((_displayNumber + (num / Math.pow(10, count))).toStringAsFixed(count));
            _checkDecimal();
          }
          _setNumber = _displayNumber;
        });
      }
    } else {
      setState(() {
        _displayNumber = num;
        _setNumber = _displayNumber;
        _calcType = null;
      });
    }
  }

  void _calcBtnPressed(CALC_TYPE type) {
    _setNumber = _displayNumber;
    _firstNum = _setNumber;
    _setNumber = 0;
    _displayNumber = 0;
    _calcType = type;
  }

  void _calcAdd() {
    setState(() {
      _displayNumber = _firstNum + _setNumber;
      _checkDecimal();
      _firstNum = _displayNumber;
    });
  }

  void _calcSub() {
    setState(() {
      _displayNumber = _firstNum - _setNumber;
      _checkDecimal();
      _firstNum = _displayNumber;
    });
  }

  void _calcMulti() {
    setState(() {
      _displayNumber = _firstNum * _setNumber;
      _checkDecimal();
      _firstNum = _displayNumber;
    });
  }

  void _calcDiv() {
    setState(() {
      _displayNumber = _firstNum / _setNumber;
      _checkDecimal();
      _firstNum = _displayNumber;
    });
  }

  void _invertedNum() {
    setState(() {
      _displayNumber = -_displayNumber;
      _setNumber = -_setNumber;
    });
  }

  void _checkDecimal() {
    double checkNum = _displayNumber;
    if (100000000000 < _displayNumber ||
        _displayNumber == _displayNumber.toInt()) {
      for (int i = 0; 100000000000 < _displayNumber / Math.pow(10, i); i++) {
        _displayPow = i;
        checkNum = checkNum / 10;
      }
      _displayNumber = checkNum.floor().toDouble();
    } else {
      int count = 0;
      for (int i = 0;
          1 < _displayNumber / Math.pow(10, i);
          i++) {
        count = i;
      }
      int displayCount = 10 - count;
      _displayNumber = double.parse(_displayNumber.toStringAsFixed(displayCount));
    }
  }

  void _clearNum() {
    setState(() {
      _setNumber = 0;
      _displayNumber = 0;
      _firstNum = 0;
      _calcType = null;
      _displayPow = 0;
      _decimalFlag = false;
    });
  }

  void _clearEntryNum() {
    setState(() {
      _setNumber = 0;
      _displayNumber = 0;
      _displayPow = 0;
      _decimalFlag = false;
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
          Container(
            height: 20,
            child: _displayPow > 0 ? Text(
              "10^${_displayPow.toString()}",
              style: TextStyle(
                fontSize: 20,
              ),
            ) : Container(),
          ),
          Text(
            _displayNumber == _displayNumber.toInt()
                ? _displayNumber.toInt().toString()
                : _displayNumber.toString(),
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
                              _clearEntryNum();
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
                              _calcBtnPressed(CALC_TYPE.div);
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
                              _calcBtnPressed(CALC_TYPE.multi);
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
                            onPressed: () {
                              _invertedNum();
                            },
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
                            onPressed: () {
                              _decimalFlag = true;
                            },
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
                              switch (_calcType) {
                                case CALC_TYPE.add:
                                  _calcAdd();
                                  break;
                                case CALC_TYPE.sub:
                                  _calcSub();
                                  break;
                                case CALC_TYPE.multi:
                                  _calcMulti();
                                  break;
                                case CALC_TYPE.div:
                                  _calcDiv();
                                  break;
                                default:
                                  break;
                              }
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
