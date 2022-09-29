import 'package:flutter/material.dart';

class DiseasesModel {
  String? name;
  String? details1;
  String? details2;
  Color? color;
  String? img;

  DiseasesModel(
      {this.name, this.details1, this.details2, this.color, this.img});
}

List<DiseasesModel> diseasesCardList1 = <DiseasesModel>[
  DiseasesModel(
      name: "Mind", details1: "Depression", details2: "", color: Colors.white),
  DiseasesModel(
      name: "Head",
      details1: "Creaking noise",
      details2: "Ulcers ",
      color: Colors.black,
      img: "assets/images/logoImgng"),
  DiseasesModel(
      name: "Eyes",
      details1: "conjunctivitis",
      details2: "cataract",
      color: Colors.black,
      img: "assets/images/img.png"),
  DiseasesModel(
      name: "Ears",
      details1: "deafness",
      details2: "ringing and roaring",
      color: Colors.black,
      img: "assets/images/img.png"),
  DiseasesModel(
      name: "Nose",
      details1: "Cold in the head",
      details2: "",
      color: Colors.white,
      img: "assets/images/img.png"),
  DiseasesModel(
      name: "Face",
      details1: "Hard swelling",
      details2: "",
      color: Colors.white),
  DiseasesModel(
      name: "Mouth", details1: "Gum-boil", details2: "", color: Colors.white),
];

List<DiseasesModel> diseasesCardList2 = <DiseasesModel>[
  DiseasesModel(
      name: "Mind",
      details1: "Peevish",
      details2: "forgetful",
      color: Colors.black),
  DiseasesModel(
      name: "Head", details1: "Headache", details2: "", color: Colors.white),
  DiseasesModel(
      name: "Eyes",
      details1: "Diffused opacity in cornea ",
      details2: "",
      color: Colors.white),
  DiseasesModel(
      name: "Mouth",
      details1: "Swollen tonsils",
      details2: "",
      color: Colors.white),
  DiseasesModel(
      name: "Abdomen",
      details1: "Sunken and flabby",
      details2: "",
      color: Colors.white),
  DiseasesModel(
      name: "Urine", details1: "Increased", details2: "", color: Colors.white),
];
