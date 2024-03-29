import 'package:flutter/material.dart';
import '/features/chess/repository/chess_piece_data.dart';



class GameController extends ChangeNotifier{


  // _blackMove and _whiteMoves are gloabl variables.
  // with the purpose of controlling if the player can move or not.
  // These Variables were create to solve the problem when doing the promotion,
  // the player can't move any piece while the promotion menu is open.
   int _blackMove = 0;
   int _whiteMove = 1;
   // inwhiteCheck and inblackCheck are booleans that tells us
   // if the king's are in check.
    bool _inWhiteCheck = false;
    bool _inBlackCheck = false;
    // inCheckMate is a boolean that tells us if the player is in checkmate.
    bool inCheckMate = false;
    // inStalemate is a boolean that tells us if the player is in stalemate.
    bool inStalemate = false;
    // Put all the pieces that  that they trayectory is a possible check
     List<ChessPieceData> _possibleWhiteChecks = [];

     List<ChessPieceData> _possibleBlackChecks = [];

    // Variable that keeps track of King White Position on the table
    List<int> kingWhitePosition = [7,4];
    List<int> mockKingWhite = [7,4];

    // Variable that keeps track of King Black Position on the table
    List<int> kingBlackPosition = [0,4];
    List<int> mockKingBlack = [0,4];

    // Variables that check the castling 
    bool _blackKingHasMove = false;
    bool _whiteKingHasMove = false;
    bool _whiteRookLeftHasMove = false;
    bool _whiteRookRightHasMove = false;
    bool _blackRookLeftHasMove = false;
    bool _blackRookRightHasMove = false;

  int get blackMove => _blackMove;
  int get whiteMove => _whiteMove;
  List get possibleWhiteChecks => _possibleWhiteChecks;
  List get possibleBlackChecks => _possibleBlackChecks;
  bool get inWhiteCheck => _inWhiteCheck;
  bool get inBlackCheck => _inBlackCheck;

  bool get  blackKingHasMove => _blackKingHasMove;
  bool get  whiteKingHasMove => _whiteKingHasMove;
  bool get  whiteRookLeftHasMove => _whiteRookLeftHasMove;
  bool get  whiteRookRightHasMove => _whiteRookRightHasMove;
  bool get  blackRookRightHasMove => _blackRookRightHasMove;
  bool get  blackRookLeftHasMove => _blackRookLeftHasMove;
// Restart all the game Variables.
  void restartPosition(){

    _blackMove = 0;
    _whiteMove = 1;
    _inWhiteCheck = false;
    _inBlackCheck = false;
    inCheckMate = false;
    _possibleWhiteChecks = [];
    _possibleBlackChecks = [];
    kingWhitePosition = [7,4];
    kingBlackPosition = [0,4];

  }
  void changeBlackMove(){
    _blackMove = _blackMove == 1 ? 0 : 1;
    notifyListeners();
  }
  void changeWhiteMove(){
    _whiteMove = _whiteMove == 1 ? 0 : 1;
    notifyListeners();
  }
  void changeTurns(){
    _blackMove = _blackMove == 1 ? 0 : 1;
    _whiteMove = _whiteMove == 1 ? 0 : 1;
    notifyListeners();
  }

  void changeWhiteCheck(bool value){
    _inWhiteCheck = value;
    notifyListeners();

  }
  void changeBlackCheck(bool value){
    _inBlackCheck = value;
    notifyListeners();

  }
  void updateKingPosition(String color, int index, int letter, bool isMock){
    if(color == "white" && isMock){
      mockKingWhite = [index, letter];
    }
    if(color =="black" && isMock){
      mockKingBlack = [index, letter];
    }
    if(color == 'white'){
      kingWhitePosition = [index,letter];
      mockKingWhite = [index,letter];
      
    }
    if(color == 'black'){
      kingBlackPosition = [index,letter];
      mockKingBlack = [index,letter];
    }
    notifyListeners();
  }
  /// This function return the contrary of the color given.
  /// This is because is used to check if the other player king
  /// is in check.
  List<int> getKingPosition(String color,bool isMock){
    if(color =='white' && isMock){
      return mockKingWhite;
    }
    if(color == 'black' && isMock){
      return mockKingBlack;
    }
    if(color == 'white'){
      return kingWhitePosition;
    }
    if(color == 'black'){
      return kingBlackPosition;
    }
    return [];

  }
  void pushPossibleCheck(ChessPieceData piece){
    if(piece.color == 'white'){
      _possibleBlackChecks.add(piece);
    }
    if(piece.color == 'black'){
      _possibleWhiteChecks.add(piece);
    }
    notifyListeners();
  }
  void clearPossibleCheck(){
    _possibleWhiteChecks.clear();
    _possibleBlackChecks.clear();
    notifyListeners();
  }

  void updateblackKingHasMove(bool value, String color){
    if (color == "white"){
     _whiteKingHasMove = value;
     }
    if(color == "black"){
      _blackKingHasMove = value;
    }
  }
  /// This function is to update the variables
  /// whiteRookHasMove for their respectively side.
  /// The `side` parameter must be `right` or `left`.
  void updateRookHasMove(bool value, String color, String side){
    if(color =="white"){
      if (side == "right"){
        _whiteRookRightHasMove = value;
      }
      if(side == "left"){
        _whiteRookLeftHasMove = value;
      }
    if(color == "black"){
      if(side == "right"){
        _blackRookRightHasMove = value;
      }
      if(side == "left"){
        _blackRookLeftHasMove = value;
      }
    }
    }
  }




}