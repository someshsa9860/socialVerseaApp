import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:videoplayer/models/api_model.dart';
import 'package:videoplayer/utils/api.dart';

class ApiProvider extends ChangeNotifier {
  final List<ApiModel> _list = [];

  bool _loading=false;

  List<ApiModel> get list => [..._list];

  int page = 1;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  init() async {
    _loading=true;
    try{
      final res = await CallApi.getData('/feed', body: {'page': page});
      if (res.statusCode <= 250) {
        final body = jsonDecode(res.body);

        _list.add(ApiModel.fromJson(body));

        if(body['page_size']>0){
          // page++;
          // init();
        }
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
    loading=false;
  }
}
