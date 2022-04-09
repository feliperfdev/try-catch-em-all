import 'package:flutter/material.dart';
import 'package:try_catch_em_all/app/modules/pokedex/domain/entities/pokemon.dart';
import 'package:try_catch_em_all/app/modules/pokedex/domain/usecases/get_pokedex.dart';
import 'package:try_catch_em_all/app/modules/pokedex/domain/usecases/get_pokemon_form.dart';
import 'package:try_catch_em_all/app/modules/pokedex/domain/usecases/get_pokemon_info.dart';
import 'package:try_catch_em_all/app/modules/pokedex/states/pokedex_state.dart';

class PokedexController extends ValueNotifier<PokedexState> {
  PokedexController(this._getPokedexUsecase, this._getPokemonInfoUsecase,
      this._getPokemonFormUsecase)
      : super(PokedexInitialState());

  final GetPokedexContract _getPokedexUsecase;
  final GetPokemonInfoContract _getPokemonInfoUsecase;
  final GetPokemonFormContract _getPokemonFormUsecase;

  final searchController = TextEditingController();

  Future<void> getPokedex(String pokedexID) async {
    final response = await _getPokedexUsecase(pokedexID);

    value = PokedexLoadingState();

    return response.fold(
      (error) {
        value = error;
      },
      (pokedex) {
        List<Pokemon> entries = pokedex.pokemonEntries!.where((entry) {
          if (searchController.text.isEmpty) {
            return true;
          }
          return (entry.name)!
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              (entry.number!.toString())
                  .contains(searchController.text.toLowerCase());
        }).toList();
        pokedex = pokedex.copyWith(pokemonEntries: entries);
        value = PokedexSuccessState(pokedex);
      },
    );
  }

  Future<void> getPokemonInfo(String url) async {
    final response = await _getPokemonInfoUsecase(url);

    value = PokedexLoadingState();

    return response.fold(
      (error) {
        value = error;
      },
      (info) {
        value = PokedexPokemonInfoSuccessState(info);
      },
    );
  }

  Future<void> getPokemonForm(String id) async {
    final response = await _getPokemonFormUsecase(id);

    value = PokedexLoadingState();

    return response.fold(
      (error) {
        value = error;
      },
      (form) {
        value = PokedexPokemonFormSuccessState(form);
      },
    );
  }
}
