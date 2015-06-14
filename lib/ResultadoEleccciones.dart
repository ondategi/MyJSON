library ResultadoEleccciones;

import 'package:intl/intl.dart';
import 'dart:convert' show JSON;

/* El resultado de votos obtenidos por un partido en una mesa
 * en la mesa
 */
class Partido {
  String colorgr15; /// color para gráfico tarta
  String denominacion15; /// nombre largo del partido
  String siglas15; /// siglas del partido
  int votos15 = 0; /// votos obtenidos en las elecciones actuales
  int conce15 = 0; /// concejales obtenidos en las elecciones actuales
  int votos11 = 0; /// votos obtenidos en las elecciones pasadas
  int conce11 = 0; /// concejales obtenidos en las elecciones pasadas
  String colorgr11; /// color para gráfico tarta en las pasadas elecciones
  String denominacion11; /// nombre largo del partido en las pasadas elecciones
  String siglas11; /// siglas del partido en las pasadas elecciones

  /// Crear Partido desde Map
  Partido(Map data) {
    this.FromMapToClass(data);
  }

  /// Crear Partido desde String JSON
  Partido.fromJson(String json) {
    this.FromMapToClass(JSON.decode(json));
  }

  FromMapToClass(Map data) {
    this.colorgr15 = data['colorgr15'];
    this.denominacion15 = data['denominacion15'];
    this.siglas15 = data['siglas15'];
    this.votos15 = data['votos15'];
    this.conce15 = data['conce15'];
    this.votos11 = data['votos11'];
    this.votos11 = data['votos11'];
    this.conce11 = data['conce11'];
    this.colorgr11 = data['colorgr11'];
    this.denominacion11 = data['denominacion11'];
    this.siglas11 = data['siglas11'];
  }

  Partido.NUEVO() {
    this.colorgr15 = "p00XX informar color para gáficas";
    this.denominacion15 = "informar nombre completo del partido";
    this.siglas15 = "informar siglas del partido";
    this.votos15 = null;
    this.conce15 = null;
    this.votos11 = null;
    this.votos11 = null;
    this.conce11 = null;
    this.colorgr11 = "p00XX informar color anterior para gáficas";
    this.denominacion11 = "informar nombre completo anterior del partido";
    this.siglas11 = "informar siglas anteriores del partido";
  }

  /* OBLIGATORIO implementarlo para que sepa convertir el objeto
   * del tipo resultadoPartido a una cadena JSON. Usamos comilla simple
   * pues todavía no es JSON, es Dart
   */
  Map toJson() => {
    'colorgr15': colorgr15,
    'denominacion15': denominacion15,
    'siglas15': siglas15,
    'votos15': votos15,
    'conce15': conce15,
    'votos11': votos11,
    'conce11': conce11,
    'colorgr11': colorgr11,
    'denominacion11': denominacion11,
    'siglas11': siglas11
  };
  // {
  //    DateTime nowDate = new DateTime.now();
  //    int nowValue = nowDate.millisecondsSinceEpoch;  // versus nowDate.millisecond ?
  //    _timeStamp = nowValue + _increment++;
  //    String oid = _timeStamp.toString();
}

/**
  * Clase ResultadoEleccciones
  * */
class ResultadoEleccciones {
  List<Distrito> distritos = new List<Distrito>();

  int escrutado15 = 0;
  int escrutado11 = 0;
  int electores15 = 0;
  int validos15 = 0;
  int blancos15 = 0;
  int nulos15 = 0;
  int electores11 = 0;
  int validos11 = 0;
  int blancos11 = 0;
  int nulos11 = 0;

  String ParaImprimir11;
  String ParaImprimir15;

  int SUMAvotospartidos15 = 0; //SUMA de votos a partidos en eleccion actual
  int SUMAvotospartidos11 = 0; //SUMA de votos a partidos en eleccion pasada

  /// Crear ResultadoEleccciones desde Map
  ResultadoEleccciones(Map data) {
    this.FromMapToClass(data);
  }

  /// Crear ResultadoEleccciones desde String JSON
  ResultadoEleccciones.fromJson(String json) {
    this.FromMapToClass(JSON.decode(json));
  }

