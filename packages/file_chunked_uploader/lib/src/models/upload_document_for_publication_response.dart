import 'package:json_schema/json_schema.dart';

class UploadDocumentForPublicationResponse {
  List<String> errors;

  UploadDocumentForPublicationResponse({
    this.errors = const []
  });

  ///Json schema for validation
  dynamic get schemaData =>  {
    "title":"File uploader response",
    "description":"This schema is for validating response",
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


  UploadDocumentForPublicationResponse fromJson(dynamic data,{String? token}){
    try{
      final results = Validator(JsonSchema.create(schemaData)).validate(data, reportMultipleErrors: true);
      if(results.isValid == false) {
        return UploadDocumentForPublicationResponse(errors: results.errors.map((elm)=>elm.message).toList());
      }else{
        return UploadDocumentForPublicationResponse(
            errors: data["errors"]!= null || data["error"]!= null ? data["errors"].map<String>((elm)=>elm.toString()).toList() ?? [data["error"]] :[],
        );
      }
    }catch(err){
      return UploadDocumentForPublicationResponse(errors: ["Something went wrong. Please try again later or contact support."]);
    }
  }


}