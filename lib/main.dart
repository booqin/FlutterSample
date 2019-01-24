import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'router.dart';

void main() => runApp(MyApp());

const platform = const MethodChannel("qts.flutter.io/route");

class MyApp extends StatelessWidget {

  final appName = "路由";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new RouteHome(appName)
    );
  }
}

class RouteHome extends StatelessWidget{

  final String appName;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(8.0),
              child: new RouteWidget("Flutter_A", (context){
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new MyRouteA())
                );
              }),
            ),
            new Padding(
              padding: new EdgeInsets.all(8.0),
              child: new RouteWidget("Flutter_B", (context){
                //响应式编程
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new MyRouteB(titleName:"Hello"))
                ).then((value){
                    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("$value")));
                });
              }),
            ),
            new Padding(
              padding: new EdgeInsets.all(8.0),
              child: new RouteWidget("Native_A", (context){
                //响应式编程
                platform.invokeMethod("startActivity", <String, String>{
                  'path':'/a'
                });
              }),
            ),
            new Padding(
              padding: new EdgeInsets.all(8.0),
              child: new RouteWidget("Native_B", (context){
                //响应式编程
                platform.invokeMethod("startActivity", <String, String>{
                  'path':'/b',
                  'param':'back'
                }).then((result){
                  Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("$result")));
                });
              }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingBT()
    );
  }

  RouteHome(this.appName);


}

class FloatingBT extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
      onPressed: (){
        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("hello")));
      },
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }

}

///路由页面
class RouteWidget extends StatelessWidget{

  final String content;
  final funGotoPage;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTap: (){
        this.funGotoPage(context);
      },
      child: Text(this.content),
    );
  }

  RouteWidget(this.content, this.funGotoPage);

}



