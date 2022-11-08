import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_parse/model/model.dart';

class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
//Make List because json arry startwith.
  List<PostModel> postList = [];
//calling api
  Future<List<PostModel>> fetchData() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // postList.clear();
      for (var i in data) {
        postList.add(PostModel.fromJson(i));
      }

      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading...");
                } else {
                  return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(postList[index].title.toString()),
                                 SizedBox(height: 15,),
                                Text('Body:\n'+postList[index].body.toString()),
                                SizedBox(height: 20,)
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
