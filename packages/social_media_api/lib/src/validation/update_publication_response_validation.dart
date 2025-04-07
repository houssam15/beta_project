import "validation_base.dart";

class UpdatePublicationResponseValidation extends ValidationBase{
  @override
  Map<String, dynamic> get schema => {
    "title":"update publication",
    "description":"update publication created in previous step of file uploading",
    "type":"object",
    "properties":{
      "error":{
        "description":"Error happen when update publication",
        "type":"string",
      },
      "errors":{
        "description":"List of Errors happen when update publication",
        "type":"object"
      }
    },
    "allOf": [
      {
        "not": {
          "required": ["error", "errors"]
        }
      }
    ]
  };

}