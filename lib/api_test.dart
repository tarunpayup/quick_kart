import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApiTest extends StatelessWidget{
  const ApiTest({super.key});

  void getData() async{
    var response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users")
    );
    print(response.body);
  }

  @override
  Widget build(BuildContext context){
    return Center(
      child: Column(
        children: [
          const Text("API Testing",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),
          ElevatedButton(onPressed: getData , child: const Text("Click to call API"))
        ],
      ),
    );
  }
}