import "package:creacom_common/creacom_common.dart";

class GetQrcodeListValidator extends CreacomBaseValidation{

  @override
  Map<String, dynamic> get schema => {
    "title":schemaTitle,
    "description":schemaDescription,
    "type":"object",
    "properties":{
      "status":statusSchema,
      "error":errorSchema,
      "errors":errorsSchema,
      "total_of_items":totalOfItemsSchema,
      "number_of_items":numberOfPageSchema,
      "number_of_pages":numberOfPageSchema,
      "items":itemsSchema
    },
    "allOf": [
      ...commonListRequirementForAllOf,
    ]
  };

  String get schemaTitle => "Qrcode list validation";

  String get schemaDescription => "Qrcode list validation";

  Map<String,dynamic> get itemsSchema =>{
    "type":"object",
    "required":["id","link","created_at","picture","pdf"],
    "properties":{
      "id":{
        "type":"string"
      },
      "link":{
        "type":"string",
        "format":"uri"
      },
      "created_at":{
        "type":"string",
        "pattern": datePattern
      },
      "picture":pictureSchema,
      "pdf":pdfSchema
    }
  };

  Map<String,dynamic> get pdfSchema => {
    "type":"object",
    "required":["url"],
    "properties":{
      "url":{
        "type":"string",
        "format":"uri"
      }
    }
  };

  Map<String,dynamic> get pictureSchema => {
    "type":"object",
    "required":["url"],
    "properties":{
      "url":{
        "type":"string",
        "format":"uri"
      }
    }
  };

}