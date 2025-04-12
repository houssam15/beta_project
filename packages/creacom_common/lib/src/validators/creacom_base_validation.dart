import 'package:common/common.dart';

abstract class CreacomBaseValidation extends ValidationBase{

    Map<String,dynamic> get errorsSchema => {
      "type":"object"
    };


    Map<String,dynamic> get errorSchema => {
      "type":"string"
    };

    Map<String,dynamic> get statusSchema => {
      "type":"string"
    };

    Map<String,dynamic> get totalOfItemsSchema => {
      "type":"integer"
    };

    Map<String,dynamic> get numberOfItemsSchema => {
      "type":"integer"
    };

    Map<String,dynamic> get numberOfPageSchema => {
      "type":"integer"
    };

    List<Map<String,dynamic>> get commonListRequirementForAllOf => [
      {
        "if": {
          "required": ["items"]
        },
        "then": {
          "required": ["number_of_items","number_of_pages","total_of_items"]
        }
      },
      {
        "not": {
          "required": ["error", "errors"]
        }
      }
    ];

    String get datePattern => r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01]) (0[0-9]|1[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$';

}