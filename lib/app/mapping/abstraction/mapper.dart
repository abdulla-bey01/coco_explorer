//Mapper is a base class for ala mapper classes
abstract class Mapper<M, D> {
  //M means model class
  M toModel(D d);
  //D means dto class
  D toDto(M m);
}
