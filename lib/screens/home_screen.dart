import 'dart:async';

import 'package:flutter/material.dart';
import 'package:users_app/helpers/users_stream_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetUsersStream getUsersStream = GetUsersStream();
  @override
  void initState() {
    usersController = StreamController();
    getUsersStream.getUsers(13);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff29000000),
                  blurRadius: 3,
                  offset: Offset(1.0, 1.5),
                ),
              ],
            ),
            padding: EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Text('M'),
                          backgroundColor: Colors.purple,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mubarak Ibrahim',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '+234 08013113499',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.notifications,
                              color: Colors.purple,
                            ),
                            onPressed: () {}),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(90),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: usersController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info,
                        color: Color(0xff5e657d),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'You Don\'t Have Any Friends!',
                        style: TextStyle(
                          fontSize: 21,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Color(0xffd3d4cf).withOpacity(0.15),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.help,
                                  color: Color(0xff5e657d),
                                  size: 17,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${snapshot.data.length ?? 0}',
                            style: TextStyle(
                              fontSize: 33,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Friends',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff29000000),
                              blurRadius: 5,
                              offset: Offset(1.0, 2.5),
                            ),
                          ],
                        ),
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(15),
                          itemBuilder: (context, index) {
                            var userData = snapshot.data[index];

                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.purple,
                                backgroundImage: NetworkImage(
                                    userData['Profile_image'] ?? ''),
                              ),
                              title: Text(
                                '${userData['first_name']} ${userData['last_name']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${userData['email']}',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    '${userData['phone']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                '${userData['gender']}',
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            );
                          },
                          itemCount: snapshot.data.length ?? 0,
                          separatorBuilder: (context, index) {
                            return Divider(thickness: 0.9);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData) {
              return Center(child: Text('NO DATA!'));
            } else {
              return Container();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {},
        child: Icon(Icons.edit),
      ),
    );
  }
}
