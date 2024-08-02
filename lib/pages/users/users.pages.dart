import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "package:http/http.dart " as http;

class UsersPage extends StatefulWidget {
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  String? query;
  bool notVisible = false;
  dynamic data = null;
  TextEditingController queryTextEditingController = new TextEditingController();

  _search(String? query) {
    var url = Uri.https('api.github.com','/search/users',{'q':query,'per_page':'20','page':'20'});
    print(url);
    http.get(url)
        .then((response) {
          setState(() {
            this.data =json.decode(response.body);
          });
    })
        .catchError((err){
          print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users => ${query}'),),
      body: Center(
        child: Column(
          children: [
           Row(
             children: [
               Expanded(
                 child: Container(
                     padding: EdgeInsets.all(10),
                     child: TextFormField(
                       obscureText: notVisible,
                       onChanged: (value){
                         setState(() {
                           this.query = queryTextEditingController.text;

                         });
                       },
                       controller: queryTextEditingController,
                       decoration: InputDecoration(
                           icon: Icon(Icons.logout),
                           suffixIcon: IconButton(
                             icon: Icon(
                                 notVisible==false?
                                 Icons.visibility:
                             Icons.visibility_off),
                             onPressed: (){
                               setState(() {

                                 notVisible=!notVisible;
                               });
                             },
                           ),
                           contentPadding: EdgeInsets.all(10),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20),
                               borderSide:BorderSide(
                                   width: 2,
                                   color: Colors.deepOrange
                               )
                           )
                       ),
                     )
                 ),
               ),
               IconButton(onPressed: (){
                 setState(() {
                   this.query = queryTextEditingController.text;
                   _search(query);
                 });
                 print(query);
               },
                   icon:  Icon(Icons.search,color: Colors.deepOrange,))
             ],
           ),
            Expanded(
              child: ListView.builder(
                itemCount: (data==null) ?0:data['items'].length,
                  itemBuilder: ( context, index){
                  return ListTile(
                    title: Row(
                      
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(data['items'][index]['avatar_url']),
                            radius: 40,),
                            SizedBox(width: 20,),
                            Text("${data['items'][index]['login']}",style: TextStyle(
                              fontSize: 25
                            ),
                            ),
                            CircleAvatar(
                              child:Text("${data['items'][index]['score']}"),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                  }),
            )
          ],
        ),
      ),
    );
  }


}