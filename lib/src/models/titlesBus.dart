class TitleBus {
  String image;
  String title;
  String description;
  List<Zone> zones;

  TitleBus({this.title, this.image, this.description, this.zones});
}

class Zone{
  String zone;
  String price;

  Zone({this.zone, this.price});
}

List<TitleBus> titlesBus = <TitleBus>[
  TitleBus(
    title: "T-Casual (10 viatges)",
    image: "assets/titlesBus/T_casual.jpg",
    description: "T-casual: Títol unipersonal i horari, de 10 viatges integrats en tots els modes de transport segons les zones per les quals es transiti (pagament màxim 6 zones).\n\nNo és vàlid a les estacions de metro d'Aeroport T1 i Aeroport T2 de la línia L9 Sud.",
    zones: [
      Zone(
        zone: "1 zona",
        price: "11.35"    
      ),
      Zone(
        zone: "2 zones",
        price: "22.40"    
      ),
      Zone(
        zone: "3 zones",
        price: "30.50"    
      ),
      Zone(
        zone: "4 zones",
        price: "39.20"    
      ),
      Zone(
        zone: "5 zones",
        price: "45.05"    
      ),
      Zone(
        zone: "6 zones",
        price: "47.90"    
      ),
    ]
  ),
  //----------------------------------------------------------------------
  TitleBus(
    title: "T-Usual (viatges il·limitats en 30 dies)",
    image: "assets/titlesBus/T_usual.jpg",
    description: "Títol personal i intransferible, amb un nombre il·limitat de viatges integrats en 30 dies consecutius, a les zones delimitades per la primera validació, en tots els modes de transport segons les zones per les quals es transiti (pagament màxim 6 zones).\n\nHa d’anar acompanyat d’un document oficial acreditatiu i en vigor del seu titular.",
    zones: [
      Zone(
        zone: "1 zona",
        price: "40.00"    
      ),
      Zone(
        zone: "2 zones",
        price: "53.85"    
      ),
      Zone(
        zone: "3 zones",
        price: "75.60"    
      ),
      Zone(
        zone: "4 zones",
        price: "92.55"    
      ),
      Zone(
        zone: "5 zones",
        price: "106.20"    
      ),
      Zone(
        zone: "6 zones",
        price: "113.75"    
      ),
    ]
  ),
  //----------------------------------------------------------------------
   TitleBus(
    title: "T-Jove (viatges il·limitats en 90 dies)",
    image: "assets/titlesBus/T_jove.jpg",
    description: "Abonament personalitzat vàlid per fer un nombre il·limitat de viatges durant 90 dies consecutius des de la primera cancel·lació per a menors de 25 anys que ho acreditin amb un carnet especial i personalitzat, mitjançant DNI, NIE o passaport. El número del DNI, NIE o passaport que serveixi com a acreditació ha de figurar imprès al bitllet. Vàlid per a les estacions de metro Aeroport T1 i Aeroport T2 de la línia L9 Sud.",
    zones: [
      Zone(
        zone: "1 zona",
        price: "80.00"    
      ),
      Zone(
        zone: "2 zones",
        price: "105.20"    
      ),
      Zone(
        zone: "3 zones",
        price: "147.55"    
      ),
      Zone(
        zone: "4 zones",
        price: "180.75"    
      ),
      Zone(
        zone: "5 zones",
        price: "207.40"    
      ),
      Zone(
        zone: "6 zones",
        price: "222.25"    
      ),
    ]
  ),
  //----------------------------------------------------------------------
  TitleBus(
    title: "T-Grup (70 viatges en 30 dies)",
    image: "assets/titlesBus/T_grup.jpg",
    description: "T-grup: Títol multipersonal i horari, de 70 viatges integrats en 30 dies consecutius des de la primera validació, en tots els modes de transport segons les zones per les quals es transiti (pagament màxim 6 zones).\n\nNo és vàlid a les estacions de metro d'Aeroport T1 i Aeroport T2 de la línia L9 Sud.",
    zones: [
      Zone(
        zone: "1 zona",
        price: "79.45"    
      ),
      Zone(
        zone: "2 zones",
        price: "156.80"    
      ),
      Zone(
        zone: "3 zones",
        price: "213.50"    
      ),
      Zone(
        zone: "4 zones",
        price: "274.40"    
      ),
      Zone(
        zone: "5 zones",
        price: "315.35"    
      ),
      Zone(
        zone: "6 zones",
        price: "335.30"    
      ),
    ]
  ),
  //----------------------------------------------------------------------
  TitleBus(
    title: "T-Familiar (8 viatges en 30 dies)",
    image: "assets/titlesBus/T_familiar.jpg",
    description: "T-familiar: Títol multipersonal i horari, de 8 viatges integrats en 30 dies consecutius des de la primera validació, en tots els modes de transport segons les zones per les quals es transiti (pagament màxim 6 zones).\n\nNo és vàlid a les estacions de metro d'Aeroport T1 i Aeroport T2 de la línia L9 Sud.\n\nAquest títol entrarà en vigor l’1 de març de 2020.",
    zones: [
      Zone(
        zone: "1 zona",
        price: "10.00"    
      ),
      Zone(
        zone: "2 zones",
        price: "19.00"    
      ),
      Zone(
        zone: "3 zones",
        price: "27.00"    
      ),
      Zone(
        zone: "4 zones",
        price: "35.00"    
      ),
      Zone(
        zone: "5 zones",
        price: "40.00"    
      ),
      Zone(
        zone: "6 zones",
        price: "42.00"    
      ),
    ]
  ),
  //----------------------------------------------------------------------
  TitleBus(
    title: "T-Dia (viatges il·limitats en 24 hores",
    image: "assets/titlesBus/T_dia.jpg",
    description: "T-dia: títol unipersonal, amb un nombre il·limitat de viatges integrats durant 24 hores a partir de la primera validació, a les zones delimitades per la primera validació, en tots els modes de transport, segons les zones per les quals es transiti (pagament màxim 6 zones).\n\nPermet, com a màxim, una anada i una tornada amb origen o destinació les estacions de metro d'Aeroport T1 i Aeroport T2 de la L9 Sud.",
    zones: [
      Zone(
        zone: "1 zona",
        price: "10.50"    
      ),
      Zone(
        zone: "2 zones",
        price: "16.00"    
      ),
      Zone(
        zone: "3 zones",
        price: "20.10"    
      ),
      Zone(
        zone: "4 zones",
        price: "22.45"    
      ),
      Zone(
        zone: "5 zones",
        price: "25.15"    
      ),
      Zone(
        zone: "6 zones",
        price: "28.15"    
      ),
    ]
  )
];