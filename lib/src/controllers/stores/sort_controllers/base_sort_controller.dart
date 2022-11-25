abstract class BaseSortController<Types extends Enum, ItemType> {
  abstract Types sortType;

  String get sortTypeName;

  String getSortTypeName(Types type);

  void setSortType(Types? type);

  List<ItemType> sort(List<ItemType> records);
}
