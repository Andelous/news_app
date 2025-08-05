import 'package:flutter/material.dart';
import 'package:news_app/componentes/tarjeta_noticia.dart';

class PantallaPrincipal extends StatelessWidget {
  final String titulo;

  const PantallaPrincipal({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(titulo),
        TarjetaNoticia(
          descripcion: 'Meow',
          titulo: '¡Esta es la noticia 1!',
          urlImagen:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Flutter_logo.svg/64px-Flutter_logo.svg.png',
          fecha: '20 de junio de 2025',
        ),
        TarjetaNoticia(
          descripcion: 'Meow',
          titulo: '¡Esta es la noticia 2!',
          urlImagen:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Flutter_logo.svg/64px-Flutter_logo.svg.png',
          fecha: '20 de junio de 2025',
        ),
        TarjetaNoticia(
          descripcion: 'Meow',
          titulo: '¡Esta es la noticia 3!',
          urlImagen:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Flutter_logo.svg/64px-Flutter_logo.svg.png',
          fecha: '20 de junio de 2025',
        ),
      ],
    );
  }
}
