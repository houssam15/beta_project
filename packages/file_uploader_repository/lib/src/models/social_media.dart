import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class SocialMedia extends Equatable{
  String? name;
  final String? engine;
  final IconData icon;
  final Color color;

  SocialMedia({
    this.name,
    this.engine,
    required this.icon,
    required this.color
  });

  SocialMedia setName(String? name){
    this.name = name;
    return this;
  }

  String getName(){
    return name ?? "";
  }

  IconData getIcon(){
    return icon;
  }

  Color getColor(){
    return color;
  }

  bool isNameExist(){
    return name != null;
  }

 static List<SocialMedia> get socials =>[
   SocialMedia(engine: "facebook", icon: FontAwesomeIcons.facebook, color: Colors.blue),
   SocialMedia(engine: "instagram", icon: FontAwesomeIcons.instagram, color: Colors.pink),
   SocialMedia(engine: "linkedin", icon: FontAwesomeIcons.linkedin, color: Colors.lightBlueAccent)
 ];

 static SocialMedia get defaultItem => SocialMedia(icon: FontAwesomeIcons.circleInfo, color: Colors.black);

 static SocialMedia getItem([String? engine]){
   return socials.firstWhere((elm)=>elm.engine == engine,orElse: () => defaultItem);
 }
 
 @override
  List<Object?> get props => [engine,icon,color];

}