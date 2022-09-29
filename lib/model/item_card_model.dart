import 'package:flutter/material.dart';

class ItemCardModel {
  String? name;
  String? img;
  List<Articles>? articles;

  ItemCardModel({
    this.name,
    this.img,
    this.articles,
  });
}

class Articles {
  String? name1;
  Color? color;
  String? img1;
  List<Details>? details;

  Articles({
    this.name1,
    this.color,
    this.img1,
    this.details,
  });
}

class Details {
  String? details3;
  String? details4;
  String? details5;
  String? details6;

  Details({
    this.details3,
    this.details4,
    this.details5,
    this.details6,
  });
}

List<ItemCardModel> itemCardList = <ItemCardModel>[
  ItemCardModel(
    name: "Medicine 01",
    img: "assets/images/img.png",
    articles: <Articles>[
      Articles(
          name1: "Mind",
          color: Colors.black,
          img1: "assets/images/mind.png",
          details: <Details>[
            Details(
              details3: "Depression",
            )
          ]),
      Articles(
          name1: "Head",
          color: Colors.black,
          img1: "assets/images/head.png",
          details: <Details>[
            Details(
              details3: "Creaking Noise",
              details4: "Ulcers",
            )
          ]),
      Articles(
        name1: "Eyes",
        color: Colors.black,
        img1: "assets/images/eye.png",
        details: <Details>[
          Details(details3: "Conjunctivitis", details4: "Cataract")
        ],
      ),
      Articles(
        name1: "Ears",
        color: Colors.black,
        img1: "assets/images/ear.png",
        details: <Details>[
          Details(
              details3: "Deafness ", details4: "Ringing", details5: "Roaring")
        ],
      ),
      Articles(
        name1: "Nose",
        color: Colors.white,
        img1: "assets/images/nose.png",
        details: <Details>[
          Details(
            details3: "Cold in the head",
          )
        ],
      ),
      Articles(
        name1: "Face",
        img1: "assets/images/face.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Hard Swelling",
          )
        ],
      ),
      Articles(
        name1: "Mouth",
        img1: "assets/images/mouth.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Gum-Boil",
            details4: "Cataract",
          )
        ],
      ),
    ],
  ),
  ItemCardModel(
    name: "Medicine 02",
    img: "assets/images/img.png",
    articles: <Articles>[
      Articles(
          name1: "Mind",
          img1: "assets/images/mind.png",
          color: Colors.black,
          details: <Details>[
            Details(
              details3: "Peevish",
              details4: "Forgetful",
            )
          ]),
      Articles(
        name1: "Head",
        img1: "assets/images/head.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Headache",
          )
        ],
      ),
      Articles(
        name1: "Eyes",
        img1: "assets/images/eye.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Diffused opacity in Cornea",
          )
        ],
      ),
      Articles(
        name1: "Mouth",
        img1: "assets/images/mouth.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Swollen TOnsils",
          )
        ],
      ),
      Articles(
        name1: "Abdomen",
        img1: "assets/images/img.png",
        color: Colors.black,
        details: <Details>[
          Details(
            details3: "Skunken",
            details4: "Flabby",
          )
        ],
      ),
      Articles(
        name1: "Urine",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Increased",
          )
        ],
      ),
    ],
  ),
  ItemCardModel(
    name: "Medicine 03",
    img: "assets/images/img.png",
    articles: <Articles>[
      Articles(
          name1: "Head",
          img1: "assets/images/head.png",
          color: Colors.white,
          details: <Details>[
            Details(
              details3: "Purulent Crusts",
            )
          ]),
      Articles(
        name1: "Eyes",
        img1: "assets/images/eye.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Inflammation of the eyes",
          )
        ],
      ),
      Articles(
        name1: "Ears",
        img1: "assets/images/ear.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Deafness",
          )
        ],
      ),
      Articles(
        name1: "Nose",
        img1: "assets/images/nose.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Cold in Head",
          )
        ],
      ),
      Articles(
        name1: "Mind",
        img1: "assets/images/nose.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Cold in Head",
          )
        ],
      ),
      Articles(
        name1: "Mouth",
        img1: "assets/images/mouth.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Inside of lips sore",
          )
        ],
      ),
      Articles(
        name1: "Skin",
        img1: "assets/images/skin.png",
        color: Colors.black,
        details: <Details>[
          Details(
            details3: "Cuts",
            details4: "Wounds",
            details5: "Bruises",
          )
        ],
      ),
      Articles(
        name1: "Face",
        img1: "assets/images/face.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Pimples",
          )
        ],
      ),
      Articles(
        name1: "Abdomen",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Pain in region of Liver",
          )
        ],
      ),
      Articles(
        name1: "Fever",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Hectic Fever",
          )
        ],
      ),
    ],
  ),
  ItemCardModel(
    name: "Medicine 04",
    img: "assets/images/img.png",
    articles: <Articles>[
      Articles(
          name1: "Head",
          img1: "assets/images/head.png",
          color: Colors.black,
          details: <Details>[
            Details(
              details3: "Headache",
              details4: "Vomiting",
            )
          ]),
      Articles(
        name1: "Ears",
        img1: "assets/images/ear.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Snapping",
            details4: "Noises in Ear",
          )
        ],
      ),
      Articles(
        name1: "Eyes",
        img1: "assets/images/eye.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "White Mucus",
          )
        ],
      ),
      Articles(
        name1: "Nose",
        img1: "assets/images/nose.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Catarrh",
          )
        ],
      ),
      Articles(
        name1: "Face",
        img1: "assets/images/face.png",
        color: Colors.black,
        details: <Details>[
          Details(
            details3: "Cheek Swollen",
            details4: "Painful",
          )
        ],
      ),
    ],
  ),
  ItemCardModel(
    name: "Medicine 05",
    img: "assets/images/img.png",
    articles: <Articles>[
      Articles(
          name1: "Mind",
          img1: "assets/images/img.png",
          color: Colors.black,
          details: <Details>[
            Details(
              details3: "Creaking Noise",
              details4: "null",
            )
          ]),
      Articles(
        name1: "Head",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Conjunctivitis",
            details4: "Cataract",
          )
        ],
      ),
      Articles(
        name1: "Eyes",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Conjunctivitis",
            details4: "Cataract",
          )
        ],
      ),
      Articles(
        name1: "Mouth",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Conjunctivitis",
            details4: "Cataract",
          )
        ],
      ),
      Articles(
        name1: "Abdomen",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Conjunctivitis",
            details4: "Cataract",
          )
        ],
      ),
      Articles(
        name1: "Urine",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Conjunctivitis",
            details4: "Cataract",
          )
        ],
      ),
    ],
  ),
  ItemCardModel(
    name: "Medicine 06",
    img: "assets/images/img.png",
    articles: <Articles>[
      Articles(
          name1: "Head",
          img1: "assets/images/head.png",
          color: Colors.white,
          details: <Details>[
            Details(
              details3: "Purulent Crusts",
            )
          ]),
      Articles(
        name1: "Eyes",
        img1: "assets/images/eye.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Inflammation of the eyes",
          )
        ],
      ),
      Articles(
        name1: "Ears",
        img1: "assets/images/ear.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Deafness",
          )
        ],
      ),
      Articles(
        name1: "Nose",
        img1: "assets/images/nose.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Cold in Head",
          )
        ],
      ),
      Articles(
        name1: "Mouth",
        img1: "assets/images/mouth.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Inside of lips sore",
          )
        ],
      ),
      Articles(
        name1: "Skin",
        img1: "assets/images/skin.png",
        color: Colors.black,
        details: <Details>[
          Details(
            details3: "Cuts",
            details4: "Wounds",
            details5: "Bruises",
          )
        ],
      ),
      Articles(
        name1: "Face",
        img1: "assets/images/face.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Pimples",
          )
        ],
      ),
      Articles(
        name1: "Abdomen",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Pain in region of Liver",
          )
        ],
      ),
      Articles(
        name1: "Fever",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Hectic Fever",
          )
        ],
      ),
    ],
  ),
  ItemCardModel(
    name: "Medicine 07",
    img: "assets/images/img.png",
    articles: <Articles>[
      Articles(
          name1: "Head",
          img1: "assets/images/head.png",
          color: Colors.white,
          details: <Details>[
            Details(
              details3: "Purulent Crusts",
            )
          ]),
      Articles(
        name1: "Eyes",
        img1: "assets/images/eye.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Inflammation of the eyes",
          )
        ],
      ),
      Articles(
        name1: "Ears",
        img1: "assets/images/ear.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Deafness",
          )
        ],
      ),
      Articles(
        name1: "Nose",
        img1: "assets/images/nose.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Cold in Head",
          )
        ],
      ),
      Articles(
        name1: "Mouth",
        img1: "assets/images/mouth.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Inside of lips sore",
          )
        ],
      ),
      Articles(
        name1: "Skin",
        img1: "assets/images/skin.png",
        color: Colors.black,
        details: <Details>[
          Details(
            details3: "Cuts",
            details4: "Wounds",
            details5: "Bruises",
          )
        ],
      ),
      Articles(
        name1: "Face",
        img1: "assets/images/face.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Pimples",
          )
        ],
      ),
      Articles(
        name1: "Abdomen",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Pain in region of Liver",
          )
        ],
      ),
      Articles(
        name1: "Fever",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Hectic Fever",
          )
        ],
      ),
    ],
  ),
  ItemCardModel(
    name: "Medicine 08",
    img: "assets/images/img.png",
    articles: <Articles>[
      Articles(
          name1: "Head",
          img1: "assets/images/head.png",
          color: Colors.white,
          details: <Details>[
            Details(
              details3: "Purulent Crusts",
            )
          ]),
      Articles(
        name1: "Eyes",
        img1: "assets/images/eye.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Inflammation of the eyes",
          )
        ],
      ),
      Articles(
        name1: "Ears",
        img1: "assets/images/ear.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Deafness",
          )
        ],
      ),
      Articles(
        name1: "Nose",
        img1: "assets/images/nose.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Cold in Head",
          )
        ],
      ),
      Articles(
        name1: "Mouth",
        img1: "assets/images/mouth.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Inside of lips sore",
          )
        ],
      ),
      Articles(
        name1: "Skin",
        img1: "assets/images/skin.png",
        color: Colors.black,
        details: <Details>[
          Details(
            details3: "Cuts",
            details4: "Wounds",
            details5: "Bruises",
          )
        ],
      ),
      Articles(
        name1: "Face",
        img1: "assets/images/face.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Pimples",
          )
        ],
      ),
      Articles(
        name1: "Abdomen",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Pain in region of Liver",
          )
        ],
      ),
      Articles(
        name1: "Fever",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Hectic Fever",
          )
        ],
      ),
    ],
  ),
  ItemCardModel(
    name: "Medicine 09",
    img: "assets/images/img.png",
    articles: <Articles>[
      Articles(
          name1: "Head",
          img1: "assets/images/head.png",
          color: Colors.white,
          details: <Details>[
            Details(
              details3: "Purulent Crusts",
            )
          ]),
      Articles(
        name1: "Eyes",
        img1: "assets/images/eye.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Inflammation of the eyes",
          )
        ],
      ),
      Articles(
        name1: "Ears",
        img1: "assets/images/ear.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Deafness",
          )
        ],
      ),
      Articles(
        name1: "Nose",
        img1: "assets/images/nose.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Cold in Head",
          )
        ],
      ),
      Articles(
        name1: "Mouth",
        img1: "assets/images/mouth.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Inside of lips sore",
          )
        ],
      ),
      Articles(
        name1: "Skin",
        img1: "assets/images/skin.png",
        color: Colors.black,
        details: <Details>[
          Details(
            details3: "Cuts",
            details4: "Wounds",
            details5: "Bruises",
          )
        ],
      ),
      Articles(
        name1: "Face",
        img1: "assets/images/face.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Pimples",
          )
        ],
      ),
      Articles(
        name1: "Abdomen",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Pain in region of Liver",
          )
        ],
      ),
      Articles(
        name1: "Fever",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Hectic Fever",
          )
        ],
      ),
    ],
  ),
  ItemCardModel(
    name: "Medicine 10",
    img: "assets/images/img.png",
    articles: <Articles>[
      Articles(
          name1: "Head",
          img1: "assets/images/head.png",
          color: Colors.white,
          details: <Details>[
            Details(
              details3: "Purulent Crusts",
            )
          ]),
      Articles(
        name1: "Eyes",
        img1: "assets/images/eye.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Inflammation of the eyes",
          )
        ],
      ),
      Articles(
        name1: "Ears",
        img1: "assets/images/ear.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Deafness",
          )
        ],
      ),
      Articles(
        name1: "Nose",
        img1: "assets/images/nose.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Cold in Head",
          )
        ],
      ),
      Articles(
        name1: "Mouth",
        img1: "assets/images/mouth.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Inside of lips sore",
          )
        ],
      ),
      Articles(
        name1: "Skin",
        img1: "assets/images/skin.png",
        color: Colors.black,
        details: <Details>[
          Details(
            details3: "Cuts",
            details4: "Wounds",
            details5: "Bruises",
          )
        ],
      ),
      Articles(
        name1: "Face",
        img1: "assets/images/face.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Pimples",
          )
        ],
      ),
      Articles(
        name1: "Abdomen",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Pain in region of Liver",
          )
        ],
      ),
      Articles(
        name1: "Fever",
        img1: "assets/images/img.png",
        color: Colors.white,
        details: <Details>[
          Details(
            details3: "Hectic Fever",
          )
        ],
      ),
    ],
  ),

  // ItemCardModel(name: "कैलकेरिया फ्लोर", img: "assets/images/img.png"),
  // ItemCardModel(name: "कैलकेरिया फॉस", img: "assets/images/img.png"),
  // ItemCardModel(name: "कैलकेरिया सल्फ़", img: "assets/images/img.png"),
  // ItemCardModel(name: "काली मूर", img: "assets/images/img.png"),
  // ItemCardModel(name: "काली फॉस", img: "assets/images/img.png"),
  // ItemCardModel(name: "काली सल्फ़", img: "assets/images/img.png"),
  // ItemCardModel(name: "नेट्रम मूर", img: "assets/images/img.png"),
  // ItemCardModel(name: "नेट्रम फॉस", img: "assets/images/img.png"),
  // ItemCardModel(name: "नेट्रम सल्फ़", img: "assets/images/img.png"),
  // ItemCardModel(name: "फेरम फोस", img: "assets/images/img.png"),
  // ItemCardModel(name: "मैग्नीशिया फोस", img: "assets/images/img.png"),
  // ItemCardModel(name: "सिलिसिया", img: "assets/images/img.png"),
];
