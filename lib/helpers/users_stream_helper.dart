import 'dart:async';

import 'package:users_app/helpers/http_helper.dart';

StreamController usersController;

class GetUsersStream {
  getUsers(int count) async {
    HttpHelpers()
        .getRequest(
            'https://api.mockaroo.com/api/f513edc0?count=$count&key=966a4f00')
        .then((res) async {
      usersController.add(res);
      return res;
    });
  }
}
