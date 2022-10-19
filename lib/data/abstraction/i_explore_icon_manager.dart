//provides all explore icon managers with the functions or properties they need
abstract class IExploreIconManager<T> {
  Future<List<T>> getAll();
}
