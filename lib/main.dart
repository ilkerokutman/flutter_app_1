import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Model> items = List<Model>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("baslik"),
      ),
      body: Container(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              child: items.length > 0
                  ? ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text("${items[index].title}"),
                          leading: CircleAvatar(
                            child: items[index].completed ? Icon(Icons.check) : Icon(Icons.close, color: Colors.red,),
                          ),
                        );
                      },
                    )
                  : Text("kayit yok"),
            );
          },
          future: getItems(),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: getItems, child: Icon(Icons.download_sharp)),
    );
  }

  Future<List<Model>> getItems() async {
    print("getItems basladi");
    List<Model> data = List<Model>();
    String url = "https://jsonplaceholder.typicode.com/todos";
    Dio dio = Dio();
    final response = await dio.get(url);
    print("getItems cevap aldi");
    switch (response.statusCode) {
      case 200:
        List<dynamic> _data = response.data;
        for (int i = 0; i < _data.length; i++) {
          Model model = Model.fromMap(_data[i]);
          data.add(model);
        }
        setState(() {
          items = data;
        });
        break;
      case 404:
        print("bulunamdi");
        break;
      default:
        print("hata aldik");
        break;
    }
    return items;
  }
}
