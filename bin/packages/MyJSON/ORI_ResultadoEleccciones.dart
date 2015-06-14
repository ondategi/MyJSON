library ResultadoEleccciones;

import 'dart:convert' show JSON;

/* El resultado de votos obtenidos por un partido en una mesa
 * en la mesa
 */
class Partido {
  String colorgr15; /// color para gráfico tarta
  String denominacion15; /// nombre largo del partido
  String siglas15; /// siglas del partido
  var votos15; /// votos obtenidos en las elecciones actuales
  var porcen15; /// porcentaje de votos obtenidos en las elecciones actuales
  var conce15; /// concejales obtenidos en las elecciones actuales
  var votos11; /// votos obtenidos en las elecciones pasadas
  var porcen11; /// porcentaje de votos obtenidos en las elecciones pasadas
  var conce11; /// concejales obtenidos en las elecciones pasadas
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
    this.porcen15 = data['porcen15'];
    this.conce15 = data['conce15'];
    this.votos11 = data['votos11'];
    this.porcen11 = data['porcen11'];
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
    this.porcen15 = null;
    this.conce15 = null;
    this.votos11 = null;
    this.porcen11 = null;
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
    'porcen15': porcen15,
    'conce15': conce15,
    'votos11': votos11,
    'porcen11': porcen11,
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
    distritos.forEach((distrito) {
      this.distritos.add(new Distrito(distrito));
    });
  }

  // OBLIGATORIO implementarlo para que sepa convertir el objeto
  // del tipo ResultadosPartido a una cadena json
  Map toJson() => {'distritos': distritos};
}

/**
  * Clase Distrito
  * */
class Distrito {
  int distrito;
  List<Seccion> secciones = new List<Seccion>();

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
      this.secciones.add(new Seccion(seccion));
    });
  }

  // OBLIGATORIO implementarlo para que sepa convertir el objeto
  // del tipo ResultadosPartido a una cadena json
  Map toJson() => {'distrito': distrito, 'secciones': secciones};
}

/**
  * Clase Seccion
  * */
class Seccion {
  int seccion;
  List<Mesa> mesas = new List<Mesa>();

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
      this.mesas.add(new Mesa(mesa));
    });
  }

  // OBLIGATORIO implementarlo para que sepa convertir el objeto
  // del tipo ResultadosPartido a una cadena json
  Map toJson() => {'seccion': seccion, 'mesas': mesas};
}

/**
  * Clase Mesa
  * */
class Mesa {
  String mesa;
  String colegio;
  int electores;
  String blancos15;
  String blancos11;
  String nulos15;
  String nulos11;
  List<Partido> partidos = new List<Partido>();

  /// Crear Mesa desde Map
  Mesa(Map data) {
    this.FromMapToClass(data);
  }

  /// Crear Mesa desde String JSON
  Mesa.fromJson(String json) {
    this.FromMapToClass(JSON.decode(json));
  }

  FromMapToClass(Map data) {
    this.mesa = data['mesa'];
    this.colegio = data['colegio'];
    this.electores = data['electores'];

    this.blancos15 = data['blancos15'];
    this.blancos11 = data['blancos11'];
    this.nulos15 = data['nulos15'];
    this.nulos11 = data['nulos11'];

    /// recoger la lista de partidos
    List partidos = data['partidos'];
    /// , para convertirlos en objetos Partido
    partidos.forEach((partido) {
      this.partidos.add(new Partido(partido));
    });
  }

  // OBLIGATORIO implementarlo para que sepa convertir el objeto
  // del tipo ResultadosPartido a una cadena json
  Map toJson() => {
    'mesa': mesa,
    'colegio': colegio,
    'electores': electores,
    'partidos': partidos,
    'blancos15': blancos15,
    'blancos11': blancos11,
    'nulos15': nulos15,
    'nulos11': nulos11
  };
}
