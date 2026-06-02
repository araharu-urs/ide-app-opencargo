import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_cargo/env.dart';
import 'package:open_cargo/models/viajes/detalle_negociacion_model.dart';
import 'package:open_cargo/models/viajes/negociaciones_model.dart';
import 'package:open_cargo/models/viajes/oferta_detalle_model.dart';
import 'package:open_cargo/models/viajes/ofertas_model.dart';
import 'package:open_cargo/models/viajes/viajes_detalle_model.dart';
import 'package:open_cargo/models/viajes/viajes_model.dart';
import 'package:open_cargo/services/api/%20api_service.dart';
import 'package:open_cargo/widgets/exceptions/error_modal.dart';

class ViajeService extends GetConnect {
  final headers = HttpHeadersService.getHeaders();
  Future<List<ViajeModel>?> getViajes() async {
    try {
      final response = await get(
        '${Env.baseUrl}/viajes/all',
        headers: headers,
      );

      if (response.statusCode == 200) {
        return ViajeModel.fromJsonList(response.body);
      } else {
        ErrorModal.show(Get.context!, response.statusCode.toString());
        return null;
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
      return null;
    }
  }

  Future<List<ViajeModel>?> getViajesByUser() async {
    try {
      final box = GetStorage();
      final String? id = box.read('id');
      final response = await get(
        '${Env.baseUrl}/viajes/user/$id',
        headers: headers,
      );

      if (response.statusCode == 200) {
        return ViajeModel.fromJsonList(response.body);
      } else {
        ErrorModal.show(Get.context!, response.statusCode.toString());
        return null;
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
      return null;
    }
  }

  Future<ViajeModel?> createViaje(ViajeModel viaje) async {
    try {
      final response = await post(
        '${Env.baseUrl}/viajes',
        viaje.toJson(),
        headers: headers,
      );

      if (response.statusCode == 201) {
        return ViajeModel.fromJson(response.body['viaje']);
      } else {
        ErrorModal.show(Get.context!, response.statusCode.toString());
        return null;
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
      return null;
    }
  }

  Future<List<UsuarioOfertaModel>?> getUsuariosOfertando(int viajeId) async {
    try {
      final response =
          await get('${Env.baseUrl}/viajes/$viajeId/ofertas', headers: headers);

      if (response.statusCode == 200) {
        return UsuarioOfertaModel.fromJsonList(response.body);
      } else {
        ErrorModal.show(Get.context!, response.statusCode.toString());
        return null;
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
      return null;
    }
  }

  Future<OfertaDetalleModel?> getOfertaDetalle(int ofertaId) async {
    try {
      final response = await get(
        '${Env.baseUrl}/viajes/ofertas/$ofertaId/detalle',
        headers: headers,
      );
      if (response.statusCode == 200) {
        return OfertaDetalleModel.fromJson(response.body);
      } else {
        ErrorModal.show(Get.context!, response.statusCode.toString());
        return null;
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
      return null;
    }
  }

  Future<ViajeDetalleModel?> getViajeDetalle(int viajeId) async {
    try {
      final response = await get(
        '${Env.baseUrl}/viajes/$viajeId/detalle',
        headers: headers,
      );

      if (response.statusCode == 200) {
        return ViajeDetalleModel.fromJson(response.body);
      } else {
        ErrorModal.show(Get.context!, response.statusCode.toString());
        return null;
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
      return null;
    }
  }

  Future<bool> enviarOferta({
    required String viajeId,
    required String tipo,
    String? precioFull,
    String? cantidadFull,
    String? precioSencillo,
    String? cantidadSencillo,
    String? cantidad,
  }) async {
    try {
      final box = GetStorage();
      final String userId = box.read('id');

      final Map<String, dynamic> payload = {
        "user_id": userId,
        "viaje_id": viajeId,
        "tipo": tipo,
      };

      if (tipo == "Ofertar") {
        payload.addAll({
          "precio_full": precioFull,
          "cantidad_full": cantidadFull,
          "precio_sencillo": precioSencillo,
          "cantidad_sencillo": cantidadSencillo,
        });
      }

      if (tipo == "Tomar Carga") {
        payload.addAll({
          "cantidad": cantidad,
        });
      }
      final response = await post(
        '${Env.baseUrl}/viajes/crearOferta',
        payload,
        headers: headers,
      );
      if (response.statusCode == 201) {
        Get.back();
        return true;
      } else {
        final json = response.body;

        ErrorModal.show(Get.context!, json['message'] ?? 'Error inesperado');
        return false;
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
      return false;
    }
  }

  Future<bool> aceptarOferta(int ofertaId) async {
    try {
      final response = await put(
        '${Env.baseUrl}/ofertas/$ofertaId/aceptar',
        {},
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Éxito', 'Oferta aceptada correctamente');
        return true;
      } else {
        ErrorModal.show(Get.context!,
            response.body['message'] ?? 'Error al aceptar oferta');
        return false;
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
      return false;
    }
  }

  Future<bool> rechazarOferta(int ofertaId) async {
    try {
      final response = await put(
        '${Env.baseUrl}/ofertas/$ofertaId/rechazar',
        {},
        headers: headers,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Éxito', 'Oferta rechazada correctamente');
        return true;
      } else {
        ErrorModal.show(Get.context!,
            response.body['message'] ?? 'Error al rechazar oferta');
        return false;
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
      return false;
    }
  }

  Future<List<OfertaEnProcesoModel>?> getOfertasEnProcesoByUser() async {
    try {
      final String? userId = GetStorage().read('id');
      final response = await get(
        '${Env.baseUrl}/negociaciones/$userId/viajes',
        headers: headers,
      );

      if (response.statusCode == 200) {
        return OfertaEnProcesoModel.fromJsonList(response.body);
      } else {
        ErrorModal.show(Get.context!, 'Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
      return null;
    }
  }

  Future<OfertaProcesoDetalleModel?> getOfertaEnProcesoDetalle({
    required int ofertaId,
  }) async {
    try {
      final box = GetStorage();
      final String? id = box.read('id');
      final response = await get(
        '${Env.baseUrl}/negociaciones/$ofertaId/detalle/$id',
        headers: headers,
      );

      if (response.statusCode == 200) {
        return OfertaProcesoDetalleModel.fromJson(response.body);
      } else {
        ErrorModal.show(Get.context!, "Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
      return null;
    }
  }
}
