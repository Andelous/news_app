import 'package:flutter/material.dart';
import 'package:news_app/pantallas/detalle.dart';
import 'package:news_app/util/noticia.dart';

class TarjetaNoticia extends StatelessWidget {
  final Noticia noticia;

  const TarjetaNoticia({super.key, required this.noticia});

  @override
  Widget build(BuildContext context) {
    Image imagen = Image.network(
      noticia.urlImagen ??
          'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
      height: 150,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'images/placeholder.png',
          height: 150,
          fit: BoxFit.contain,
        );
      },
    );

    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 6),
        elevation: 5,
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PantallaDetalle(noticia: noticia),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    child: imagen,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  noticia.titulo ?? 'Sin título',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        noticia.fuente ?? 'Sin fuente',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Text(noticia.getFechaLegible()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
