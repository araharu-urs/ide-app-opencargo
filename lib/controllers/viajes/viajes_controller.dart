import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_cargo/models/viajes/detalle_negociacion_model.dart';
import 'package:open_cargo/models/viajes/negociaciones_model.dart';
import 'package:open_cargo/models/viajes/oferta_detalle_model.dart';
import 'package:open_cargo/models/viajes/ofertas_model.dart';
import 'package:open_cargo/models/viajes/viajes_detalle_model.dart';
import 'package:open_cargo/models/viajes/viajes_model.dart';
import 'package:open_cargo/services/viajes/viajes_servicie.dart';
import 'package:open_cargo/views/auth/user/profile/tabs/modal_negociaciones.dart';

class ViajeController extends GetxController {
  final ViajeService _viajeService = ViajeService();
  var usuariosOfertando = <UsuarioOfertaModel>[].obs;
  var ofertasProceso = <OfertaEnProcesoModel>[].obs;
  var detalleOfertaProceso = Rxn<OfertaProcesoDetalleModel>();
  var viajes = <ViajeModel>[].obs;
  var isLoading = false.obs;
  var isLoadingOferta = false.obs;
  var isLoadingViajeDetalle = false.obs;
  final box = GetStorage();
  final TextEditingController precioFull = TextEditingController();
  final TextEditingController cantidadFull = TextEditingController();
  final TextEditingController precioSencillo = TextEditingController();
  final TextEditingController cantidadSencillo = TextEditingController();

  final TextEditingController cantidadTomarCarga = TextEditingController();
  @override
  void onInit() {
    final String? id = box.read('id');

    if (id != null && id.isNotEmpty) {
      fetchViajesByUser();
      cargarOfertasProceso();
    } else {
      fetchViajes();
      cargarOfertasProceso();
    }

    super.onInit();
  }

  void mostrarSeguimientoBottomSheet(BuildContext context,
      {int pasosActivos = 4, required int viaje}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
     builder: (_) => SeguimientoBottomSheet(ofertaId: viaje),
    );
  }

  Future<void> fetchViajes() async {
    isLoading.value = true;
    final viajesList = await _viajeService.getViajes();
    //print(viajesList);
    if (viajesList != null) {
      viajes.assignAll(viajesList);
    }
    isLoading.value = false;
  }

  Future<void> fetchViajesByUser() async {
    isLoading.value = true;
    final viajesList = await _viajeService.getViajesByUser();
    if (viajesList != null) {
      viajes.assignAll(viajesList);
    }
    isLoading.value = false;
  }

  Future<void> addViaje(ViajeModel viaje) async {
    isLoading.value = true;
    final newViaje = await _viajeService.createViaje(viaje);
    if (newViaje != null) {
      viajes.add(newViaje);
    }
    isLoading.value = false;
  }

  Future<void> fetchUsuariosOfertando(int viajeId) async {
    isLoadingOferta.value = true;
    final usuarios = await _viajeService.getUsuariosOfertando(viajeId);
    if (usuarios != null) {
      usuariosOfertando.assignAll(usuarios);
    }
    isLoadingOferta.value = false;
  }

  var ofertaDetalle = Rxn<OfertaDetalleModel>();

  Future<void> fetchOfertaDetalle(int ofertaId) async {
    isLoading.value = true;
    final oferta = await _viajeService.getOfertaDetalle(ofertaId);
    ofertaDetalle.value = oferta;
    isLoading.value = false;
  }

  var viajeDetalle = Rxn<ViajeDetalleModel>();

  Future<void> fetchViajeDetalle(int viajeId) async {
    isLoadingViajeDetalle.value = true;
    final oferta = await _viajeService.getViajeDetalle(viajeId);
    viajeDetalle.value = oferta;
    isLoadingViajeDetalle.value = false;
  }

  Future<bool> registrarOferta({
    required int viajeId,
    required String tipo,
  }) async {
    isLoading.value = true;

    final result = await _viajeService.enviarOferta(
      viajeId: viajeId.toString(),
      tipo: tipo,
      precioFull: precioFull.text,
      cantidadFull: cantidadFull.text,
      precioSencillo: precioSencillo.text,
      cantidadSencillo: cantidadSencillo.text,
      cantidad: cantidadTomarCarga.text,
    );

    isLoading.value = false;
    return result;
  }

  Future<void> aceptarOferta(int ofertaId) async {
    isLoading.value = true;
    final success = await _viajeService.aceptarOferta(ofertaId);
    if (success) {
      // await fetchUsuariosOfertando(ofertaDetalle.value!.id);
    }
    isLoading.value = false;
  }

  Future<void> rechazarOferta(int ofertaId) async {
    isLoading.value = true;
    final success = await _viajeService.rechazarOferta(ofertaId);
    if (success) {
      await fetchUsuariosOfertando(ofertaDetalle.value!.id);
    }
    isLoading.value = false;
  }

  Future<void> cargarOfertasProceso() async {
    isLoading.value = true;
    final resultado = await _viajeService.getOfertasEnProcesoByUser();
    if (resultado != null) {
      ofertasProceso.assignAll(resultado);
    }
    isLoading.value = false;
  }

  Future<void> fetchOfertaEnProcesoDetalle(int ofertaId) async {
    final detalle = await _viajeService.getOfertaEnProcesoDetalle(
      ofertaId: ofertaId,
    );

    if (detalle != null) {
      detalleOfertaProceso.value = detalle;
    }
  }
}
