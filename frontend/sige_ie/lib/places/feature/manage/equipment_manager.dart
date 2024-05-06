class EquipmentManager {
  static const Map<int, String> categoryMap = {
    1: 'Cabeamento Estruturado',
    2: 'Descargas Atmosféricas',
    3: 'Alarme de Incêndio'
  };

  static List<String> getCategoryList() {
    return categoryMap.values.toList();
  }

  static List<String> getEquipmentList(int categoryId) {
    switch (categoryId) {
      case 1:
        return ['Eletroduto', 'Eletrocalha', 'Dimensão'];
      case 2:
        return ['Para-raios', 'Captação', 'Subsistemas'];
      case 3:
        return [
          'Alarme de incêndio',
          'Sensor de fumaça',
          'Sensor de temperatura',
          'Acionadores',
          'Central de alarme de incêndio'
        ];
      default:
        return [];
    }
  }
}
