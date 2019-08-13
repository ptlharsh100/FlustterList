import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

    void main() => runApp(MaterialApp(
      home : MyFriendListV(),
    ));
    class MyFriendListV extends StatefulWidget{
      @override
      MyFriendListVState createState() => MyFriendListVState();
    }

    class MyFriendListVState extends State<MyFriendListV>{
      Map data;
      List friendListData;

      Future getFriendList() async {
        http.Response response = await http.get("https://reqres.in/api/users?page=2");
        data = json.decode(response.body);
        setState(() {
          friendListData = data['data'];
        });
      }


      @override
      void initState() {
        super.initState();
        getFriendList();
      }
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Friends List"),
            backgroundColor: Colors.green,
          ),
          body: ListView.builder(
            itemCount: friendListData == null? 0 : friendListData.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(friendListData[index]['avatar']),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("${friendListData[index]['first_name']} ${friendListData[index]['last_name']}",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),),
                      ),
                    ],
                  ),
                ),
              );
            },
            ),
        );
      }
    }
