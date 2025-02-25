/// https://javiercbk.github.io/json_to_dart/
class Country {
  Name? name;
  List<String>? tld;
  String? cca2;
  String? ccn3;
  String? cca3;
  String? cioc;
  bool? independent;
  String? status;
  bool? unMember;
  Currencies? currencies;
  Idd? idd;
  List<String>? capital;
  List<String>? altSpellings;
  String? region;
  String? subregion;
  Languages? languages;
  Translations? translations;
  List<double>? latlng;
  bool? landlocked;

  Country({
    this.name,
    this.tld,
    this.cca2,
    this.ccn3,
    this.cca3,
    this.cioc,
    this.independent,
    this.status,
    this.unMember,
    this.currencies,
    this.idd,
    this.capital,
    this.altSpellings,
    this.region,
    this.subregion,
    this.languages,
    this.translations,
    this.latlng,
    this.landlocked,
  });

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    tld = json['tld'].cast<String>();
    cca2 = json['cca2'];
    ccn3 = json['ccn3'];
    cca3 = json['cca3'];
    cioc = json['cioc'];
    independent = json['independent'];
    status = json['status'];
    unMember = json['unMember'];
    currencies = json['currencies'] != null
        ? Currencies.fromJson(json['currencies'])
        : null;
    idd = json['idd'] != null ? Idd.fromJson(json['idd']) : null;
    capital = json['capital'].cast<String>();
    altSpellings = json['altSpellings'].cast<String>();
    region = json['region'];
    subregion = json['subregion'];
    languages = json['languages'] != null
        ? Languages.fromJson(json['languages'])
        : null;
    translations = json['translations'] != null
        ? Translations.fromJson(json['translations'])
        : null;
    latlng = json['latlng'].cast<double>();
    landlocked = json['landlocked'];
  }

  static List<Country> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((json) => Country.fromJson(json)).toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['tld'] = tld;
    data['cca2'] = cca2;
    data['ccn3'] = ccn3;
    data['cca3'] = cca3;
    data['cioc'] = cioc;
    data['independent'] = independent;
    data['status'] = status;
    data['unMember'] = unMember;
    if (currencies != null) {
      data['currencies'] = currencies!.toJson();
    }
    if (idd != null) {
      data['idd'] = idd!.toJson();
    }
    data['capital'] = capital;
    data['altSpellings'] = altSpellings;
    data['region'] = region;
    data['subregion'] = subregion;
    if (languages != null) {
      data['languages'] = languages!.toJson();
    }
    if (translations != null) {
      data['translations'] = translations!.toJson();
    }
    data['latlng'] = latlng;
    data['landlocked'] = landlocked;
    return data;
  }
}

class Name {
  String? common;
  String? official;
  NativeName? nativeName;

  Name({this.common, this.official, this.nativeName});

