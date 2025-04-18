import 'upload_document_warning.dart';
import 'package:json_schema/json_schema.dart';
import "document_format.dart";
import "upload_response.dart";
class UploadDocumentResponse implements UploadResponse{
  int? publicationId;
  int? documentId;
  List<DocumentFormat> pictureFormats;
  List<DocumentFormat> videoFormats;
  UploadDocumentWarning? warning;
  List<String> errors;

  UploadDocumentResponse({
    this.documentId,
    this.publicationId,
    this.pictureFormats = const [],
    this.videoFormats = const [],
    this.errors = const [],
    this.warning
  });

  ///Json schema for validation
  dynamic get schemaData =>  {
      "title":"File uploader response",
      "description":"This schema is for validating response",
      "type":"object",
      "properties":{
        "id":{
          "type":["number","string"],
          "description":"Unique id for document (uploaded file)"
        },
        "publication_id":{
          "type":["number","string"],
          "description":"Unique id for publication"
        },
        "data":{
          "type":"object",
          "properties":{
            "picture":{
              "type":"array",
              "minItems":4,
              "items":{
                "type":"object",
                "required":["type","url"],
                "properties":{
                  "type":{
                    "type":"string",
                    "enum": ["original", "small", "medium", "thumb"]
                  },
                  "url":{
                    "type":"string",
                    "format": "uri"
                  }
                }
              }
            },
            "video":{
              "type":"object",
              "required":["url"],
              "properties":{
                "url":{
                  "type":"string",
                  "format":"uri"
                }
              }
            }
          }
        },
        "warnings":{
          "type":"object",
          "required":["is_rotation_required","networks","real_ratio","height","width"],
          "properties":{
            "is_rotation_required":{
                "type":"boolean"
            },
            "networks":{
                "type":"array",
                "items":{
                  "type":"object",
                  "required":["engine","id","name","is_resized_required","is_undersized","is_ratio_undersized","ratio"],
                  "properties":{
                    "engine":{
                      "type":"string",
                      "enum":["Facebook","Instagram","Linkedin"]
                    },
                    "name":{
                      "type":"string"
                    },
                    "id":{
                      "type":["number","string"]
                    },
                    "is_resized_required":{
                      "type":"boolean"
                    },
                    "is_undersized":{
                      "type":"boolean"
                    },
                    "is_ratio_undersized":{
                      "type":"boolean"
                    },
                    "ratio":{
                      "type":["string","null"]
                    },
                    "messages":{
                      "type":"array",
                      "minItems":1,
                      "items":{
                        "type":"string"
                      }
                    }
                  }
                }
            },
            "real_ratio":{
                "type":"number"
            },
            "height":{
                "type":"number"
            },
            "width":{
                "type":"number"
            },
            "messages":{
              "type":"array",
              "minItems":1,
              "items":{
                "type":"string"
              }
            }
          }
        },
        "error":{
          "description":"Error happen when document upload failed",
          "type":"string",
        },
        "errors":{
          "description":"List of Errors happen when document upload failed",
          "type":"array",
          "items":{
            "type":"string"
          },
          "minItems": 1
        }
      },
      "oneOf": [
        {
          "required": ["id", "publication_id","data"],
          "not": {
            "anyOf": [
              { "required": ["error"] },
              { "required": ["errors"] }
            ]
          }
        },
        {
          "oneOf": [
            { "required": ["error"] },
            { "required": ["errors"] }
          ],
          "not": {
            "anyOf": [
              { "required": ["id"] },
              { "required": ["publication_id"] },
              { "required": ["data"] }
            ]
          }
        }
      ],
  };

  @override
  UploadDocumentResponse fromJson(dynamic data,{String? token}){
    try{
      final results = Validator(JsonSchema.create(schemaData)).validate(data, reportMultipleErrors: true);
      if(results.isValid == false) {
        return UploadDocumentResponse(errors: results.errors.map((elm)=>elm.message).toList());
      }else{
        return UploadDocumentResponse(
          documentId: data["id"],
          publicationId: data["publication_id"],
          pictureFormats: data["data"]?["picture"]?.map<DocumentFormat>((elm)=>DocumentFormat.fromJson(elm,token)).toList() ?? [],
          videoFormats: data["data"]?["video"]?.map<DocumentFormat>((elm)=>DocumentFormat.fromJson(elm,token)).toList() ?? [],
          errors: data["errors"]!= null || data["error"]!= null ? data["errors"].map<String>((elm)=>elm.toString()).toList() ?? [data["error"]] :[],
          warning: UploadDocumentWarning.fromJson(data["warnings"])
        );
      }
    }catch(err){
      return UploadDocumentResponse(errors: ["Something went wrong. Please try again later or contact support."]);
    }
  }


  bool isWarningExist(){
    return warning?.isExist() ?? false;
  }

  bool isNetworksValid(){
    return warning?.isNetworksValid() ?? false;
  }

  bool isFileUploadedSuccessfully(){
    return pictureFormats.isNotEmpty || videoFormats.isNotEmpty;
  }

  UploadDocumentWarning? getWarning(){
    return warning;
  }

}