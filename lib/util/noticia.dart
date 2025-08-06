import 'package:intl/intl.dart';

class Noticia {
  final String? titulo;
  final String? descripcion;
  final String? fecha;
  final String? urlImagen;
  final String? url;
  final String? fuente;
  final String? autor;

  Noticia({
    this.titulo,
    this.descripcion,
    this.fecha,
    this.url,
    this.urlImagen,
    this.fuente,
    this.autor,
  });

  String getFechaLegible() {
    if (fecha == null) return 'Sin fecha';

    DateTime? val = DateTime.tryParse(fecha!)?.toLocal();

    if (val == null) return '';

    return DateFormat.yMMMMd('es_MX').format(val);
  }
}
