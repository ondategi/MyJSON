import '../lib/ResultadoEleccciones.dart';

import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';

List distritosSustituirHTML = [
  '_class_dlk_ext_TITLE',
  '_class_lk_DENOMINACION',
  '_class_dlk_ext_TITLE',
  '_class_lk_DENOMINACION',
  '_frmenu_posibleScrollbar_TITLE',
  '_frmenu_posibleScrollbar_NAME',
  '_frmenu_posibleScrollbar_DENOMINACION'
];

List partidosSustituirHTML = [
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

String datosComunes(String plantillaHTM, {int distrito}) {

  // poner en el fichero la hora actual
  var now = new DateTime.now();
  var formatter = new DateFormat('HH:mm');
  String horaescru = formatter.format(now);

  String plantilla = plantillaHTM.replaceAll('HORAESCRU', horaescru);

  // sustituir resto de campos literales
  plantilla = plantilla.replaceAll('>TITLE_PAGINA<',
      'Elecciones al Ayuntamiento de Tudela - Resultados provisionales, no oficialess');
  plantilla = plantilla.replaceAll('class_logo_elec_ALT',
      'Elecciones al Ayuntamiento de Tudela - Resultados provisionales, no oficialess');
  plantilla =
      plantilla.replaceAll('class_logo_com_ALT', 'Ayuntamiento de Tudela');

  plantilla =
      plantilla.replaceAll('MUNICIPIO_class_ext_act_TITLE', 'Municipio');
  plantilla =
      plantilla.replaceAll('MUNICIPIO_class_act_DENOMINACION', 'Municipio');

  plantilla = plantilla.replaceAll(
      'DISTRITOS_class_ext_claseActCircunscripciones_TITLE', 'Distritos');
  plantilla = plantilla.replaceAll(
      'DISTRITOS_class_claseActCircunscripciones_DENOMINACION', 'Distritos');
  plantilla =
      plantilla.replaceAll('DISTRITOS_class_titulista_DIV', 'Distritos');

  plantilla =
      plantilla.replaceAll('RESUMEN_class_resum_DENOMINACION', 'Resumen');
  plantilla = plantilla.replaceAll(
      'CANDIDATURAS_ext_dlk_claseActCandidaturasTITLE', 'Candidaturas');
  plantilla = plantilla.replaceAll(
      'CANDIDATURAS_lk_claseActCandidaturasHOVER', 'Candidaturas');
  plantilla = plantilla.replaceAll(
      'CANDIDATURAS_linkcand_claseActCandidaturasDENOMINACION', 'Candidaturas');
  plantilla = plantilla.replaceAll(
      'CANDIDATURAS_frmenu_posibleScrollbar_TITLE', 'Enlaces a candidaturas');
  plantilla = plantilla.replaceAll(
      'CANDIDATURAS_frmenu_posibleScrollbar_NAME', 'enlaces a candidaturas');
  plantilla = plantilla.replaceAll(
      'CANDIDATURAS_frmenu_posibleScrollbar_DENOMINACION',
      'Enlace a la lista de candidaturas');

  return (plantilla);
}

void procesarResultadosDAU01999CM_L1(ResultadoEleccciones resultado) {
  new File('./plantillaDAU01999CM_L1.txt')
      .readAsString(encoding: Encoding.getByName('ISO_8859-1'))
      .then((String contents) {

    // sustitución de valores en la pantalla de MUNICIPIO DAU01999CM_L1

    String plantillaDAU01999CM_L1;

    // campos para dar formato como String y poner '' si valores CERO
    String colorgr15;
    String colorgr11;
    String votos15;
    String conce15;
    String conce11;
    String votos11;
    String porcen15;
    String porcen11;

    int d = 0;
    resultado.distritos.forEach((distrito) {
      d++;

      plantillaDAU01999CM_L1 = datosComunes(contents, d);

      String distritoquetoca = 'SECCIONES_MESAS_DISTRITO' + '$d';

      plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
          distritoquetoca + distritosSustituirHTML[0],
          'Distrito ' + distrito.distrito.toString());
      plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
          distritoquetoca + distritosSustituirHTML[1],
          'Distrito ' + distrito.distrito.toString());
      plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
          distritoquetoca + distritosSustituirHTML[2], "Secciones : Mesas");
      plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
          distritoquetoca + distritosSustituirHTML[3], "Secciones : Mesas");
      plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
          distritoquetoca + distritosSustituirHTML[4],
          "Enlaces a Secciones : Mesas del Distrito " +
              distrito.distrito.toString());
      plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
          distritoquetoca + distritosSustituirHTML[5],
          "enlaces a Secciones : Mesas del Distrito " +
              distrito.distrito.toString());
      plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
          distritoquetoca + distritosSustituirHTML[6],
          "Enlace a la lista de Secciones : Mesas del Distrito " +
              distrito.distrito.toString());

      distrito.secciones.forEach((seccion) {
        seccion.mesas.forEach((mesa) {
          List tempParti11 =
              mesa.partidos.where((a) => a.denominacion15 == '').toList();
          List tempParti15 =
              mesa.partidos.where((a) => a.denominacion15 != '').toList();
          // ordenar los partidos de mas a menos votos
          tempParti15.sort((a, b) => b.votos15.compareTo(a.votos15));

          tempParti15.addAll(tempParti11);

          // para etiquetar PARTIDOn
          int p = 0;
          // por cada PARTIDO
          tempParti15.forEach((partido) {
            // montar cadena de PARTIDO
            p++;
            String partidoquetoca = 'PARTIDO' + '$p';

            // acumulamos votantes
            //     votantes15 = votantes15 + partido.votos15;
            //    votantes11 = votantes11 + partido.votos11;

            // primero manejar color
            // si  saca concejales, se activa el color, si no saca se desactiva
            partido.conce15 == 0
                ? colorgr15 = partido.colorgr15
                : colorgr15 = partido.colorgr15 +
                    '" style="border-top-style: solid;" title="Color ' +
                    partido.siglas15;

            // si  sacó concejales anteriormente, se activa el color, si no sacó se desactiva
            partido.conce11 == 0
                ? colorgr11 = partido.colorgr11
                : colorgr11 = partido.colorgr11 +
                    '" style="border-top-style: solid;" title="Color ' +
                    partido.siglas11;

            votos15 =
                new NumberFormat("#,###", "es_ES").format(partido.votos15);
            votos11 =
                new NumberFormat("#,###", "es_ES").format(partido.votos11);
            conce15 =
                new NumberFormat("#,###", "es_ES").format(partido.conce15);
            conce11 =
                new NumberFormat("#,###", "es_ES").format(partido.conce11);
            porcen15 = new NumberFormat("#0.00%", "es_ES").format(
                partido.votos15 /
                    resultado.distritos[0].secciones[0].mesas[0].validos15);
            porcen11 = new NumberFormat("#0.00%", "es_ES").format(
                partido.votos11 /
                    resultado.distritos[0].secciones[0].mesas[0].validos11);

            plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
                partidoquetoca + partidosSustituirHTML[0], colorgr15);
            plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
                partidoquetoca + partidosSustituirHTML[1],
                partido.denominacion15);
            plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
                partidoquetoca + partidosSustituirHTML[2], partido.siglas15);
            plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
                partidoquetoca + partidosSustituirHTML[3],
                votos15 == '0' ? votos15 = '' : votos15);
            plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
                partidoquetoca + partidosSustituirHTML[4],
                porcen15 == '0,00%' ? porcen15 = '' : porcen15);
            plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
                partidoquetoca + partidosSustituirHTML[5],
                conce15 == '0' ? conce15 = '' : conce15);
            plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
                partidoquetoca + partidosSustituirHTML[6],
                conce11 == '0' ? conce11 = '' : conce11);
            plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
                partidoquetoca + partidosSustituirHTML[7],
                votos11 == '0' ? votos11 = '' : votos11);
            plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
                partidoquetoca + partidosSustituirHTML[8],
                porcen11 == '0,00%' ? porcen11 = '' : porcen11);
            plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
                partidoquetoca + partidosSustituirHTML[9],
                partido.denominacion11);
            plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
                partidoquetoca + partidosSustituirHTML[10], partido.siglas11);
            plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
                partidoquetoca + partidosSustituirHTML[11], colorgr11);
          });
        });
      });
    });

    print(resultado.ParaImprimir15);
    print(resultado.ParaImprimir11);

    // informar porcentaje escrutado
    plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll('PORCEESCRU',
        new NumberFormat("#0.00%", "es_ES")
            .format(resultado.escrutado15 / resultado.electores15));
    /// informar acumulados de blancos, nulos, y abstenciones
    plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
        'TOTALVOTANTES15',
        new NumberFormat("#,###", "es_ES").format(resultado.validos15));
    plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
        'PORCENPARTICIPACION15', new NumberFormat("#0.00%", "es_ES").format(
            (resultado.validos15 + resultado.nulos15) / resultado.electores15));
    plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
        'PORCENPARTICIPACION11', new NumberFormat("#0.00%", "es_ES").format(
            (resultado.validos11 + resultado.nulos11) / resultado.electores11));
    plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
        'TOTALABSTENCION15', new NumberFormat("#,###", "es_ES").format(
            resultado.electores15 - resultado.validos15 - resultado.nulos15));
    plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
        'PORCENABSTENCION15', new NumberFormat("#0.00%", "es_ES").format(
            (resultado.electores15 - resultado.validos15 - resultado.nulos15) /
                resultado.electores15));
    plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
        'PORCENABSTENCION11', new NumberFormat("#0.00%", "es_ES").format(
            (resultado.electores11 - resultado.validos11 - resultado.nulos11) /
                resultado.electores11));
    plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll('TOTALNULOS15',
        new NumberFormat("#,###", "es_ES").format(resultado.nulos15));
    plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll('PORCENNULOS15',
        new NumberFormat("#0.00%", "es_ES").format(
            resultado.nulos15 / (resultado.validos15 + resultado.nulos15)));
    plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll('PORCENNULOS11',
        new NumberFormat("#0.00%", "es_ES").format(
            resultado.nulos11 / (resultado.validos11 + resultado.nulos11)));
    plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll('TOTALBLANCOS15',
        new NumberFormat("#,###", "es_ES").format(resultado.blancos15));
    plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
        'PORCENBLANCOS15', new NumberFormat("#0.00%", "es_ES")
            .format(resultado.blancos15 / resultado.validos15));
    plantillaDAU01999CM_L1 = plantillaDAU01999CM_L1.replaceAll(
        'PORCENBLANCOS11', new NumberFormat("#0.00%", "es_ES")
            .format(resultado.blancos11 / resultado.validos11));

    /// codificar en ISO-8859-1
    var encoded33 = LATIN1.encode(plantillaDAU01999CM_L1);

    new File('./DAU01999CM_L1.htm').writeAsBytes(encoded33).then((File file) {
      // Do something with the file.

      var now = new DateTime.now();
      var formatter = new DateFormat('HH:mm');
      String horaescru = formatter.format(now);

      print('HTML guardado a las $horaescru');
    });
  });

  new File('./plantillaAU01L_L1.txt')
      .readAsString(encoding: Encoding.getByName('ISO_8859-1'))
      .then((plantilla) {

    /// codificar en ISO-8859-1
    var encoded33 = LATIN1.encode(datosComunes(plantilla));

    new File('./IAU01L_L1.htm').writeAsBytes(encoded33).then((File file) {
      // Do something with the file.
      print('HTML guardado a las $DateTime.now()');
    });
  });

  new File('./plantillaIAU01P_L1.txt')
      .readAsString(encoding: Encoding.getByName('ISO_8859-1'))
      .then((plantilla) {

    /// codificar en ISO-8859-1
    var encoded33 = LATIN1.encode(datosComunes(plantilla));

    new File('./IAU01P_L1.htm').writeAsBytes(encoded33).then((File file) {
      // Do something with the file.
      print('HTML guardado a las $DateTime.now()');
    });
  });

  new File('./plantillaDAU01000CI_L1.txt')
      .readAsString(encoding: Encoding.getByName('ISO_8859-1'))
      .then((plantilla) {

    /// codificar en ISO-8859-1
    var encoded33 = LATIN1.encode(datosComunes(plantilla));

    new File('./DAU01000CI_L1.htm').writeAsBytes(encoded33).then((File file) {
      // Do something with the file.
      print('HTML guardado a las $DateTime.now()');
    });
  });
}
