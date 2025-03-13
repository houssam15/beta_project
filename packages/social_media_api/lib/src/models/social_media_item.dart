import "models.dart";
import 'package:json_schema/json_schema.dart';

class SocialMediaItem{
  SocialMediaItem({
    this.id,
    this.icon,
    this.title,
    this.uploadUrl,
    this.error
  });

  final int? id;
  final String? icon;
  final String? title;
  final String? uploadUrl;
  final SocialMediaItemError? error;

  final schemaData = {
    "title":"Social media item",
    "description":"This schema is for validating social media item response",
    "type":"object",
    "properties":{
      "id":{
        "type":"integer",
        "minimum":0,
        "description":"Unique id for social media item"
      },
      "icon":{
        "type":"string",
        "description":"Font awesome icon"
      },
      "title":{
        "type":"string",
        "description":"Title of social media item"
      },
      "uploadUrl":{
        "type":["string", "null"],
        "format": "uri",
      },
      "error":{
        "description":"Error happen when previous uploaded file not respect social media item constraints",
        "type":"object",
        "properties":{
          "errorType":{
            "type":"string",
            "enum": ["INVALID_DIMENSIONS","OTHER_ERROR_TYPES"],
            "description":"Unique error identifier",
          },
          "messages":{
            "description":"Array of messages to describe error to user",
            "type":"array",
            "items":{
              "type":"string"
            },
            "minItems": 1
          },
          "validConstraints":{
            "description":"When user upload an invalid picture dimension , user should resize his picture with those constraints",
            "type":["object","null"],
            "required":["minWidth","maxWidth","minHeight","maxHeight"],
            "properties":{
              "minWidth":{
                "type":"number",
                "minimum":1
              },
              "maxWidth":{
                "type":"number",
                "minimum":1
              },
              "minHeight":{
                "type":"number",
                "minimum":1
              },
              "maxHeight":{
                "type":"number",
                "minimum":1
              },
            }
          }
        },
        "if": {
          "properties": { "errorType": { "const": "INVALID_DIMENSIONS" } }
        },
        "then": {
          "properties": { "validConstraints": { "type": "object" } },
          "required": ["validConstraints"]
        },
        "else":{
          "properties": { "validConstraints": { "type": "null" } },
        },
        "required":["errorType","messages"],
      },
    },
    "if":{
      "required":["error"]
    },
    "then":{
      "properties": {
        "uploadUrl": {
          "type": "null",
          "description": "uploadUrl must be null when error is present."
        }
      }
    },
    "else": {
      "properties": {
        "uploadUrl": {
          "type": "string",
          "format": "uri",
          "description": "uploadUrl must be a valid URI when error is absent."
        }
      },
      "required":["uploadUrl"]
    },
    "required": ["id", "icon", "title"]
  };

  JsonSchema? _jsonSchema;

  JsonSchema get jsonSchema => _jsonSchema ?? JsonSchema.create(schemaData);

  List<SocialMediaItem> fromList(dynamic data){
    List<SocialMediaItem> items = [];
    for(dynamic elm in data as List){
      final validator = Validator(jsonSchema);
      final results = validator.validate(elm, reportMultipleErrors: true);
      try{
        if(results.isValid) items.add(fromJson(elm));
      }catch(err){
        throw ArgumentError("SocialMediaItem : Validation don't work properly !");
      }
    }
    return items;
  }

  static SocialMediaItem fromJson(dynamic data){
    return SocialMediaItem(
        id: data["id"],
        icon: data["icon"],
        title: data["title"],
        uploadUrl: data["uploadUrl"],
        error: SocialMediaItemError.fromJson(data["error"])
    );
  }

}
