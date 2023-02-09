void main(){
  String  t= '1asdas';

  bool teste = t.startsWith(RegExp(r'[A-Z][a-z]'));
  print(teste); 
  const string = 'Dart is open source';
print(string.startsWith('Dar')); // true
print(string.startsWith(RegExp(r'[A-Z][a-z]'))); // t
}