  Name.fromJson(Map<String, dynamic> json) {
    common = json['common'];
    official = json['official'];
    nativeName = json['nativeName'] != null
        ? NativeName.fromJson(json['nativeName'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['common'] = common;
    data['official'] = official;
    if (nativeName != null) {
      data['nativeName'] = nativeName!.toJson();
    }
    return data;
  }
}

class NativeName {
  Eng? eng;
  Eng? hin;
  Eng? tam;

  NativeName({this.eng, this.hin, this.tam});

  NativeName.fromJson(Map<String, dynamic> json) {
    eng = json['eng'] != null ? Eng.fromJson(json['eng']) : null;
    hin = json['hin'] != null ? Eng.fromJson(json['hin']) : null;
    tam = json['tam'] != null ? Eng.fromJson(json['tam']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eng != null) {
      data['eng'] = eng!.toJson();
    }
    if (hin != null) {
      data['hin'] = hin!.toJson();
    }
    if (tam != null) {
      data['tam'] = tam!.toJson();
    }
    return data;
  }
}

class Eng {
  String? official;
  String? common;

  Eng({this.official, this.common});

  Eng.fromJson(Map<String, dynamic> json) {
    official = json['official'];
    common = json['common'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['official'] = official;
    data['common'] = common;
    return data;
  }
}

class Currencies {
  INR? iNR;

  Currencies({this.iNR});

  Currencies.fromJson(Map<String, dynamic> json) {
    iNR = json['INR'] != null ? INR.fromJson(json['INR']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (iNR != null) {
      data['INR'] = iNR!.toJson();
    }
    return data;
  }
}

class INR {
  String? name;
  String? symbol;

  INR({this.name, this.symbol});

  INR.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['symbol'] = symbol;
    return data;
  }
}

class Idd {
  String? root;
  List<String>? suffixes;

  Idd({this.root, this.suffixes});

  Idd.fromJson(Map<String, dynamic> json) {
    root = json['root'];
    suffixes = json['suffixes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['root'] = root;
    data['suffixes'] = suffixes;
    return data;
  }
}

class Languages {
  String? eng;
  String? hin;
  String? tam;

  Languages({this.eng, this.hin, this.tam});

  Languages.fromJson(Map<String, dynamic> json) {
    eng = json['eng'];
    hin = json['hin'];
    tam = json['tam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eng'] = eng;
    data['hin'] = hin;
    data['tam'] = tam;
    return data;
  }
}

class Translations {
  Eng? ara;
  Eng? bre;
  Eng? ces;
  Eng? cym;
  Eng? deu;
  Eng? est;
  Eng? fin;
  Eng? fra;
  Eng? hrv;
  Eng? hun;
  Eng? ita;
  Eng? jpn;
  Eng? kor;
  Eng? nld;
  Eng? per;
  Eng? pol;
  Eng? por;
  Eng? rus;
  Eng? slk;
  Eng? spa;
  Eng? srp;
  Eng? swe;
  Eng? tur;
  Eng? urd;
  Eng? zho;

  Translations(
      {this.ara,
      this.bre,
      this.ces,
      this.cym,
      this.deu,
      this.est,
      this.fin,
      this.fra,
      this.hrv,
      this.hun,
      this.ita,
      this.jpn,
      this.kor,
      this.nld,
      this.per,
      this.pol,
      this.por,
      this.rus,
      this.slk,
      this.spa,
      this.srp,
      this.swe,
      this.tur,
      this.urd,
      this.zho});

  Translations.fromJson(Map<String, dynamic> json) {
    ara = json['ara'] != null ? Eng.fromJson(json['ara']) : null;
    bre = json['bre'] != null ? Eng.fromJson(json['bre']) : null;
    ces = json['ces'] != null ? Eng.fromJson(json['ces']) : null;
    cym = json['cym'] != null ? Eng.fromJson(json['cym']) : null;
    deu = json['deu'] != null ? Eng.fromJson(json['deu']) : null;
    est = json['est'] != null ? Eng.fromJson(json['est']) : null;
    fin = json['fin'] != null ? Eng.fromJson(json['fin']) : null;
    fra = json['fra'] != null ? Eng.fromJson(json['fra']) : null;
    hrv = json['hrv'] != null ? Eng.fromJson(json['hrv']) : null;
    hun = json['hun'] != null ? Eng.fromJson(json['hun']) : null;
    ita = json['ita'] != null ? Eng.fromJson(json['ita']) : null;
    jpn = json['jpn'] != null ? Eng.fromJson(json['jpn']) : null;
    kor = json['kor'] != null ? Eng.fromJson(json['kor']) : null;
    nld = json['nld'] != null ? Eng.fromJson(json['nld']) : null;
    per = json['per'] != null ? Eng.fromJson(json['per']) : null;
    pol = json['pol'] != null ? Eng.fromJson(json['pol']) : null;
    por = json['por'] != null ? Eng.fromJson(json['por']) : null;
    rus = json['rus'] != null ? Eng.fromJson(json['rus']) : null;
    slk = json['slk'] != null ? Eng.fromJson(json['slk']) : null;
    spa = json['spa'] != null ? Eng.fromJson(json['spa']) : null;
    srp = json['srp'] != null ? Eng.fromJson(json['srp']) : null;
    swe = json['swe'] != null ? Eng.fromJson(json['swe']) : null;
    tur = json['tur'] != null ? Eng.fromJson(json['tur']) : null;
    urd = json['urd'] != null ? Eng.fromJson(json['urd']) : null;
    zho = json['zho'] != null ? Eng.fromJson(json['zho']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ara != null) {
      data['ara'] = ara!.toJson();
    }
    if (bre != null) {
      data['bre'] = bre!.toJson();
    }
    if (ces != null) {
      data['ces'] = ces!.toJson();
    }
    if (cym != null) {
      data['cym'] = cym!.toJson();
    }
    if (deu != null) {
      data['deu'] = deu!.toJson();
    }
    if (est != null) {
      data['est'] = est!.toJson();
    }
    if (fin != null) {
      data['fin'] = fin!.toJson();
    }
    if (fra != null) {
      data['fra'] = fra!.toJson();
    }
    if (hrv != null) {
      data['hrv'] = hrv!.toJson();
    }
    if (hun != null) {
      data['hun'] = hun!.toJson();
    }
    if (ita != null) {
      data['ita'] = ita!.toJson();
    }
    if (jpn != null) {
      data['jpn'] = jpn!.toJson();
    }
    if (kor != null) {
      data['kor'] = kor!.toJson();
    }
    if (nld != null) {
      data['nld'] = nld!.toJson();
    }
    if (per != null) {
      data['per'] = per!.toJson();
    }
    if (pol != null) {
      data['pol'] = pol!.toJson();
    }
    if (por != null) {
      data['por'] = por!.toJson();
    }
    if (rus != null) {
      data['rus'] = rus!.toJson();
    }
    if (slk != null) {
      data['slk'] = slk!.toJson();
    }
    if (spa != null) {
      data['spa'] = spa!.toJson();
    }
    if (srp != null) {
      data['srp'] = srp!.toJson();
    }
    if (swe != null) {
      data['swe'] = swe!.toJson();
    }
    if (tur != null) {
      data['tur'] = tur!.toJson();
    }
    if (urd != null) {
      data['urd'] = urd!.toJson();
    }
    if (zho != null) {
      data['zho'] = zho!.toJson();
    }
    return data;
  }
}

class Demonyms {
  Eng? eng;
  Eng? fra;

  Demonyms({this.eng, this.fra});

  Demonyms.fromJson(Map<String, dynamic> json) {
    eng = json['eng'] != null ? Eng.fromJson(json['eng']) : null;
    fra = json['fra'] != null ? Eng.fromJson(json['fra']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eng != null) {
      data['eng'] = eng!.toJson();
    }
    if (fra != null) {
      data['fra'] = fra!.toJson();
    }
    return data;
  }
}

class Maps {
  String? googleMaps;
  String? openStreetMaps;

  Maps({this.googleMaps, this.openStreetMaps});

  Maps.fromJson(Map<String, dynamic> json) {
    googleMaps = json['googleMaps'];
    openStreetMaps = json['openStreetMaps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['googleMaps'] = googleMaps;
    data['openStreetMaps'] = openStreetMaps;
    return data;
  }
}

class Gini {
  double? d2011;

  Gini({this.d2011});

  Gini.fromJson(Map<String, dynamic> json) {
    d2011 = json['2011'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['2011'] = d2011;
    return data;
  }
}

class Car {
  List<String>? signs;
  String? side;

  Car({this.signs, this.side});

  Car.fromJson(Map<String, dynamic> json) {
    signs = json['signs'].cast<String>();
    side = json['side'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['signs'] = signs;
    data['side'] = side;
    return data;
  }
}

class Flags {
  String? png;
  String? svg;
  String? alt;

  Flags({this.png, this.svg, this.alt});

  Flags.fromJson(Map<String, dynamic> json) {
    png = json['png'];
    svg = json['svg'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['png'] = png;
    data['svg'] = svg;
    data['alt'] = alt;
    return data;
  }
}

class CoatOfArms {
  String? png;
  String? svg;

  CoatOfArms({this.png, this.svg});

  CoatOfArms.fromJson(Map<String, dynamic> json) {
    png = json['png'];
    svg = json['svg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['png'] = png;
    data['svg'] = svg;
    return data;
  }
}

class CapitalInfo {
  List<double>? latlng;

  CapitalInfo({this.latlng});

  CapitalInfo.fromJson(Map<String, dynamic> json) {
    latlng = json['latlng'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latlng'] = latlng;
    return data;
  }
}

class PostalCode {
  String? format;
  String? regex;

  PostalCode({this.format, this.regex});

  PostalCode.fromJson(Map<String, dynamic> json) {
    format = json['format'];
    regex = json['regex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['format'] = format;
    data['regex'] = regex;
    return data;
  }
}
