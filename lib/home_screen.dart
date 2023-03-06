import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/Usermodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Usermodel> userList = [];

  Future<List<Usermodel>> getUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200)
    {
      for(Map i in data)
      {
        userList.add(Usermodel.fromJson(i));
      }
      return userList;
    }
    else
    {
      return userList;
      // return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getUsers(),
        builder: (context,AsyncSnapshot<List<Usermodel>> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // The Code Written Below Checks the Connection and when the connection is made
          // It gives the fetched data

          /* if(snapshot.connectionState == ConnectionState.waiting)
         // {
          //return Center(
           // child: CircularProgressIndicator(),
         // );
        //  } */
          else
          {
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context,index){
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ReUseAbleRow(title: 'Name: ', value: snapshot.data![index].name.toString()),
                        ReUseAbleRow(title: 'UserName: ', value: snapshot.data![index].username.toString()),
                        ReUseAbleRow(title: 'Email: ', value: snapshot.data![index].email.toString()),
                        ReUseAbleRow(title: 'Address: ', value: snapshot.data![index].address!.city.toString()),
                        ReUseAbleRow(title: 'Lat: ', value: snapshot.data![index].address!.geo!.lat.toString()),


                        //  Text(snapshot.data[index].name),
                       // Text(snapshot.data[index].email),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ReUseAbleRow extends StatelessWidget {
  String title,value;
  ReUseAbleRow({Key? key ,  required this.title , required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}

