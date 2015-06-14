import 'dart:convert' show JSON;
import 'dart:io';
import 'dart:async';

import '../lib/ORI_ResultadoEleccciones.dart';

String contenidoEnString;
List contenidoEnLista;

final String ficheroALeer = './resultados.json';
final String ficheroAGuardar = './config2.txt';

/**
  * Lee la cadena [json] y devuelve el contenido en un Map
  *
  * Ejemplo de cadena [json]
  * [
    {"score": 40},
    {"score": 80},
    {"score":100,"overtime":true,"special_guest":null}
    ]
  *
  * NOTA: Usar comillas dobles ("), no simples ('), en la cadena
  * que va dentro de [json]. Esta cadena es JSON, no Dart.
  * */
JSONToList(String json) {
  /// carga el contenido del JSON de resultados, que en este caso viene
  /// como un Map, y lo convierte en un Objeto ResultadoEleccciones
  ResultadoEleccciones resultado = new ResultadoEleccciones(JSON.decode(json));

  print('holaaaa $resultado');
}

/**
  * Lee la Lista [json] y codifica el contenido en formato JSON
  * devolviendo un String con la cadena JSON
  *
  * Ejemplo de Lista [json]
  *   var scores = [
    {'score': 40},
    {'score': 80},
    {'score': 100, 'overtime': true, 'special_guest': null}
    ];
  *
  * NOTA: Se usan comillas simples ('), no dobles ("), en la cadena
  * ejemplo para la Lista [json]. Esta cadena es Dart, no JSON.
 */
ListToJSON(List json) {
  /* var scores = [
    {'score': 40},
    {'score': 80},
    {'score': 100, 'overtime': true, 'special_guest': null}
  ];*/

  var jsonText = JSON.encode(json);
  /*assert(jsonText == '[{"score":40},{"score":80},'
                     '{"score":100,"overtime":true,'
                     '"special_guest":null}]');*/

  print('ListToJSON' + jsonText);
  return jsonText;
}

GuardaFichero(String file, String contenido) {
  new File(file).writeAsString(contenido).then((File file) {
    // Do something with the file.
  });
}

/**
   * Lee el contenido COMPLETO del [fichero] y lo devuelve como un [Future<String>]
   *
   */
Future<String> CargarFicheroCompleto(String fichero) {

  // cargar fichero de datos
  var config = new File(fichero);

  final c = new Completer();

  // Poner el fichero 'completo' en un solo String
  config.readAsString().then((contenido) {
    c.complete(contenido);
  });
  return c.future;
}

/**
  * Lee el contenido COMPLETO del [fichero] y lo devuelve como un [Future<List>]
  * que contiene Item por cada linea leida del fichero
  *
  */
Future<List> CargarLineasdeFichero(String fichero) {

  // cargar fichero de datos
  var config = new File(fichero);

  final c = new Completer();

  // Poner el fichero 'completo' en un solo String
  config.readAsLines().then((lineasdeDatos) {
    c.complete(lineasdeDatos);
  });
  return c.future;
}

void main() {

  // cargar fichero de datos

  CargarFicheroCompleto(ficheroALeer).then((String result) {
    // para TEST, luego borrar
    print('El fichero completo tiene ${result.length} caracteres');
    print(result);

    contenidoEnString = result;

    //Decodificar desde JSON
    JSONToList(contenidoEnString);

    /* guardar el contenido del fichero como String
     * para su uso posterior
     */
    GuardaFichero(ficheroAGuardar, contenidoEnString);
  }).whenComplete(() {
    print('Se ha leido el contenido del fichero.');
    print(contenidoEnString);
  });

  print("Se está leyendo el fichero COMPLETO ...");

  CargarLineasdeFichero(ficheroALeer).then((List result) {
    /* guardar el contenido del fichero como Lista
     * para su uso posterior
     */
    contenidoEnLista = result;

    // para TEST, luego borrar
    print('La LISTA de lineas del fichero está leida');
    print('El fichero completo tiene ${result.length} lineas');
    print(result);
    print(contenidoEnLista);
  });

  print("Se está leyendo el fichero por LINEAS...");

  print("Hello, World!");

  print('de momento nada que mostrar ' + contenidoEnString.toString());
}
