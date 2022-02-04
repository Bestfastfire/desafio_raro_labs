extension Str on String {
  String get jpg => 'assets/images/$this.jpg';
  String get png => 'assets/images/$this.png';
  String get svg => 'assets/images/$this.svg';

  String get ucFirst {
    if (length > 1) {
      return substring(0, 1).toUpperCase() + substring(1);
    }

    return toUpperCase();
  }

  String searchMode() => toLowerCase()
      .replaceAll('á', 'a')
      .replaceAll('é', 'e')
      .replaceAll('í', 'i')
      .replaceAll('ó', 'o')
      .replaceAll('ú', 'u')
      .replaceAll('à', 'a')
      .replaceAll('è', 'e')
      .replaceAll('ì', 'i')
      .replaceAll('ò', 'o')
      .replaceAll('ù', 'u')
      .replaceAll('â', 'a')
      .replaceAll('ê', 'e')
      .replaceAll('î', 'i')
      .replaceAll('ô', 'o')
      .replaceAll('û', 'u')
      .replaceAll('ã', 'a')
      .replaceAll('õ', 'o')
      .replaceAll('ç', 'c')
      .replaceAll(RegExp(r'[\W]'), '');

  int get asInt => int.tryParse(toString()) ?? 0;

  double get asDouble => (double.tryParse(toString()) ?? 0).toDouble();

  String getMaskared(String mask, [k = 0, String maskared = '']){
    int cat = 0;
    int sum = 0;

    for(int i = 0; i < mask.length; i++){
      try{
        if(mask[i].toString() == '#'){
          if(length+sum >= i) {
            maskared += this[i-sum];

          }

          if(i-cat+1 < mask.length && mask[i-cat+1] != '#'){
            if(i+1 > length-1+sum) {
              break;

            }

            maskared += mask[i+1];
            sum++;
            i++;
          }
        }

        if(i > length-1+sum) {
          break;

        }

      }catch(msg){
        cat++;

      }
    }

    return maskared;
  }
}
