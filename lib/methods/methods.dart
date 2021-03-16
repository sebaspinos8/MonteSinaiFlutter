class Methods {
  Methods();

  String formatoFecha(String fecha) {
    List<String> auxf = fecha.split('/');
    return auxf[0] + "/" + auxf[1] + "/" + auxf[2];
  }

  String formatoFechaDMA(String fecha) {
    List<String> auxf = fecha.split('/');
    return auxf[2] + "/" + auxf[1] + "/" + auxf[0];
  }

  String funcionEdad(String aux) {
    if (aux.toString() != "null") {
      String fecha = aux.substring(0, 10).replaceAll('-', '/');
      List<String> fechaaux = fecha.split('/');
      DateTime currentDate = DateTime.now();
      int age = currentDate.year - int.parse(fechaaux[0]);
      int month1 = currentDate.month;
      int month2 = int.parse(fechaaux[1]);
      if (month2 > month1) {
        age--;
      } else if (month1 == month2) {
        int day1 = currentDate.day;
        int day2 = int.parse(fechaaux[2]);
        if (day2 > day1) {
          age--;
        }
      }
      return age.toString();
    } else {
      return '0';
    }
  }
}
