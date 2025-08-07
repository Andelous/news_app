import 'package:flutter/material.dart';
import 'package:news_app/componentes/tarjeta_noticia.dart';
import 'package:news_app/util/cliente_http.dart';
import 'package:news_app/util/noticia.dart';

class PantallaBuscar extends StatefulWidget {
  const PantallaBuscar({super.key});

  @override
  State<PantallaBuscar> createState() => _PantallaBuscarState();
}

class _PantallaBuscarState extends State<PantallaBuscar> {
  List<Noticia> noticias = [];
  bool buscando = false;
  bool error = false;
  bool sinResultados = true;

  String categoria = 'todas';
  String q = '';

  @override
  Widget build(BuildContext context) {
    TextField tf = TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: '¡Busca algo interesante!',
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onSubmitted: (value) {
        q = value;
        buscarNoticias();
      },
    );

    DropdownButton<String> select = DropdownButton(
      items: [
        DropdownMenuItem(value: 'todas', child: Text('Todas')),
        DropdownMenuItem(value: 'business', child: Text('Negocios')),
        DropdownMenuItem(
          value: 'entertainment',
          child: Text('Entretenimiento'),
        ),
        DropdownMenuItem(value: 'health', child: Text('Salud')),
        DropdownMenuItem(value: 'science', child: Text('Ciencia')),
        DropdownMenuItem(value: 'sports', child: Text('Deportes')),
        DropdownMenuItem(value: 'technology', child: Text('Tecnología')),
      ],
      value: categoria,
      onChanged: (val) {
        categoria = val!;
        buscarNoticias();

        setState(() {
          categoria = val!;
        });
      },
    );

    return Column(
      children: [
        Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Column(
            children: [
              tf,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [Text('Categoría:  '), select]),
                  Row(
                    children: [
                      Text('Resultados: '),
                      Text('${noticias.length}'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView(
            children: [
              if (buscando)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ),
              if (error) Center(child: Text('Algo salió mal :(')),
              if (sinResultados) Center(child: Text('No hay resultados')),
              for (Noticia noticia in noticias)
                TarjetaNoticia(noticia: noticia),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  void buscarNoticias() {
    ClienteHttp.buscar(q, categoria).then((res) {
      setState(() {
        buscando = false;
        noticias.clear();

        if (res == null) {
          error = true;
          return;
        }

        noticias.addAll(res);

        sinResultados = noticias.isEmpty;
      });
    });
  }
}
