import 'package:flutter/material.dart';
import 'package:news_app/componentes/tarjeta_noticia.dart';
import 'package:news_app/util/favoritos_model.dart';
import 'package:news_app/util/noticia.dart';
import 'package:provider/provider.dart';

class PantallaFavoritos extends StatelessWidget {
  const PantallaFavoritos({super.key});

  @override
  Widget build(BuildContext context) {
    FavoritosModel favoritosModel = context.watch<FavoritosModel>();
    List<Noticia> favoritos = favoritosModel.obtenerFavoritosLista();

    return ListView(
      children: [
        DefaultTextStyle(
          style: TextStyle(fontSize: 25, color: Colors.black),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('¡Tienes '),
                Text(
                  '${favoritos.length}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber[600],
                  ),
                ),
                Text(' favorito(s)!'),
              ],
            ),
          ),
        ),

        for (Noticia noticia in favoritos) TarjetaNoticia(noticia: noticia),

        SizedBox(height: 30),
      ],
    );
  }
}
