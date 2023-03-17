import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:videoplayer/models/api_model.dart';
import 'package:videoplayer/models/posts.dart';
import 'package:videoplayer/utils/api.dart';

class ApiProvider extends ChangeNotifier {

  /// Posts model is used to set/get data

  final List<Posts> _list = [];

  bool _loading = false;

  int _currentIndex=0;

  bool _play=false;


  bool get play => _play;

  set play(bool value) {
    _play = value;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    if(value==_currentIndex) return;
    _currentIndex = value;
    notifyListeners();
  }

  List<Posts> get list => [..._list];

  int page = 1;

  int lastItemsCount = 0;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  init() async {
    /// if already fetching in progress then no further request sent
    if ((lastItemsCount == 0 && page != 1) || loading) {
      return;
    }

    _loading = true;
    if (list.isNotEmpty) {
      notifyListeners();
    }
    if(!await fetch()){
      /// User is offline
      Fluttertoast.showToast(msg: 'please connect internet');
    }
  }

  fetch() async {
    try {
      final res = await CallApi.getData('/feed', body: {
        'page': [page.toString()]
      });

      /// Here we used 250 max as positive code because some time its 201 or 200
      if (res.statusCode <= 250) {
        final body = jsonDecode(res.body);

        final apiModel = (ApiModel.fromJson(body));
        lastItemsCount = apiModel.pageSize ?? 0;
        _list.addAll(apiModel.posts ?? []);
        _loading = false;
        page++;
        notifyListeners();
        return true;
      }else{
        ///Server Error
      }


    } catch (e) {
      // return await fetch();
      /// If user is offline then this method will called again after 2sec

      Future.delayed(const Duration(seconds: 2)).whenComplete(() {
        return fetch();
      });
    }
    return false;
  }
}
