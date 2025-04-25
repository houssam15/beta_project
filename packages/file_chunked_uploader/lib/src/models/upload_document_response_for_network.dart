import 'upload_document_network.dart';
import 'package:json_schema/json_schema.dart';
import "document_format.dart";
import "upload_response.dart";
class UploadDocumentResponseForNetwork implements UploadResponse{
  int? id;
  List<DocumentFormat> pictureFormats;
  List<DocumentFormat> videoFormats;
  UploadDocumentNetwork? violations;
  List<String> errors;

  UploadDocumentResponseForNetwork({
    this.id,
    this.pictureFormats = const [],
    this.videoFormats = const [],
    this.errors = const [],
    this.violations
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
      "violations":{
        "type":"object",
        "required":["id","engine","is_rotation_required","is_undersized","is_resized_required","ratio","real_ratio","height","width"/*,"messages"*/],
        "properties":{
          "id":{
            "type":"string"
          },
          "engine":{
            "type":"string",
            "enum":["Facebook","Instagram","Linkedin","Google"]
          },
          "is_rotation_required":{
            "type":"boolean"
          },
          "is_undersized":{
            "type":"boolean"
          },
          "is_resized_required":{
            "type":"boolean"
          },
          "ratio":{
            "type":["string","null"]
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
        "type":"object"
      }
    },
    "oneOf": [
      {
        "required": ["id","data"],
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
            { "required": ["data"] }
          ]
        }
      }
    ],
  };

  @override
  UploadDocumentResponseForNetwork fromJson(dynamic data,{String? token}){
    try{
      final results = Validator(JsonSchema.create(schemaData)).validate(data, reportMultipleErrors: true);
      if(results.isValid == false) {
        return UploadDocumentResponseForNetwork(errors: results.errors.map((elm)=>elm.message).toList());
      }else{
        return UploadDocumentResponseForNetwork(
            id: data["id"],
            pictureFormats: data["data"]?["picture"]?.map<DocumentFormat>((elm)=>DocumentFormat.fromJson(elm,token)).toList() ?? [],
            videoFormats: data["data"]?["video"]?.map<DocumentFormat>((elm)=>DocumentFormat.fromJson(elm,token)).toList() ?? [],
            errors: data["errors"]!= null || data["error"]!= null ? data["errors"].map<String>((elm)=>elm.toString()).toList() ?? [data["error"]] :[],
            violations: UploadDocumentNetwork.fromJson(data["violations"])
        );
      }
    }catch(err){
      return UploadDocumentResponseForNetwork(errors: ["Something went wrong. Please try again later or contact support."]);
    }
  }

  bool isValid(){
    return errors.isEmpty && !isViolationsExist();
  }

  bool isViolationsExist(){
    return violations?.isExist() ?? false;
  }

  List<String> getMessages(){
    return [
      ...errors,
      if(isViolationsExist()) ...violations!.messages
    ];
  }

  @override
  List<String> getErrors(){
    return errors;
  }

  @override
  void addErrors(List<String> errors) {
    this.errors = [...this.errors,...errors];
  }

}