import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'constants.dart';
import 'network.dart';
import 'dart:async';
import 'dart:math';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cached_network_image/cached_network_image.dart';

final GlobalKey<ScaffoldState> abrirMenu = GlobalKey();

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<int, String> mangasTitulo = {};
  Map<int, String> mangasSinopse = {};
  Map<int, String> mangasImage = {};
  Map<int, String> mangasGenero = {};

  String busca = '';
  int id = 414;
  String url = '';
  String urlGenre = '';
  dynamic mangaData;
  dynamic mangaData2;

  List<int> listaDrama = [0, 0, 0, 0];
  List<int> listaAction = [0, 0, 0, 0];

  int aux = 0;
  int aux2 = 0;

  int action = 0;
  int drama = 0;
  int existe = 0;
  int existe2 = 0;

  @override
  void initState() {
    super.initState();
    buscarMangasInicio();
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Opa!"),
          content: Text("Área em manutenção!"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showManga(BuildContext context, int i) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: palette3,
          title: Text(
            '${mangasTitulo[listaAction[i]]}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: palette1,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            children: [
              Text('${mangasSinopse[listaAction[i]]}'),
              SizedBox(
                height: 15,
              ),
              Image.network('${mangasImage[listaAction[i]]}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Fechar',
                style: TextStyle(
                  color: palette5,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showMangaDrama(BuildContext context, int i) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: palette3,
          title: Text(
            '${mangasTitulo[listaDrama[i]]}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: palette1,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            children: [
              Text('${mangasSinopse[listaDrama[i]]}'),
              SizedBox(
                height: 15,
              ),
              Image.network('${mangasImage[listaDrama[i]]}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Fechar',
                style: TextStyle(
                  color: palette5,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> getFutureDados() async =>
      await Future.delayed(Duration(seconds: 25), () {
        return true;
      });

  buscarMangasInicio() async {
    String titulo = '';
    String sinopse = '';
    String image_path = '';
    String genero = '';
    int j = 1;
    int number = 414; //default

    while (drama + action < 8) {
      Random random = Random();
      number = random.nextInt(11000);

      url = 'https://kitsu.io/api/edge/manga/$number';

      Network api = Network(url);
      mangaData = await api.getData();

      if (mangaData != -1) {
        if (mangaData != -1) {
          if (mangaData['data']['attributes']['titles']['en'] == null) {
            if (mangaData['data']['attributes']['titles']['en_us'] != null) {
              titulo = mangaData['data']['attributes']['titles']['en_us'];
            } else {
              titulo = mangaData['data']['attributes']['titles']['en_jp'];
            }
          }
          sinopse = mangaData['data']['attributes']['synopsis'];

          image_path = mangaData['data']['attributes']['posterImage']['small'];
        }

        urlGenre = 'https://kitsu.io/api/edge/manga/$number/genres';

        Network api2 = Network(urlGenre);
        mangaData2 = await api2.getData();

        if (mangaData2 != -1) {
          genero = mangaData2['data'][0]['attributes']['name'];

          if ((genero == 'Action' ||
                  genero == 'Adventure' ||
                  genero == 'Horror' ||
                  genero == 'Supernatural' ||
                  genero == 'Police' ||
                  genero == 'Martial Arts' ||
                  genero == 'Super Power' ||
                  genero == 'Fantasy' ||
                  genero == 'Mystery' ||
                  genero == 'Sci-Fi' ||
                  genero == 'Space' ||
                  genero == 'Magic' ||
                  genero == 'Thriller' ||
                  genero == 'Vampire' ||
                  genero == 'Dementia' ||
                  genero == 'Mecha') &&
              action < 4) {
            mangasTitulo[j] = titulo;
            mangasSinopse[j] = sinopse;
            mangasImage[j] = image_path;
            mangasGenero[j] = 'Action';
            action++;
          }
          if ((genero == 'Drama' ||
                  genero == 'Romance' ||
                  genero == 'Psychological' ||
                  genero == 'Historical' ||
                  genero == 'Comedy' ||
                  genero == 'School' ||
                  genero == 'Slice of Life') &&
              drama < 4) {
            mangasTitulo[j] = titulo;
            mangasSinopse[j] = sinopse;
            mangasImage[j] = image_path;
            mangasGenero[j] = 'Drama';
            drama++;
          }
        }
      }
      j++;
    }

    for (int i = 0; i <= j; i++) {
      if (mangasGenero[i] == 'Drama') {
        listaDrama[aux] = i;
        aux++;
      }
    }
    print(listaDrama);

    for (int i = 0; i <= j; i++) {
      if (mangasGenero[i] == 'Action') {
        listaAction[aux2] = i;
        aux2++;
      }
    }
    print(listaAction);
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
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
                    color: palette1,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                color: palette3,
                child: ListTile(
                  onTap: () {
                    _showDialog(context);
                  },
                  title: Text(
                    'Login',
                    style: drawerTexto,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                color: palette3,
                child: ListTile(
                  onTap: () {
                    _showDialog(context);
                  },
                  title: Text(
                    'Explorar',
                    style: drawerTexto,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                color: palette3,
                child: ListTile(
                  onTap: () {
                    _showDialog(context);
                  },
                  title: Text(
                    'Histórico',
                    style: drawerTexto,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                color: palette3,
                child: ListTile(
                  onTap: () {
                    _showDialog(context);
                  },
                  title: Text(
                    'Favoritos',
                    style: drawerTexto,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: Text(
                    'CLOSE MENU',
                    style: drawerTextoEnd,
                    textAlign: TextAlign.center,
                  ),
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
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / (1.3),
                  padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: TextField(
                    onChanged: (value) {
                      busca = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Procure por um título...",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      //buscarMangasInicio();
                    },
                    child: const Text('Go'),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(15, 15),
                      elevation: 4,
                      primary: palette1,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 6, bottom: 6),
              child: const Text(
                'Ação / Aventura',
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
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          _showManga(context, 0);
                        },
                        child: FutureBuilder(
                          future: getFutureDados(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox(
                                height: 200,
                                width: 140,
                                child: Image.asset(
                                  'images/aguardando.png',
                                  fit: BoxFit.fill,
                                ),
                              );
                            } else {
                              return Image.network(
                                  '${mangasImage[listaAction[0]]}');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    color: palette1,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          _showManga(context, 1);
                        },
                        child: FutureBuilder(
                          future: getFutureDados(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox(
                                height: 200,
                                width: 140,
                                child: Image.asset(
                                  'images/aguardando.png',
                                  fit: BoxFit.fill,
                                ),
                              );
                            } else {
                              return Image.network(
                                  '${mangasImage[listaAction[1]]}');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    color: palette1,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          _showManga(context, 2);
                        },
                        child: FutureBuilder(
                          future: getFutureDados(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox(
                                height: 200,
                                width: 140,
                                child: Image.asset(
                                  'images/aguardando.png',
                                  fit: BoxFit.fill,
                                ),
                              );
                            } else {
                              return Image.network(
                                  '${mangasImage[listaAction[2]]}');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    color: palette1,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          _showManga(context, 3);
                        },
                        child: FutureBuilder(
                          future: getFutureDados(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox(
                                height: 200,
                                width: 140,
                                child: Image.asset(
                                  'images/aguardando.png',
                                  fit: BoxFit.fill,
                                ),
                              );
                            } else {
                              return Image.network(
                                  '${mangasImage[listaAction[3]]}');
                            }
                          },
                        ),
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
                'Drama / Comédia ',
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
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          _showMangaDrama(context, 0);
                        },
                        child: FutureBuilder(
                          future: getFutureDados(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox(
                                height: 200,
                                width: 140,
                                child: Image.asset(
                                  'images/aguardando.png',
                                  fit: BoxFit.fill,
                                ),
                              );
                            } else {
                              return Image.network(
                                  '${mangasImage[listaDrama[0]]}');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    color: palette1,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          _showMangaDrama(context, 1);
                        },
                        child: FutureBuilder(
                          future: getFutureDados(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox(
                                height: 200,
                                width: 140,
                                child: Image.asset(
                                  'images/aguardando.png',
                                  fit: BoxFit.fill,
                                ),
                              );
                            } else {
                              return Image.network(
                                  '${mangasImage[listaDrama[1]]}');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    color: palette1,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          _showMangaDrama(context, 2);
                        },
                        child: FutureBuilder(
                          future: getFutureDados(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox(
                                height: 200,
                                width: 140,
                                child: Image.asset(
                                  'images/aguardando.png',
                                  fit: BoxFit.fill,
                                ),
                              );
                            } else {
                              return Image.network(
                                  '${mangasImage[listaDrama[2]]}');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    color: palette1,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          _showMangaDrama(context, 3);
                        },
                        child: FutureBuilder(
                          future: getFutureDados(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox(
                                height: 200,
                                width: 140,
                                child: Image.asset(
                                  'images/aguardando.png',
                                  fit: BoxFit.fill,
                                ),
                              );
                            } else {
                              return Image.network(
                                  '${mangasImage[listaDrama[3]]}');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 6, bottom: 6),
              child: const Text(
                'Random',
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
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          _showManga(context, 1);
                        },
                        child: FutureBuilder(
                          future: getFutureDados(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox(
                                height: 200,
                                width: 140,
                                child: Image.asset(
                                  'images/aguardando.png',
                                  fit: BoxFit.fill,
                                ),
                              );
                            } else {
                              return Image.network(
                                  '${mangasImage[listaAction[1]]}');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    color: palette1,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          _showManga(context, 3);
                        },
                        child: FutureBuilder(
                          future: getFutureDados(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox(
                                height: 200,
                                width: 140,
                                child: Image.asset(
                                  'images/aguardando.png',
                                  fit: BoxFit.fill,
                                ),
                              );
                            } else {
                              return Image.network(
                                  '${mangasImage[listaAction[3]]}');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    color: palette1,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          _showMangaDrama(context, 0);
                        },
                        child: FutureBuilder(
                          future: getFutureDados(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox(
                                height: 200,
                                width: 140,
                                child: Image.asset(
                                  'images/aguardando.png',
                                  fit: BoxFit.fill,
                                ),
                              );
                            } else {
                              return Image.network(
                                  '${mangasImage[listaDrama[0]]}');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    color: palette1,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          _showMangaDrama(context, 2);
                        },
                        child: FutureBuilder(
                          future: getFutureDados(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox(
                                height: 200,
                                width: 140,
                                child: Image.asset(
                                  'images/aguardando.png',
                                  fit: BoxFit.fill,
                                ),
                              );
                            } else {
                              return Image.network(
                                  '${mangasImage[listaDrama[2]]}');
                            }
                          },
                        ),
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
