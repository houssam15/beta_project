import 'package:json_schema/json_schema.dart';

abstract class ValidationBase{
  Map<String,dynamic> get schema;

  ValidationResults? _validationResults;

  JsonSchema get _jsonSchema => JsonSchema.create(schema);

  Validator get _validator => Validator(_jsonSchema);

  ValidationBase validate(dynamic data){
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