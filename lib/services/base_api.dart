


abstract class BaseApi<T> {

  Future getAll();

  Future getById( String id );

  Future save( T t );

  Future update( String id, T t );
  
  Future delete( String id ); 

}