  FromMapToClass(Map data) {
    /// recoger la lista de distritos
    List distritos = data['resultadoelectoral'];
    /// , para convertirlas en objetos Distrito
    distritos.forEach((seccion) {
      Distrito tempDistrito = new Distrito(seccion);
      this.distritos.add(tempDistrito);

      this.electores15 += tempDistrito.electores15;
      this.validos15 += tempDistrito.validos15;
      this.escrutado15 += tempDistrito.escrutado15;
      this.blancos15 += tempDistrito.blancos15;
      this.nulos15 += tempDistrito.nulos15;
      this.electores11 += tempDistrito.electores11;
      this.validos11 += tempDistrito.validos11;
      this.escrutado11 += tempDistrito.escrutado11;
      this.blancos11 += tempDistrito.blancos11;
      this.nulos11 += tempDistrito.nulos11;

      ParaImprimir15 = '2015 - Resultados: ' +
          ' Escrutado: ' +
          new NumberFormat("#0.00%", "es_ES")
              .format(this.escrutado15 / this.electores15) +
          ' Electores: ' +
          this.electores15.toString() +
          ' Válidos: ' +
          this.validos15.toString() +
          ' Blancos: ' +
          this.blancos15.toString() +
          ' Nulos: ' +
          this.nulos15.toString() +
          ' Participación: ' +
          new NumberFormat("#0.00%", "es_ES")
              .format((this.validos15 + this.nulos15) / this.electores15);

      ParaImprimir11 = '2011 - Resultados: ' +
          ' Escrutado: ' +
          new NumberFormat("#0.00%", "es_ES")
              .format(this.escrutado11 / this.electores11) +
          ' Electores: ' +
          this.electores11.toString() +
          ' Válidos: ' +
          this.validos11.toString() +
          ' Blancos: ' +
          this.blancos11.toString() +
          ' Nulos: ' +
          this.nulos11.toString() +
          ' Participación: ' +
          new NumberFormat("#0.00%", "es_ES")
              .format((this.validos11 + this.nulos11) / this.electores11);
    });
  }

  // OBLIGATORIO implementarlo para que sepa convertir el objeto
  // del tipo ResultadosPartido a una cadena json
  Map toJson() => {
    'electores15': electores15,
    'validos15': validos15,
    'escrutado15': escrutado15,
    'escrutado11': escrutado11,
    'blancos15': blancos15,
    'nulos15': nulos15,
    'electores11': electores11,
    'validos11': validos11,
    'blancos11': blancos11,
    'nulos11': nulos11,
    'distritos': distritos
  };
}

/**
  * Clase Distrito
  * */
class Distrito {
  int distrito = 0;
  List<Seccion> secciones = new List<Seccion>();

  int escrutado15 = 0;
  int escrutado11 = 0;
  int electores15 = 0;
  int validos15 = 0;
  int blancos15 = 0;
  int nulos15 = 0;
  int electores11 = 0;
  int validos11 = 0;
  int blancos11 = 0;
  int nulos11 = 0;

  String ParaImprimir11;
  String ParaImprimir15;

  int SUMAvotospartidos15 = 0; //SUMA de votos a partidos en eleccion actual
  int SUMAvotospartidos11 = 0; //SUMA de votos a partidos en eleccion pasada

  /// Crear Distrito desde Map
  Distrito(Map data) {
    this.FromMapToClass(data);
  }

  /// Crear Distrito desde String JSON
  Distrito.fromJson(String json) {
    this.FromMapToClass(JSON.decode(json));
  }

  FromMapToClass(Map data) {
    this.distrito = data['distrito'];

    /// recoger la lista de secciones
    List secciones = data['secciones'];
    /// , para convertirlas en objetos Seccion
    secciones.forEach((seccion) {
      Seccion tempSeccion = new Seccion(seccion);
      this.secciones.add(tempSeccion);

      this.electores15 += tempSeccion.electores15;
      this.validos15 += tempSeccion.validos15;
      this.escrutado15 += tempSeccion.escrutado15;
      this.blancos15 += tempSeccion.blancos15;
      this.nulos15 += tempSeccion.nulos15;
      this.electores11 += tempSeccion.electores11;
      this.validos11 += tempSeccion.validos11;
      this.escrutado11 += tempSeccion.escrutado11;
      this.blancos11 += tempSeccion.blancos11;
      this.nulos11 += tempSeccion.nulos11;

      ParaImprimir15 = '---->2015 - Distrito: ' +
          this.distrito.toString() +
          ' Escrutado: ' +
          new NumberFormat("#0.00%", "es_ES")
              .format(this.escrutado15 / this.electores15) +
          ' Electores: ' +
          this.electores15.toString() +
          ' Válidos: ' +
          this.validos15.toString() +
          ' Blancos: ' +
          this.blancos15.toString() +
          ' Nulos: ' +
          this.nulos15.toString() +
          ' Participación: ' +
          new NumberFormat("#0.00%", "es_ES")
              .format((this.validos15 + this.nulos15) / this.electores15);

      ParaImprimir11 = '---->2011 - Distrito: ' +
          this.distrito.toString() +
          ' Escrutado: ' +
          new NumberFormat("#0.00%", "es_ES")
              .format(this.escrutado11 / this.electores11) +
          ' Electores: ' +
          this.electores11.toString() +
          ' Válidos: ' +
          this.validos11.toString() +
          ' Blancos: ' +
          this.blancos11.toString() +
          ' Nulos: ' +
          this.nulos11.toString() +
          ' Participación: ' +
          new NumberFormat("#0.00%", "es_ES")
              .format((this.validos11 + this.nulos11) / this.electores11);
    });
  }

