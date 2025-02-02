import 'dart:convert';
import 'package:demoproject/model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class SimpleCallApi extends StatefulWidget{
  const SimpleCallApi({super.key});

  @override
  State<SimpleCallApi> createState() => _SimpleCallApiState();
}

class _SimpleCallApiState extends State<SimpleCallApi>{
  List<User> users = [];
   bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }
   
  Future<void> fetchData() async {
    try{
      var response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users/'));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        setState(() {
          users = jsonList.map((item) => User.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        print('Invalid Data');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple API Call'),
      ),
      body: isLoading 
      ? const Center(child: CircularProgressIndicator()) // Show loading indicator
          : users.isEmpty
      ? const Center(child: Text('No data available'))
      :ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            leading: Text('${users[index].id}'),
            title: Text(users[index].name),
            subtitle: Text(users[index].email),
            trailing: Text('(${users[index].username})'),
          );
        },
      ),
    );
  }
}