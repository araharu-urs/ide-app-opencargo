import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTripModal {
  static void show(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.6,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                children: [
                  // 🔹 Encabezado
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 40),
                      Text(
                        "create_trip".tr,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.close,
                            color: theme.iconTheme.color, size: 24),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // 🔹 Formulario Scrollable
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          // 🔸 ORIGEN: Código Postal + Selector
                          _buildTextField(
                            icon: Icons.location_on,
                            hint: "origin_postal_code".tr,
                            theme: theme,
                            isHalfWidth: true,
                            isRequired: true,
                          ),
                          _buildDropdownField(
                            icon: Icons.location_city,
                            hint: "select".tr,
                            theme: theme,
                            isHalfWidth: true,
                          ),
                          _buildTextField(
                            icon: Icons.place,
                            hint: "origin".tr,
                            theme: theme,
                          ),

                          // 🔸 CARGA EN:
                          _buildTextField(
                            icon: Icons.local_shipping,
                            hint: "load_place".tr,
                            theme: theme,
                          ),

                          // 🔸 DESTINO: Código postal + Kilometraje
                          _buildTextField(
                            icon: Icons.location_on_outlined,
                            hint: "destination_postal_code".tr,
                            theme: theme,
                            isHalfWidth: true,
                          ),
                          _buildTextField(
                            icon: Icons.straighten,
                            hint: "distance_km".tr,
                            theme: theme,
                            isHalfWidth: true,
                          ),
                          _buildTextField(
                            icon: Icons.place_outlined,
                            hint: "destination".tr,
                            theme: theme,
                          ),

                          // 🔸 Fecha de Retiro
                          _buildDateField(
                            icon: Icons.calendar_today,
                            label: "pickup_date".tr,
                            theme: theme,
                          ),

                          // 🔸 Fecha para inicio de ruta
                          _buildDateField(
                            icon: Icons.calendar_today,
                            label: "route_start_date".tr,
                            theme: theme,
                          ),

                          // 🔸 Total contenedores
                          _buildTextField(
                            icon: Icons.confirmation_number,
                            hint: "total_containers".tr,
                            theme: theme,
                            inputType: TextInputType.number,
                          ),

                          // 🔸 Tamaño del contenedor
                          _buildCheckboxGroup(
                            label: "container_size".tr,
                            options: ['20”', '40”', 'DC', 'HC'],
                          ),

                          // 🔸 Peso de carga
                          _buildTextField(
                            icon: Icons.scale,
                            hint: "min_weight".tr,
                            theme: theme,
                            isHalfWidth: true,
                            inputType: TextInputType.number,
                          ),
                          _buildTextField(
                            icon: Icons.scale_outlined,
                            hint: "max_weight".tr,
                            theme: theme,
                            isHalfWidth: true,
                            inputType: TextInputType.number,
                          ),

                          // 🔸 Modalidad de despacho
                          _buildDropdownField(
                            icon: Icons.swap_horiz,
                            hint: "dispatch_mode"
                                .tr, // e.g., FULL, SENCILLO, AMBAS
                            theme: theme,
                          ),

                          // 🔸 Ofertar o Tomar Carga
                          _buildDropdownField(
                            icon: Icons.assignment_turned_in,
                            hint: "offer_or_take".tr, // e.g., Ofertar o Tomar
                            theme: theme,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 🔹 Botón de enviar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.snackbar("trip_created".tr, "trip_success".tr);
                        Navigator.pop(context);
                      },
                      icon:
                          const Icon(Icons.send, size: 20, color: Colors.white),
                      label: Text("create_trip".tr,
                          style: const TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static Widget _buildDropdownField({
    required IconData icon,
    required String hint,
    required ThemeData theme,
    bool isHalfWidth = false,
  }) {
    return SizedBox(
      width: isHalfWidth ? Get.width * 0.45 : double.infinity,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          hintText: hint,
          hintStyle:
              theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          filled: true,
          fillColor: theme.inputDecorationTheme.fillColor ??
              (Get.isDarkMode ? Colors.grey[800] : Colors.grey[200]),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
        ),
        items: const [
          DropdownMenuItem(value: "opcion1", child: Text("Opción 1")),
          DropdownMenuItem(value: "opcion2", child: Text("Opción 2")),
        ],
        onChanged: (value) {},
      ),
    );
  }

  static Widget _buildDateField({
    required IconData icon,
    required String label,
    required ThemeData theme,
  }) {
    return _buildTextField(
      icon: icon,
      hint: label,
      theme: theme,
      inputType: TextInputType.datetime,
    );
  }

  static Widget _buildCheckboxGroup({
    required String label,
    required List<String> options,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Theme.of(Get.context!)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 10,
          children: options.map((option) {
            return FilterChip(
              label: Text(option),
              selected: false,
              onSelected: (_) {},
            );
          }).toList(),
        ),
      ],
    );
  }

  static Widget _buildTextField({
    required IconData icon,
    required String hint,
    required ThemeData theme,
    bool isRequired = false,
    bool isHalfWidth = false,
    TextInputType inputType = TextInputType.text,
    TextEditingController? controller,
  }) {
    return SizedBox(
      width: isHalfWidth ? Get.width * 0.45 : double.infinity,
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          hintText: isRequired ? "$hint *" : hint,
          hintStyle:
              theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          filled: true,
          fillColor: theme.inputDecorationTheme.fillColor ??
              (Get.isDarkMode ? Colors.grey[800] : Colors.grey[200]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
