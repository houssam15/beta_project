import "package:common/common.dart";
class SocialMediaPublicationValidation extends ValidationBase{

  Map<String,dynamic> get fileSchema => {
    "type":"object",
    "properties":{
      "picture":{
        "type":"array",
        "minItems":1,
        "items":{
          "type":"object",
          "required":["type","url"],
          "properties":{
            "type":{
              "type":"string",
              "enum":["original","small","medium","thumb"]
            },
            "url":{
              "type":"string",
              "format":"uri"
            }
          }
        }
      }
    }
  };

  Map<String,dynamic> get accountSchema => {
    "type":"object",
    "required":["id","name","page","engine"],
    "properties":{
      "id": {
        "type": "string"
      },
      "name":{
        "type":"string"
      },
      "page":{
        "type":"string"
      },
      "engine":{
        "type":"string",
        "enum":["Facebook","Instagram","Linkedin","Google"]
      }
    }
  };

  Map<String,dynamic> get documentSchema => {
    "type":"object",
    "required":["id","height","width","extension","size","duration","file"],
    "properties":{
      "id":{
        "type":"string"
      },
      "height":{
        "type":"number"
      },
      "width":{
        "type":"number"
      },
      "extension":{
        "type":"string"
      },
      "size":{
        "type":"number"
      },
      "duration":{
        "type":"number"
      },
      "file":fileSchema,
      "is_valid":{
        "type":"boolean"
      },
      "account":accountSchema
    }
  };

  Map<String,dynamic> get errorsSchema => {
    "type":"object"
  };

  Map<String,dynamic> get errorSchema => {
    "type":"string"
  };

  String get datePattern => r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01]) (0[0-9]|1[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$';


  @override
  Map<String, dynamic> get schema => {
    "title":"Social media publication validation",
    "description":"Social media publication validation",
    "type":"object",
    "properties":{
      "status":{
        "type":"string"
      },
      "items":{
        "type":"array",
        "items":{
          "type":"object",
          "required":["id","dated_at","created_at","title","description","state","status","document","documents"],
          "properties":{
            "id":{
              "type":"string"
            },
            "dated_at":{
              "type":["string","null"],
              "pattern": datePattern
            },
            "created_at":{
              "type":"string",
              "pattern": datePattern
            },
            "title":{
              "type":"string"
            },
            "description":{
              "type":"string"
            },
            "state":{
              "type":"string"
            },
            "status":{
              "type":"string"
            },
            "document":documentSchema,
            "documents":{
              "type":"array",
              "items":documentSchema
            }
          }
        }
      },
      "error":errorSchema,
      "errors":errorsSchema
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