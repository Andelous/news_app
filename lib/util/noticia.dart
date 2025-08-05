import 'package:intl/intl.dart';

class Noticia {
  final String titulo;
  final String descripcion;
  final String fecha;
  final String urlImagen;
  final String url;
  final String fuente;
  final String autor;

  Noticia({
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.url,
    required this.urlImagen,
    required this.fuente,
    required this.autor,
  });

  String getFechaLegible() {
    DateTime? val = DateTime.tryParse(fecha)?.toLocal();

    if (val == null) return '';

    return DateFormat.yMMMMd('es_MX').format(val);
  }
}
