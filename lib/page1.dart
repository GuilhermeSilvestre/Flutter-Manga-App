import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'constants.dart';

final GlobalKey<ScaffoldState> abrirMenu = GlobalKey();

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Opa!"),
          content: new Text("Área em manutenção!"),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: palette2,
      key: abrirMenu,
      drawer: Container(
        width: MediaQuery.of(context).size.width / (1.4),
        height: MediaQuery.of(context).size.height / (1.1),
        child: Drawer(
          backgroundColor: palette1,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                //alignment: Alignment.center,
                height: 100,
                child: DrawerHeader(
                  child: Text(
                    'MENU',
                    textAlign: TextAlign.center,
                    style: appBarTexto,
                  ),
                  decoration: BoxDecoration(
                    color: palette2,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  _showDialog(context);
                },
                title: Text(
                  'Login',
                  style: drawerTexto,
                ),
              ),
              ListTile(
                onTap: () {
                  _showDialog(context);
                },
                title: Text(
                  'Explorar',
                  style: drawerTexto,
                ),
              ),
              ListTile(
                onTap: () {
                  _showDialog(context);
                },
                title: Text(
                  'Histórico',
                  style: drawerTexto,
                ),
              ),
              ListTile(
                onTap: () {
                  _showDialog(context);
                },
                title: Text(
                  'Favoritos',
                  style: drawerTexto,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                title: Text(
                  'CLOSE MENU',
                  style: drawerTexto,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: palette1,
        title: Text(
          "MangApp",
          style: appBarTexto,
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            abrirMenu.currentState!.openDrawer();
          },
          child: const Icon(
            Icons.menu_rounded,
            color: palette5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 6, bottom: 6),
              child: const Text(
                'Ação',
                style: textoPaginaPrincipal,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 140,
                    color: palette1,
                    child: const Center(
                        child: Text(
                      'Item 1',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    width: 140,
                    color: palette3,
                    child: const Center(
                        child: Text(
                      'Item 2',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    width: 140,
                    color: palette1,
                    child: const Center(
                        child: Text(
                      'Item 3',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    width: 140,
                    color: palette3,
                    child: const Center(
                      child: Text(
                        'Item 4',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 6, bottom: 6),
              child: const Text(
                'Horror',
                style: textoPaginaPrincipal,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 140,
                    color: palette1,
                    child: const Center(
                        child: Text(
                      'Item 1',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    width: 140,
                    color: palette3,
                    child: const Center(
                        child: Text(
                      'Item 2',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    width: 140,
                    color: palette1,
                    child: const Center(
                        child: Text(
                      'Item 3',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    width: 140,
                    color: palette3,
                    child: const Center(
                      child: Text(
                        'Item 4',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 6, bottom: 6),
              child: const Text(
                'Psicológico',
                style: textoPaginaPrincipal,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 140,
                    color: palette1,
                    child: const Center(
                        child: Text(
                      'Item 1',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    width: 140,
                    color: palette3,
                    child: const Center(
                        child: Text(
                      'Item 2',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    width: 140,
                    color: palette1,
                    child: const Center(
                        child: Text(
                      'Item 3',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    width: 140,
                    color: palette3,
                    child: const Center(
                      child: Text(
                        'Item 4',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 6, bottom: 6),
              child: const Text(
                'Romance',
                style: textoPaginaPrincipal,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 140,
                    color: palette1,
                    child: const Center(
                        child: Text(
                      'Item 1',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    width: 140,
                    color: palette3,
                    child: const Center(
                        child: Text(
                      'Item 2',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    width: 140,
                    color: palette1,
                    child: const Center(
                        child: Text(
                      'Item 3',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    width: 140,
                    color: palette3,
                    child: const Center(
                      child: Text(
                        'Item 4',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                'Copyright\nAll rights reserved',
                style: textoRodape,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
