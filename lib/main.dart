import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sayi Tahmin Etme Oyunu',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Sayi Tahmin Etme Oyunu'),
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
  String _durum = "waiting";
  String _baslatText = "BAŞLAT";
  String _info =
      "Başlat butonuna basınız ve kutucuğa 0 ile 100 arasındaki tahminlerinizi giriniz.";
  int _denemeSayisi = 0;
  int sayi = 0;

  Future<void> _up() async {
    setState(() {
      _durum = 'up';
    });
  }

  Future<void> _down() async {
    setState(() {
      _durum = 'down';
    });
  }

  Future<void> _correct() async {
    setState(() {
      _durum = 'correct';
      _info = 'Tebrikler $_denemeSayisi. denemede bildiniz.';
      _denemeSayisi = 0;
    });
  }

  Future<void> _oyna() async {
    setState(() {
      _baslatText = 'YENİDEN BAŞLAT';
      _durum = 'waiting';
      _denemeSayisi = 0;
    });
  }

  Future<void> _score() async {
    setState(() {
      _info = 'Deneme sayısı = $_denemeSayisi';
    });
  }

  Future<void> _count() async {
    setState(() {
      _denemeSayisi++;
      _info = 'Deneme sayısı = $_denemeSayisi';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Image(
                  image: AssetImage('lib/images/$_durum.png'),
                  height: 100,
                  width: 100),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: Text(
                  "$_info",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(onFieldSubmitted: (val) {
                _count();
                int okunan = int.parse(val);
                if (okunan < sayi) {
                  _up();
                } else if (okunan > sayi) {
                  _down();
                } else
                  _correct();
              }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 50),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(vertical: 15),
                minWidth: 300,
                elevation: 2,
                color: (Colors.lightGreen[300]),
                child: Text('$_baslatText'),
                onPressed: () {
                  sayi = new Random().nextInt(100);
                  _oyna();
                  _score();
                },
              ),
            ),
          ],
        )));
  }
}
