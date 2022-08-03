import 'package:flutter/material.dart';
import 'constant.dart';

class DataArray extends ChangeNotifier {
  List<dynamic> _data = [
    [rB,kB,bB,qB,kingB,bB,kB,rB],
    [pB,pB,pB,pB,pB,pB,pB,pB],
    [N,N,N,N,N,N,N,N],
    [N,N,N,N,N,N,N,N],
    [N,N,N,N,N,N,N,N],
    [N,N,N,N,N,N,N,N],
    [pW,pW,pW,pW,pW,pW,pW,pW],
    [rW,kW,bW,qW,kingW,bW,kW,rW],
  ];
   
  List get data => _data;

  List getData(){
    return _data;
  }
  void setData() {
    final List<List<List>> starting = [
    [rB,kB,bB,qB,kingB,bB,kB,rB],
    [pB,pB,pB,pB,pB,pB,pB,pB],
    [N,N,N,N,N,N,N,N],
    [N,N,N,N,N,N,N,N],
    [N,N,N,N,N,N,N,N],
    [N,N,N,N,N,N,N,N],
    [pW,pW,pW,pW,pW,pW,pW,pW],
    [rW,kW,bW,qW,kingW,bW,kW,rW],
  ];
    _data = starting;
    notifyListeners();
  }
  List getPiece(int index, int letter) {

    return _data[index][letter];
  }
  void setPiece(int index, int letter, dynamic value) {
    _data[index][letter] = value;
    notifyListeners();
  }
}