part of "params.dart";
abstract class FeatureParams<T>{
  T create([dynamic params]);
  bool isValid();
}