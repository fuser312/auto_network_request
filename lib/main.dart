import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String centerText;
  bool isLoading = false;
  Future future;
  bool loadingWithAppStart = true;
  Future<void>fetchResponseFromNetwork()async{
    Response response = await get(
        "http://slowwly.robertomurray.co.uk/delay/8000/url/http://www.google.co.uk");
    centerText = "Status Code: " + response.statusCode.toString();
  }

  @override
  void initState() {
    future = fetchResponseFromNetwork();
    super.initState();
  }

  void getFuture() async {
    setState(() {
      isLoading = true;
    });
    await future;
    setState(() {
      isLoading = false;
      loadingWithAppStart = false;
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isLoading ? Center(child: CircularProgressIndicator()):
            Text(
              loadingWithAppStart ? "Welcome" : centerText,
              style: Theme.of(context).textTheme.display1,
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isLoading ? Colors.grey : Colors.blue,
        onPressed: isLoading
            ? null
            : () {
          getFuture();
        },
        tooltip: 'Check if future is here',
        child: Icon(Icons.add ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
