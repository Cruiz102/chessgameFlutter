import 'package:flutter/material.dart';
import 'constant.dart';

class DataArray extends ChangeNotifier {
  //TODO: Create a Mock data Array for testing if the next play
  // is possible. This will then be set to the original state of
  // of the game after the check. In the case the move is possible
  // it will be inverse, the original will copy the MockData Array.
  
  // Also we will need a solution for checking in this MockDataArray.
  //Because the function allPossibleMoves and checkPieces check Pieces
  // on the DataArray. Becuase they use the getPiece method that only check
  // on the original DataArray.
  //Possibles Solutions:
  // - Make an identifier in the getPiece method to check in what DataArray
  //     we want to check. In this implementation we must change also the
  //     allPossibleMoves and checkPieces, and all indivudual piece checks.
  //
  //    !!Must refactor a lot of code but make further code more cleaner!!
  //
  // - 
  //
  //
  //


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
   List<dynamic> _mockData = [
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
  List getPiece(int index, int letter, bool isMock) {
    if(isMock){
      print("retrieving from Mock");
    return _mockData[index][letter];
    }
    return _data[index][letter];
    

  }
  void setPiece(int index, int letter, dynamic value) {
    _data[index][letter] = value;
    _mockData[index][letter] = value;
    notifyListeners();
  }
  void setMockPiece(int index, int letter, dynamic value){
    _mockData[index][letter] = value;
    notifyListeners();
  }
  void redoMockData(){
    _mockData =  _data.toList();
    notifyListeners();
  }
}