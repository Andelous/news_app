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

  _PantallaPrincipalState() {
    print('Instantiating PantallaPrincipal state');
  }

  @override
  void initState() {
    super.initState();
    print('Calling init state!! PantallaPrincipal');
    actualizarNoticias();
  }

  void actualizarNoticias() {
    ClienteHttp.getEverything().then((val) {
      if (val == null) return;

      setState(() {
        noticias = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Running PantallaPrincipal build method');
    return ListView(
      children: [
        Text(widget.titulo),
        for (Noticia noticia in noticias) TarjetaNoticia(noticia: noticia),
      ],
    );
  }
}
