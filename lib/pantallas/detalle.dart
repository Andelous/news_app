import 'package:flutter/material.dart';
import 'package:news_app/util/noticia.dart';
import 'package:url_launcher/url_launcher.dart';

class PantallaDetalle extends StatelessWidget {
  final Noticia noticia;

  const PantallaDetalle({super.key, required this.noticia});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ULSA Noticias',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Detalle de noticia',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(16),
                        child: Image.network(
                          noticia.urlImagen ??
                              'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'images/placeholder.png',
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      noticia.titulo ?? 'Sin título',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.grey, // Line color
                      thickness: 1, // Line thickness
                      height: 20, // Space above and below
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('Por: '),
                            SizedBox(
                              width: 170,
                              child: Text(
                                noticia.autor ?? 'Sin autor',
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          noticia.getFechaLegible(),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(
                      color: Colors.grey, // Line color
                      thickness: 1, // Line thickness
                      height: 20, // Space above and below
                    ),
                    SizedBox(height: 10),
                    Text(
                      noticia.descripcion ?? 'Sin descripción',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: Icon(Icons.launch),
                      label: Text(
                        'Abrir en la web',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Uri _url = Uri.parse(
                          noticia.url ?? 'https://example.com',
                        );

                        launchUrl(_url);
                      },
                    ),
                    // Add more details as needed
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