  // OBLIGATORIO implementarlo para que sepa convertir el objeto
  // del tipo ResultadosPartido a una cadena json
  Map toJson() => {
    'distrito': distrito,
    'electores15': electores15,
    'validos15': validos15,
    'escrutado15': escrutado15,
    'escrutado11': escrutado11,
    'blancos15': blancos15,
    'nulos15': nulos15,
    'electores11': electores11,
    'validos11': validos11,
    'blancos11': blancos11,
    'nulos11': nulos11,
    'secciones': secciones
  };
}

/**
  * Clase Seccion
  * */
class Seccion {
  int seccion;
  List<Mesa> mesas = new List<Mesa>();

  int escrutado15 = 0;
  int escrutado11 = 0;
  int electores15 = 0;
  int validos15 = 0;
  int blancos15 = 0;
  int nulos15 = 0;
  int electores11 = 0;
  int validos11 = 0;
  int blancos11 = 0;
  int nulos11 = 0;

  String ParaImprimir11;
  String ParaImprimir15;

  int SUMAvotospartidos15 = 0; //SUMA de votos a partidos en eleccion actual
  int SUMAvotospartidos11 = 0; //SUMA de votos a partidos en eleccion pasada

  /// Crear Seccion desde Map
  Seccion(Map data) {
    this.FromMapToClass(data);
  }

  /// Crear Seccion desde String JSON
  Seccion.fromJson(String json) {
    this.FromMapToClass(JSON.decode(json));
  }

  FromMapToClass(Map data) {
    this.seccion = data['seccion'];

    /// recoger la lista de mesas
    List mesas = data['mesas'];
    /// , para convertirlas en objetos Mesa
    mesas.forEach((mesa) {
      Mesa tempMesa = new Mesa(mesa);
      this.mesas.add(tempMesa);

      this.electores15 += tempMesa.electores15;
      this.validos15 += tempMesa.validos15;
      if (tempMesa.escrutada15) {
        this.escrutado15 += tempMesa.electores15;
      }
      this.blancos15 += tempMesa.blancos15;
      this.nulos15 += tempMesa.nulos15;
      this.electores11 += tempMesa.electores11;
      this.validos11 += tempMesa.validos11;
      if (tempMesa.escrutada11) {
        this.escrutado11 += tempMesa.electores11;
      }
      this.blancos11 += tempMesa.blancos11;
      this.nulos11 += tempMesa.nulos11;

      ParaImprimir15 = '-------->2015 - Sección: ' +
          this.seccion.toString() +
          ' Escrutado: ' +
          new NumberFormat("#0.00%", "es_ES")
              .format(this.escrutado15 / this.electores15) +
          ' Electores: ' +
          this.electores15.toString() +
          ' Válidos: ' +
          this.validos15.toString() +
          ' Blancos: ' +
          this.blancos15.toString() +
          ' Nulos: ' +
          this.nulos15.toString() +
          ' Participación: ' +
          new NumberFormat("#0.00%", "es_ES")
              .format((this.validos15 + this.nulos15) / this.electores15);

      ParaImprimir11 = '-------->2011 - Sección: ' +
          this.seccion.toString() +
          ' Escrutado: ' +
          new NumberFormat("#0.00%", "es_ES")
              .format(this.escrutado11 / this.electores11) +
          ' Electores: ' +
          this.electores11.toString() +
          ' Válidos: ' +
          this.validos11.toString() +
          ' Blancos: ' +
          this.blancos11.toString() +
          ' Nulos: ' +
          this.nulos11.toString() +
          ' Participación: ' +
          new NumberFormat("#0.00%", "es_ES")
              .format((this.validos11 + this.nulos11) / this.electores11);
    });
  }

