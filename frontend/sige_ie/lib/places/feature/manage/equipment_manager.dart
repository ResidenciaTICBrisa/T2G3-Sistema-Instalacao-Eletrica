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
        return ['Para Raios', 'Captação', 'Subsistemas'];
      case 3:
        return [
          'Alarme de Incêndio',
          'Sensor de Fumaça',
          'Sensor de Temperatura',
          'Acionadores',
          'Central de alarme de Incêndio'
        ];
      default:
        return [];
    }
  }
}
