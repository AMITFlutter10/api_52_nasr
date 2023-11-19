import 'dart:convert';

import 'package:api_52_nasr/user_mode.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  Dio dio = Dio();
  /// get => formjson
  /// http => jsonDECODE
  ///
  ///
  /// POST => TOJSON
  /// http=> jsonencode
  String url = "https://reqres.in/api/users";
  // http package
      Future<UserModel> getData()async{
         try{
          http.Response response =await  http.get(Uri.parse(url));
          print("package http   response : ${response.body}statusCode:  ${response.statusCode}");
          return UserModel.fromJson(jsonDecode(response.body));
       }
       catch(error){
           throw();
           print(error);
       }
       }

 // get => formjon
 //  post=> tojson
  // dio package
  //  Future<UserModel> getData()async{
  //      try{
  //     var response=  await dio.get(url);
  //     print("package dio response:  ${response.data} ${response.statusCode}");
  //     return UserModel.fromJson(response.data);
  //   } catch(error){
  //         throw();
  //        print(error);
  //      }
  //      }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:
      FutureBuilder<UserModel>(
        future: getData(),
        builder:(context,snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting :
              return CircularProgressIndicator();
            default :
              if(snapshot.hasError){
                return Text("error is happend");
              }else{
                return Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index)=>const SizedBox(height: 15,),
                      itemCount: snapshot.data!.data1!.length,
                      itemBuilder: (context, index){
                        final model= snapshot.data!.data1![index];
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            child: Image.network("${model.avatar}"),
                          ),
                          title: Text("${model.firstName}"),
                          subtitle: Text("${model.email}"),
                          trailing: Text("${model.id}"),
                        );
                      },

                    ),
                  ],
                );
              }
          }
    }


      )
    );
  }
}
