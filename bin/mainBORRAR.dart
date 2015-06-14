// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import '../lib/ORI_ResultadoEleccciones.dart';

import 'package:xml/xml.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:convert';

void procesarResultados(ResultadoEleccciones resultado) {}

void main() {
  new File('./votos.xml').readAsString(encoding: Encoding.getByName('ISO_8859-1')).then((String contents3) {
    // Do something with the file contents.

    XmlDocument votosXML = parse(contents3);

    // tomar solo los datos bajo la etiqueta partidos
    var partidos = votosXML.findAllElements('partido');

    // pasar a lista para recorrer
    List resultadosXML = partidos.toList();

    // crear una lista para cada tipo de dato a guardar
    List desc = new List();
    List desclarga = new List();
    List descant = new List();
    List desclargaant = new List();
    List color = new List();
    List colorant = new List();
    List mesas = new List();
    List votantes = new List();
    List porce = new List();
    List mesasp = new List();
    List votantesp = new List();
    List porcep = new List();
    List mesasm = new List();
    List votantesm = new List();
    List porcem = new List();

    resultadosXML.forEach((partido) {
      var branch = partido.findElements('desc');
      desc.add(branch.first.text);

      branch = partido.findElements('desclarga');
      desclarga.add(branch.first.text);

      branch = partido.findElements('desc');
      descant.add(branch.first.text);

      branch = partido.findElements('desclarga');
      desclargaant.add(branch.first.text);

      branch = partido.findElements('mesas');
      mesas.add(branch.first.text);

      branch = partido.findElements('color');
      color.add(branch.first.text);

      branch = partido.findElements('colorant');
      colorant.add(branch.first.text);

      branch = partido.findElements('votantes');
      votantes.add(branch.first.text);

      branch = partido.findElements('porce');
      porce.add(branch.first.text);

      branch = partido.findElements('mesasp');
      mesasp.add(branch.first.text);

      branch = partido.findElements('votantesp');
      votantesp.add(branch.first.text);

      branch = partido.findElements('porcep');
      porcep.add(branch.first.text);

      branch = partido.findElements('mesasm');
      mesasm.add(branch.first.text);

      branch = partido.findElements('votantesm');
      votantesm.add(branch.first.text);

      branch = partido.findElements('porcem');
      porcem.add(branch.first.text);
    });

    new File('./plantillaHTM.txt').readAsString(encoding: Encoding.getByName('ISO_8859-1')).then((String contents) {
      // Do something with the file contents.
      //  print('Could not read $contents');

      var now = new DateTime.now();
      var formatter = new DateFormat('HH:mm');
      String horaescru = formatter.format(now);

      String nueva = contents.replaceAll('HORAESCRU', horaescru);
      nueva = nueva.replaceAll('PORCEESCRU', porce[1]);

      nueva = nueva.replaceAll('TOTALVOTANTES15', votantes[16]);
      nueva = nueva.replaceAll('PORCENPARTICIPACION15', porce[16]);
      nueva = nueva.replaceAll('PORCENPARTICIPACION11', porcep[16]);
      nueva = nueva.replaceAll('TOTALABSTENCION15', votantes[17]);
      nueva = nueva.replaceAll('PORCENABSTENCION15', porce[17]);
      nueva = nueva.replaceAll('PORCENABSTENCION11', porcep[17]);
      nueva = nueva.replaceAll('TOTALNULOS15', votantes[15]);
      nueva = nueva.replaceAll('PORCENNULOS15', porce[15]);
      nueva = nueva.replaceAll('PORCENNULOS11', porcep[15]);
      nueva = nueva.replaceAll('TOTALBLANCOS15', votantes[13]);
      nueva = nueva.replaceAll('PORCENBLANCOS15', porce[13]);
      nueva = nueva.replaceAll('PORCENBLANCOS11', porcep[13]);

      String coloractual;
      String coloranterior;

      // número de partidos que se presentan a las elecciones actuales
      var numpartidosActual = 9;
      // número de partidos que se presentaros a las elecciones anteriores, y no se presentan a las actuales
      var numpartidosPasadasNoActual = 3;
      // número TOTAL de partidos que hay que presentar en la web
      var numpartidosTotal = numpartidosActual + numpartidosPasadasNoActual;

      List sustituirHTML = [
        '_class_colorgr_DIV',
        '_class_siglas15_titmov15_title_DENOMINACION',
        '_class_siglas15_titmov15_valor_SIGLAS',
        '_class_vots_s15_valor_VOTOS',
        '_class_porc_porcentaje1_s15_valor_PORCENTAJE',
        '_class_dip_s15_valor_CONCEJALES',
        '_class_dip_s11_separa_valor_CONCEJALES',
        '_class_vots_s11_valor_VOTOS',
        '_class_porc_porcentaje2_s11_valor_PORCENTAJE',
        '_class_siglas11_s11_titmov11_title_DENOMINACION',
        '_class_siglas11_s11_titmov11_valor_SIGLAS',
        '_class_colorgr_s11_DIV'
      ];

      // bucle para actualizar datos de los partidos
      for (var i = 2; i < 11; i++) {
        // primero manejar color
        // si  saca concejales, se activa el color, si no saca se desactiva
        if (int.parse(mesas[i].toString()) > 0) {
          // hay que activar color actual
          coloractual = color[i] + '" style="border-top-style: solid;" title="Color ' + desc[i];
        } else {
          // hay que desactivar color actual
          coloractual = color[i];
        }

        // si  sacó concejales anteriormente, se activa el color, si no sacó se desactiva
        if (int.parse(mesasp[i]) > 0) {
          // hay que activar color actual
          coloranterior = colorant[i] + '" style="border-top-style: solid;" title="Color ' + desc[i];
        } else {
          // hay que desactivar color anterior
          coloranterior = colorant[i];
          // y poner en blanco en lugar de cero, los concejales, los votos, el porcentaje, y las descripciones de la convocatoria anterior
          mesasp[i] = '';
          porcep[i] = '';
          votantesp[i] = '';
          descant[i] = '';
          desclargaant[i] = '';
        }

        var numpar = i - 1;
        String partidoquetoca = 'PARTIDO' + numpar.toString();

        nueva = nueva.replaceAll(partidoquetoca + sustituirHTML[0], coloractual);
        nueva = nueva.replaceAll(partidoquetoca + sustituirHTML[1], desclarga[i]);
        nueva = nueva.replaceAll(partidoquetoca + sustituirHTML[2], desc[i]);
        nueva = nueva.replaceAll(partidoquetoca + sustituirHTML[3], votantes[i]);
        nueva = nueva.replaceAll(partidoquetoca + sustituirHTML[4], porce[i]);
        nueva = nueva.replaceAll(partidoquetoca + sustituirHTML[5], mesas[i]);
        nueva = nueva.replaceAll(partidoquetoca + sustituirHTML[6], mesasp[i]);
        nueva = nueva.replaceAll(partidoquetoca + sustituirHTML[7], votantesp[i]);
        nueva = nueva.replaceAll(partidoquetoca + sustituirHTML[8], porcep[i]);
        nueva = nueva.replaceAll(partidoquetoca + sustituirHTML[9], desclargaant[i]);
        nueva = nueva.replaceAll(partidoquetoca + sustituirHTML[10], descant[i]);
        nueva = nueva.replaceAll(partidoquetoca + sustituirHTML[11], coloranterior);
      }

      Map partidosNo15Si11 = JSON.decode(
          '{"partido1":{"colorgr15":"p0000","denominacion15":null,"siglas15":null,"votos15":null,"porcen15":null,"conce15":null,"conce11":null,"votos11":487,"porcen11":"3,02%","siglas11":"NA BAI 2011","denominacion11":"NAFARROA BAI 2011","colorgr11":"p0000"},"partido2":{"colorgr15":"p0000","denominacion15":null,"siglas15":null,"votos15":null,"porcen15":null,"conce15":null,"conce11":null,"votos11":383,"porcen11":"2,37%","siglas11":"BILDU-EA","denominacion11":"BILDU-EUSKO ALKARTASUNA","colorgr11":"p0000"},"partido3":{"colorgr15":"p0000","denominacion15":null,"siglas15":null,"votos15":null,"porcen15":null,"conce15":null,"conce11":null,"votos11":97,"porcen11":"0,60%","siglas11":"DCHA. NAV. Y ESP.","denominacion11":"DERECHA NAVARRA Y ESPAÑOLA","colorgr11":"p0000"}}');

      print(partidosNo15Si11["partido1"]);

      var encoded33 = LATIN1.encode(nueva);

      new File('./DAU01999CM_L1.htm').writeAsBytes(encoded33).then((File file) {
        // Do something with the file.
        print('HTML generado a las $horaescru');
      });
    });
  });
}