  // OBLIGATORIO implementarlo para que sepa convertir el objeto
  // del tipo ResultadosPartido a una cadena json
  Map toJson() => {
    'seccion': seccion,
    'escrutado15': escrutado15,
    'escrutado11': escrutado11,
    'electores15': electores15,
    'validos15': validos15,
    'blancos15': blancos15,
    'nulos15': nulos15,
    'electores11': electores11,
    'validos11': validos11,
    'blancos11': blancos11,
    'nulos11': nulos11,
    'mesas': mesas
  };
}

/**
  * Clase Mesa
  * */
class Mesa {
  List<Partido> partidos = new List<Partido>();
  bool escrutada11;
  bool escrutada15;
  String mesa;
  String colegio;
  int electores15 = 0;
  int validos15 = 0;
  int blancos15 = 0;
  int nulos15 = 0;
  int electores11 = 0;
  int validos11 = 0;
  int blancos11 = 0;
  int nulos11 = 0;

  int SUMAvotospartidos15 = 0; //SUMA de votos a partidos en eleccion actual
  int SUMAvotospartidos11 = 0; //SUMA de votos a partidos en eleccion pasada

  String ParaImprimir11;
  String ParaImprimir15;

  /// Crear Mesa desde Map
  Mesa(Map data) {
    this.FromMapToClass(data);
  }

  /// Crear Mesa desde String JSON
  Mesa.fromJson(String json) {
    this.FromMapToClass(JSON.decode(json));
  }

  FromMapToClass(Map data) {
    /// recoger la lista de partidos
    List partidos = data['partidos'];
    /// , para convertirlos en objetos Partido
    partidos.forEach((partido) {
      // acumular la SUMA de votos a partidos
      this.SUMAvotospartidos15 += partido["votos15"];
      this.SUMAvotospartidos11 += partido["votos11"];
      this.partidos.add(new Partido(partido));
    });

    this.mesa = data['mesa'];
    this.colegio = data['colegio'];
    this.electores15 = data['electores15'];
    this.validos15 = data['blancos15'] + this.SUMAvotospartidos15;
    this.escrutada15 = (this.validos15 != 0);
    this.blancos15 = data['blancos15'];
    this.nulos15 = data['nulos15'];
    this.electores11 = data['electores11'];
    this.validos11 = data['blancos11'] + this.SUMAvotospartidos11;
    this.escrutada11 = (this.validos11 != 0);
    this.blancos11 = data['blancos11'];
    this.nulos11 = data['nulos11'];

    ParaImprimir15 = '------------>2015 - Mesa: ' +
        this.mesa +
        ' Escrutada: ' +
        (this.escrutada15 ? 'SI' : 'NO') +
        ' Electores: ' +
        this.electores15.toString() +
        ' Válidos: ' +
        this.validos15.toString() +
        ' Blancos: ' +
        this.blancos15.toString() +
        ' Nulos: ' +
        this.nulos15.toString() +
        ' Participación: ' +
        new NumberFormat("#0.00%", "es_ES")
            .format((this.validos15 + this.nulos15) / this.electores15);

    ParaImprimir11 = '------------>2011 - Mesa: ' +
        this.mesa +
        ' Escrutada: ' +
        (this.escrutada11 ? 'SI' : 'NO') +
        ' Electores: ' +
        this.electores11.toString() +
        ' Válidos: ' +
        this.validos11.toString() +
        ' Blancos: ' +
        this.blancos11.toString() +
        ' Nulos: ' +
        this.nulos11.toString() +
        ' Participación: ' +
        new NumberFormat("#0.00%", "es_ES")
            .format((this.validos11 + this.nulos11) / this.electores11);
  }

  // OBLIGATORIO implementarlo para que sepa convertir el objeto
  // del tipo ResultadosPartido a una cadena json
  Map toJson() => {
    'mesa': mesa,
    'escrutada11': escrutada11,
    'escrutada15': escrutada15,
    'colegio': colegio,
    'electores15': electores15,
    'validos15': validos15,
    'blancos15': blancos15,
    'nulos15': nulos15,
    'electores11': electores11,
    'blancos11': blancos11,
    'nulos11': nulos11,
    'validos11': validos11,
    'partidos': partidos
  };
}
