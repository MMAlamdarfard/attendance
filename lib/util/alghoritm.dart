
import 'dart:convert';


import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' ;
class Algorithm {
  
  String encryptData() {
   
      Map<String, String> data76 = {
        'iv': '24422dfef68c94509acb896fc3c1c3ba',
        'key': '4a0eddffa41811fc449e75d955fb9aa3f53ea89948ee4fa4beb8821a959eec6d',
        'Data': 'SALAM'
      };
      Uint8List iv = hexStringToBytes(data76['iv']??"");
      Uint8List key = hexStringToBytes(data76['key']??"");
      Uint8List data = utf8.encode(data76['Data']??"");

      final encrypter = Encrypter(AES(Key(key), mode: AESMode.cbc));
      final encrypted = encrypter.encryptBytes(data, iv: IV(iv));

      return base64.encode(encrypted.bytes);
  }

  String decryptData() {
      Map<String, String> data76 = {
        'iv': '24422dfef68c94509acb896fc3c1c3ba',
        'key': '4a0eddffa41811fc449e75d955fb9aa3f53ea89948ee4fa4beb8821a959eec6d',
        'Data': 'nAW6E2RUjbC5bMRfjixLpg=='
      };
      Uint8List iv = hexStringToBytes(data76['iv']??"");
      Uint8List key = hexStringToBytes(data76['key']??"");
      Uint8List encryptedData = base64Decode(data76['Data']??"");

      final encrypter = Encrypter(AES(Key(key), mode: AESMode.cbc));
      final decrypted = encrypter.decrypt(Encrypted(encryptedData), iv: IV(iv));

      return decrypted; // Output: SALAM
  }

  Uint8List hexStringToBytes(String hexString) {
    List<int> bytes = [];
    for (int i = 0; i < hexString.length; i += 2) {
      bytes.add(int.parse(hexString.substring(i, i + 2), radix: 16));
    }
    return Uint8List.fromList(bytes);
  }

  String encryptWithRAZalghorithm(String data){
    String char = SecureRandom(1).base16;  
    List<int> indexList = char.codeUnits;
    int sum=0;
    for (var index in indexList) {
      sum += index;
    }
    String encode = data;
    for (int i = 0; i < ((sum%3)+1); i++) {
      String encodedB64 = base64.encode(utf8.encode(encode));
      String reverse = encodedB64.split('').reversed.join();
      encode = reverse;
    }
    return encode+char;
  }
  
  String decryptWithRAZalghorithm(String data){
      int length = data.length;
      String lastTwoCharacters = data.substring(length - 2);
      List<int> indexList = lastTwoCharacters.codeUnits;
      int sum=0;
      for (var index in indexList) {
        sum += index;
      }
      String encryptedData=data.substring(0,length-2);
      String encode = encryptedData;
      for (int i = 0; i < ((sum%3)+1); i++) {
        String finalReverse = encode.split('').reversed.join('');
        List<int> decodedBytes = base64Decode(finalReverse);
        encode = utf8.decode(decodedBytes);
      }
      return encode;
      
  }

}
