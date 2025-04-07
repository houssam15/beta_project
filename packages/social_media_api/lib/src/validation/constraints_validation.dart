import 'package:json_schema/json_schema.dart';

class ConstraintsValidation {
  get _schema  => {
    "title":"Constraints",
    "description":"validate constraints for supported files",
    "type":"object",
    "properties":{
      "networks":{
        "type":"array",
        "minItems": 1,
        "items":{
          "type":"object",
          "required":["id","name","engine","properties"],
          "properties":{
            "id":{
              "type":["string", "number"]
            },
            "name":{
              "type":"string"
            },
            "engine":{
              "type":"string"
            },
            "properties":{
              "type": "object",
              "required":["picture","video"],
              "properties":{
                "picture":{
                  "type":"object",
                  "required":["formats","min_size","max_size","properties"],
                  "properties":{
                    "formats":{
                      "type":"array",
                      "minItems": 1,
                      "items":{
                        "type":"string"
                      }
                    },
                    "min_size":{
                      "type":"number"
                    },
                    "max_size":{
                      "type":"number"
                    },
                    "properties":{
                      "type":"array",
                      "minItems":1,
                      "items":{
                        "type":"object",
                        "required":["width_min","width_max","height_min","height_max","ratio"],
                        "properties":{
                          "width_min":{
                            "type":"number"
                          },
                          "width_max":{
                            "type":"number"
                          },
                          "height_min":{
                            "type":"number"
                          },
                          "height_max":{
                            "type":"number"
                          },
                          "ratio":{
                            "type":"string"
                          }
                        }
                      }
                    }
                  }
                },
                "video":{
                  "type":"object",
                  "required":["formats","properties","duration_min","duration_max","max_rate"],
                  "properties":{
                    "formats":{
                      "type" : "array",
                      "items":{
                        "type":"string"
                      }
                    },
                    "properties":{
                      "width_min":{
                        "type":"number"
                      },
                      "width_max":{
                        "type":"number"
                      },
                      "height_min":{
                        "type":"number"
                      },
                      "height_max":{
                        "type":"number"
                      },
                      "ratio":{
                        "type":"string"
                      }
                    },
                    "duration_min":{
                      "type":"number"
                    },
                    "duration_max":{
                      "type":"number"
                    },
                    "max_rate":{
                      "type":"number"
                    }
                  }
                }
              }
            },
          }
        },
      },
      "constraints":{
        "type": "object",
        "required":["picture","video"],
        "properties":{
          "picture":{
            "type":"object",
            "required":["formats","min_size","max_size","properties"],
            "properties":{
              "formats":{
                "type":"array",
                "minItems": 1,
                "items":{
                  "type":"string"
                }
              },
              "min_size":{
                "type":"number"
              },
              "max_size":{
                "type":"number"
              },
              "properties":{
                "type":"array",
                "minItems":1,
                "items":{
                  "type":"object",
                  "required":["width_min","width_max","height_min","height_max","ratio"],
                  "properties":{
                    "width_min":{
                      "type":"number"
                    },
                    "width_max":{
                      "type":"number"
                    },
                    "height_min":{
                      "type":"number"
                    },
                    "height_max":{
                      "type":"number"
                    },
                    "ratio":{
                      "type":"string"
                    }
                  }
                }
              }
          },
          "video":{
            "type":"object",
            //"required":["formats","ratios","duration_min","duration_max","max_rate"],
            "properties":{
              "formats":{
                "type" : "array",
                "items":{
                  "type":"string"
                }
              },
              "properties":{
                "type":"array",
                "minItems":1,
                "items":{
                  "type":"object",
                  "required":["width_min","width_max","height_min","height_max","properties"],
                  "properties":{
                    "width_min":{
                      "type":"number"
                    },
                    "width_max":{
                      "type":"number"
                    },
                    "height_min":{
                      "type":"number"
                    },
                    "height_max":{
                      "type":"number"
                    },
                    "ratio":{
                      "type":"string"
                    }
                  }
                }
              },
              "duration_min":{
                "type":"number"
              },
              "duration_max":{
                "type":"number"
              },
              "max_rate":{
                "type":"number"
              }
            }
          }
        },
          "video":{
            "type":"object",
            //"required":["formats","ratios","duration_min","duration_max","max_rate"],
            "properties":{
              "formats":{
                "type" : "array",
                "items":{
                  "type":"string"
                }
              },
              "ratios":{
                "type" : "array",
                "minItems": 1,
                "items":{
                  "type":"string"
                }
              },
              "duration_min":{
                "type":"number"
              },
              "duration_max":{
                "type":"number"
              },
              "max_rate":{
                "type":"number"
              }
            }
          }
        },
      "error":{
        "type":"string"
      },
      "errors":{
        "type":"array",
        "minItems":1,
        "items":{
          "type":"string"
        }
      },
    }
    },
     "oneOf": [
       {
         "required": ["networks", "constraints"],
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
             { "required": ["networks"] },
             { "required": ["constraints"] },
           ]
         }
       },
       {
         "not": {
           "anyOf": [
             { "required": ["networks"] },
             { "required": ["constraints"] },
             { "required": ["error"] },
             { "required": ["errors"] }
           ]
         },
         "errorMessage": "At least one of the fields 'networks', 'constraints', 'error', or 'errors' must be provided."
       }
     ],
  };

  ValidationResults? _validationResults;

  JsonSchema get _jsonSchema => JsonSchema.create(_schema);

  Validator get _validator => Validator(_jsonSchema);

  ConstraintsValidation validate(dynamic data){
    _validationResults =  _validator.validate(data,reportMultipleErrors: true);
    return this;
  }

  bool isValid(){
    return _validationResults != null && _validationResults!.isValid;
  }

  List<String> getErrors() {
    return _validationResults != null ? _validationResults!.errors.map((elm) => elm.message).toList():[];
  }

}