import 'package:flutter/material.dart';
import 'package:news_app/componentes/tarjeta_noticia.dart';
import 'package:news_app/util/cliente_http.dart';
import 'package:news_app/util/noticia.dart';

class PantallaPrincipal extends StatefulWidget {
  final String titulo;

  const PantallaPrincipal({super.key, required this.titulo});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  List<Noticia> noticias = [];
  final ScrollController _scrollController = ScrollController();
  bool cargando = false;
  bool reachedEnd = false;
  int pagina = 1;

  _PantallaPrincipalState() {
    print('Instantiating PantallaPrincipal state');
  }

  @override
  void initState() {
    super.initState();
    print('Calling init state!! PantallaPrincipal');

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        actualizarNoticias();
      }
    });

    actualizarNoticias();
  }

  void actualizarNoticias() {
    if (cargando || reachedEnd) return;

    print('Cargando noticias!!!');

    setState(() {
      cargando = true;
    });

    ClienteHttp.getEverything(pagina++).then((val) {
      setState(() {
        cargando = false;
      });

      if (val == null) return;

      if (val.isEmpty) {
        setState(() {
          reachedEnd = true;
        });
      }

      setState(() {
        noticias.addAll(val);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Running PantallaPrincipal build method');
    Widget w;

    if (cargando) {
      w = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator()],
      );
    } else if (reachedEnd) {
      w = Column(
        children: [
          Center(
            child: Text(
              'No hay más noticias :(',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          SizedBox(height: 20),
        ],
      );
    } else {
      w = SizedBox(height: 1);
    }

    return ListView(
      controller: _scrollController,
      children: [
        Text(widget.titulo),
        SizedBox(height: 20),
        for (Noticia noticia in noticias) TarjetaNoticia(noticia: noticia),
        SizedBox(height: 20),
        w,
      ],
    );
  }
}
