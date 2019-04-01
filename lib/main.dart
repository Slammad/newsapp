
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:newsapp/CustomShapeClipper.dart';
import 'package:http/http.dart' as http;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
       home: SplashScreen(),
       debugShowCheckedModeBanner: false,
       theme: ThemeData(fontFamily: "Oxygen"),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   
  @override
  void initState() {

    _divert();
     new Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => NewsList(news)));
    });
   

    super.initState();
  }
@override

 List news = [];

_divert() async {
  var url = "https://newsapi.org/v2/top-headlines?sources=medical-news-today&apiKey=75be6f905887498480de15d94792839d";

  // Await the http get response, then decode the json-formatted responce.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var knews = jsonResponse['articles'];
    

    setState(() {
      news =knews;
      print(news);
    });
  } else {
    print("Request failed with status: ${response.statusCode}.");
  }

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: <Widget>[
          SplashTop(),
          SizedBox(height: 110.0,),
          Center(
            child: Column(children: <Widget>[
              Material(
                elevation: 1.0,
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: CircularProgressIndicator()
                ),
              )
            ],),
          )

        ],
      ),
    );
  }
}

class SplashTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
                height:400.0,
                color: Colors.white,
                child: Column(children: <Widget>[
                  SizedBox(height: 50.0),
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ])),
                ]))),
        Column(
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 50.0,),
                        Image.asset("assets/images/cctv.png",scale: 7.0,),
                        Text('Get Latest News Update',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),)
                      ],
                
            ),
                  ),
            ),
           
          ],
        )
      ],
    );
  }
}


class NewsList extends StatefulWidget {
  final List news;
  NewsList(this.news);
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
      ),
      body: ListView.builder(
      itemBuilder: (context, i) {
        return Material(
          elevation: 8.0,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(children: <Widget>[
             Image.network(widget.news[i]['urlToImage'].toString(),scale: 12.0,),
             SizedBox(width: 10.0,),
            Container(
              width: 200.0,
              child:  Column(
               children: <Widget>[
                 Text(widget.news[i]['title'].toString().toUpperCase()),
                 MaterialButton(
                   child: Text("Read More"),
                   onPressed: null,
                   
                 )
               
               ],
             ),
              
            )

            ],),
          ),
        );
      },
      itemCount: widget.news.length,
),
    );
  }
}