class ItemsModel {
  String category;
  String itemName;
  String description;
  int price;
  int weight;

  ItemsModel({
    required this.category,
    required this.itemName,
    required this.description,
    required this.price,
    required this.weight,
  });
}

int setPrice(String key) {
  switch (key) {
    case 'Handphone':
      return 200000;
    case 'Monitor LED':
      return 50000;
    case 'Kulkas':
      return 100000;
    case 'Televisi Tabung':
      return 50000;
    case 'Televisi LED':
      return 300000;
    case 'Baterai':
      return 50000;
    case 'Botol Mineral':
      return 1500;
    case 'Jerigen':
      return 500;
    case 'Wadah Parfum':
      return 1200;
    case 'Galon':
      return 30000;
    case 'Karton':
      return 500;
    case 'Kardus':
      return 1000;
    case 'Buku':
      return 700;
    case 'Kanvas':
      return 2000;
    case 'Cermin':
      return 500;
    case 'Kaca Bening':
      return 300;
    case 'Botol Kaca':
      return 200;
    case 'Kaleng':
      return 800;
    case 'Peralatan Masak':
      return 500;
    case 'Kain Perca':
      return 2000;
    case 'Sepatu':
      return 15000;
    case 'Tas':
      return 20000;
    default:
      return 0;
  }
}

String getCategory(String key) {
  switch (key) {
    case 'Handphone':
      return 'Elektronik';
    case 'Monitor LED':
      return 'Elektronik';
    case 'Kulkas':
      return 'Elektronik';
    case 'Televisi Tabung':
      return 'Elektronik';
    case 'Televisi LED':
      return 'Elektronik';
    case 'Baterai':
      return 'Elektronik';
    case 'Botol Mineral':
      return 'Plastik';
    case 'Jerigen':
      return 'Plastik';
    case 'Wadah Parfum':
      return 'Plastik';
    case 'Galon':
      return 'Plastik';
    case 'Karton':
      return 'Kertas';
    case 'Kardus':
      return 'Kertas';
    case 'Buku':
      return 'Kertas';
    case 'Kanvas':
      return 'Kertas';
    case 'Cermin':
      return 'Kaca';
    case 'Kaca Bening':
      return 'Kaca';
    case 'Botol Kaca':
      return 'Kaca';
    case 'Kaleng':
      return 'Logam';
    case 'Peralatan Masak':
      return 'Logam';
    case 'Kain Perca':
      return 'Kain';
    case 'Sepatu':
      return 'Kain';
    case 'Tas':
      return 'Kain';
    default:
      return 'Error';
  }
}