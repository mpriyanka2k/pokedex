import 'dart:math';
import 'dart:typed_data';
import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class EncryptionService {
  // -------------------------------------------------------------
  //                 AUTO-GENERATED AES KEY & IV
  // -------------------------------------------------------------
  late Key aesKey;  // 32 bytes for AES-256
  late IV iv;       // 16 bytes

  late Encrypter _aesEncrypter;

  // -------------------------------------------------------------
  //                          RSA
  // -------------------------------------------------------------
  final String? publicKeyPem;
  final String? privateKeyPem;

  late Encrypter? _rsaEncrypterPublic;
  late Encrypter? _rsaEncrypterPrivate;

  EncryptionService({
    this.publicKeyPem,
    this.privateKeyPem,
  }) {

    // Generate AES key & IV dynamically per request/session
    aesKey = _generateAESKey();
    iv = _generateIV();

    print("aesKey =$aesKey");
    print("iv =$iv");

    _aesEncrypter = Encrypter(AES(aesKey, mode: AESMode.cbc));
    print("_aesEncrypter = $_aesEncrypter");

    // Initialize RSA
    if (publicKeyPem != null) {
      final publicKey = RSAKeyParser().parse(publicKeyPem!) as RSAPublicKey;
      _rsaEncrypterPublic = Encrypter(RSA(publicKey: publicKey));
    }

    if (privateKeyPem != null) {
      final privateKey =
          RSAKeyParser().parse(privateKeyPem!) as RSAPrivateKey;
      _rsaEncrypterPrivate = Encrypter(RSA(privateKey: privateKey));
    }
  }

  // -------------------------------------------------------------
  //         AES Key Generation (Per Request / Per Session)
  // -------------------------------------------------------------
  Key _generateAESKey() {
    final secureRandom = Random.secure();
    final keyBytes = List<int>.generate(32, (_) => secureRandom.nextInt(256));
    return Key(Uint8List.fromList(keyBytes));
  }

  IV _generateIV() {
    final secureRandom = Random.secure();
    final ivBytes = List<int>.generate(16, (_) => secureRandom.nextInt(256));
    return IV(Uint8List.fromList(ivBytes));
  }



  // -------------------------------------------------------------
  //                     AES Encryption
  // -------------------------------------------------------------
  // String encryptAES(String plainText) {
  String encryptAES(Map<String, dynamic> json) {
    final jsonString = jsonEncode(json);
    // final encrypted = _aesEncrypter.encrypt(plainText, iv: iv);
    final encrypted = _aesEncrypter.encrypt(jsonString, iv: iv);
    return encrypted.base64;
  }

  String decryptAES(String encryptedBase64) {
    return _aesEncrypter.decrypt64(encryptedBase64, iv: iv);

  }

  // -------------------------------------------------------------
  //                     RSA Encryption
  // -------------------------------------------------------------
  String encryptRSA(String plainText) {
    if (_rsaEncrypterPublic == null) {
      throw Exception("Public key not provided!");
    }
    return _rsaEncrypterPublic!.encrypt(plainText).base64;
  }

  String decryptRSA(String encryptedBase64) {
    if (_rsaEncrypterPrivate == null) {
      throw Exception("Private key not provided!");
    }
    return _rsaEncrypterPrivate!.decrypt64(encryptedBase64);
  }

  // -------------------------------------------------------------
  //               HYBRID ENCRYPTION (JSON Payload)
  // -------------------------------------------------------------
  // Map<String, dynamic> encryptJsonPayload(Map<String, dynamic> json) {
  //   final jsonString = jsonEncode(json);

  //   // Encrypt the data with AES
  //   final encryptedData = encryptAES(jsonString);

  //   // Encrypt AES key + IV with RSA
  //   final encryptedKey = encryptRSA(base64Encode(aesKey.bytes));
  //   final encryptedIv = encryptRSA(base64Encode(iv.bytes));

  //   return {
  //     "data": encryptedData,
  //     "key": encryptedKey,
  //     "iv": encryptedIv,
  //   };

  // }
}
