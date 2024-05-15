import 'package:flutter/foundation.dart';

class PostProvider extends ChangeNotifier{

  String _filter = '';
  String get filter => _filter;

  Future<void> applyFilter(String value) async {
    try{
      _filter = value;
      notifyListeners();
    }catch(e){
      if (kDebugMode) {
        print('Error applying filter');
      }
    }
  }
}