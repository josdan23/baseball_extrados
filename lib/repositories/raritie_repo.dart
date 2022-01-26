import 'package:logger/logger.dart';

import 'package:baseball_cards/models/rarities.dart';
import 'package:baseball_cards/services/mappers/rarities_mapper.dart';
import 'package:baseball_cards/services/raririties_api.dart';

class RaritieRepo {
  

  final List<Rarities> _raritiesList = [];
  final RaritiesApi _dataSources;

  final Logger logger = Logger();

  static RaritieRepo? _INSTANCE;

  static RaritieRepo getInstance(RaritiesApi dataSource) {

    _INSTANCE ??= RaritieRepo._internal(dataSource);
    return _INSTANCE!;

  }

  RaritieRepo._internal( RaritiesApi dataSource ) : this._dataSources = dataSource;

  Future<List<Rarities>> getAllRarities() async {


    try {
      final Map<String, dynamic> dataJson = await _dataSources.getAll();

      final mapper = RaritiesMapper();

      dataJson.forEach((key, value) {

        final Rarities raritieMapped = mapper.fromMap( value );
        raritieMapped.idRarities = key;

        if ( !_raritiesList.contains( raritieMapped ) ) {
          _raritiesList.add( raritieMapped );
        }

      });

      return _raritiesList;
    } catch ( e ){
      logger.e( e );
      throw Exception('No se puedo recuperar la lista de rarezas');
    }
    
  }


  Future getRaritieById( String id ) async {

    for (var oneRaritie in _raritiesList) {
      if (oneRaritie.idRarities == id ){
        return oneRaritie;
      }
    }

    try {

      final dataJson = await _dataSources.getById( id );

      final rarityMapped = RaritiesMapper().fromMap( dataJson );
      rarityMapped.idRarities = id;

      _raritiesList.add( rarityMapped );
      
      return rarityMapped;

    } catch( e ) {
      logger.e( e );
      throw Exception('No se pudo recuperar rareza id: $id');
    }
  }


  Future save( Rarities newRarity) async {

    try {
      
      final dataJson = await _dataSources.save( newRarity );

      final id = dataJson['name'];

      newRarity.idRarities = id;

      _raritiesList.add(newRarity);

      return newRarity;
    
    } catch (e) {
      logger.e( e );
      throw Exception('Error con el servidor');
    }
  }

  Future delete( String id ) async {
    
    try {

      await _dataSources.delete( id );

      _raritiesList.removeWhere((element) => element.idRarities == id);

      return true;

    } catch (e) {
      logger.e( e );
      throw Exception('Error con el servidor');
    }
  }


  Future update( String id, Rarities rarityToUpdate ) async {

    try {

      rarityToUpdate.idRarities = null;
      final dataJson = await _dataSources.update( id , rarityToUpdate );
      
      final Rarities rarityUpdated = RaritiesMapper().fromMap(dataJson);
      rarityUpdated.idRarities = id;

      for (var oneRarity in _raritiesList) {
        if (oneRarity.idRarities == id) {
          oneRarity.description = rarityUpdated.description;
          return oneRarity;
        }
      }
    
    } catch (e) {
      logger.e( e );
      throw Exception( 'Server error' );
    }

  }

}