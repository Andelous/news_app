import 'package:flutter/material.dart';

class TarjetaNoticia extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final String fecha;
  final String urlImagen;

  const TarjetaNoticia({
    super.key,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.urlImagen,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 6),
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Image.network(urlImagen),
              Column(children: [Text(titulo), Text(fecha)]),
            ],
          ),
        ),
      ),
    );
  }
}
