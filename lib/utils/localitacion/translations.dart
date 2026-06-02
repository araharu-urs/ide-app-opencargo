import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          // General
          'login': 'Login',
          'email': 'Email',
          'password': 'Password',
          'loading': 'Loading...',
          'error': 'Error',
          'success': 'Success',
          'back': 'Back',

          // Login
          'login_successful': 'Login successful',
          'invalid_credentials': 'Invalid credentials',

          // Reset Password
          'reset_password': 'Reset Password',
          'email_sent': 'A recovery link has been sent to your email',
          'email_required': 'Email is required',

          'Forgot password?': 'Forgot password?',
          'An error occurred': 'An error occurred',
          'Error Details:': 'Error Details:',
          'Close': 'Close',

          //REGISTRO
          'register': 'Register',
          'name': 'Name',
          'email': 'Email',
          'password': 'Password',
          'confirm_password': 'Confirm Password',
          'select_profile': 'Select your profile type:',
          'company_name': 'Company Name',
          'rfc': 'RFC',
          'register_button': 'Register',

          //SEGURIDAD
          'security': 'Seguridad',
          'change_password': 'Cambiar contraseña',
          'enable_biometric_auth': 'Habilitar autenticación biométrica',
          'view_login_activity': 'Verificar actividad de inicio de sesión',
          'privacy_policy': 'Política de privacidad',

//SOBRE APP
          'about_title': 'About the App',
          'version': 'Version 1.0.0',
          'about_what_title': '📌 What is Open Cargo?',
          'about_what_desc':
              'Open Cargo is an advanced platform for transportation and logistics management, '
                  'designed to simplify fleet, trip, and driver communication management.',
          'about_features_title': '🔹 Features',
          'about_feature_1': '✔ Trip and fleet management.',
          'about_feature_2': '✔ Real-time offers and contracts.',
          'about_feature_3': '✔ 24/7 technical support.',
          'about_feature_4': '✔ Data security and privacy.',
          'copyright': '© 2025 Open Cargo. All rights reserved.',

          //SOPORTE
          'support_title': 'Support & Help',
          'support_contact': '📞 Support Contact',
          'support_call': 'Call',
          'support_email': 'Email',
          'support_chat': 'Live Chat',
          'support_chat_available': 'Available 24/7',
          'support_faq': '❓ Frequently Asked Questions',
          'faq_create_account_q': 'How do I create an account?',
          'faq_create_account_a':
              'You can register from the main screen by entering your details.',
          'faq_manage_trips_q': 'How do I manage my trips?',
          'faq_manage_trips_a':
              'From the main panel, go to the "My Trips" section.',
          'faq_issues_q': 'What if I have issues?',
          'faq_issues_a': 'Contact us via phone or email.',
          'copyright': '© 2025 Open Cargo. All rights reserved.',

          ///TABS
          'Home': 'Home',
          'Profile': 'Profile',
          'Settings': 'Settings',
          'Agencia': 'Agency',
          'Transporte': 'Transport',
          'Público': 'Public',

          //AJUSTES
          'account': 'Account',
          'profile': 'Profile',
          'navigate_profile': 'Navigate to profile settings',
          'change_password': 'Change Password',
          'navigate_password': 'Navigate to change password',
          'preferences': 'Preferences',
          'notifications': 'Notifications',
          'appearance': 'Appearance',
          'security': 'Security',
          'privacy_policy': 'Privacy Policy',
          'security_settings': 'Security Settings',
          'about': 'About',
          'about_app': 'About the App',
          'support_help': 'Support & Help',

          //APARIENCIA

          'appearance': 'Appearance',
          'dark_mode': 'Dark Mode',
          'font_size': 'Font Size',
          'theme_color': 'Theme Color',
          'language': 'Language',
          'English': 'English',
          'Español': 'Spanish',

          //CREAR VIAJE
          'create_trip': 'Create a Trip',
          'origin': 'Origin',
          'destination': 'Destination',
          'departure_date': 'Departure Date',
          'vehicle_type': 'Vehicle Type',
          'load_number': 'Load Number',
          'transport_company': 'Transport Company',
          'trip_cost': 'Trip Cost',
          'trip_created': 'Trip Created',
          'trip_success': 'Your trip has been successfully registered',

          //DETALLES DE OFERTADORES MODAL
          'trip_details': 'Trip Details',
          'estado': 'Status',
          'tipo': 'Type',
          'flota': 'Fleet',
          'origen': 'Origin',
          'destino': 'Destination',
          'fecha_salida': 'Departure Date',
          'fecha_llegada': 'Arrival Date',
          'accept_offer': 'Accept Offer',
          'reject_offer': 'Reject Offer',
          'offer_accepted': 'Offer accepted',
          'offer_rejected': 'Offer rejected',
          'not_specified': 'Not specified',
          'action': 'Action',
          'no_trip_found': 'Trip not found',

          ///
          ///
          ///
          'cp_origen': 'Origin ZIP Code',
          'cp_destino': 'Destination ZIP Code',
          'no_contenedores': 'No. of Containers',
          'tam_contenedor_num': 'Container Size',
          'tam_contenedor_tipo': 'Container Type',
          'peso_min': 'Min Weight',
          'peso_max': 'Max Weight',
          'modalidad': 'Mode',
          'precio_full': 'Full Price',
          'precio_sencillo': 'Simple Price',

          'call': 'Llamar',
          'message': 'Mensaje',
          'email': 'Correo electrónico',
          'contact_info': 'Información de contacto',
          'phone': 'Teléfono',
          'location': 'Ubicación',
          'services_offered': 'Servicios ofrecidos',
          'heavy_transport': 'Transporte pesado',
          'refrigerated_cargo': 'Carga refrigerada',
          'international_logistics': 'Logística internacional',

          ///camviar contrasens
          'change_password': 'Change Password',
          'enter_email_instruction':
              'Enter your email to receive a reset link.',
          'email': 'Email',
          'send_reset_link': 'Send Reset Link',
          'success': 'Success',
          'reset_link_sent': 'We\'ve sent a password reset link to your email.',
          'insured': 'Seguros incluidos',

          //DETALLE OFERTADORES:
          'offers_received': 'Offers Received',
          'no_offers_available': 'No offers available',
          'fleet': 'Fleet: @value',
          'status': 'Status: @value',
          'view': 'View',

          /////
           'offer_details': 'Offer Details',
  'offer_not_found': 'Offer not found',
  'fleet': 'Fleet',
  'status': 'Status',
  'price': 'Price',
  'accept_offer': 'Accept Offer',
  'reject_offer': 'Reject Offer',
  'send_message': 'Send Message',
  'action': 'Action',
  'offer_accepted': 'Offer accepted',
  'offer_rejected': 'Offer rejected',
  'open_chat_with': 'Opening chat with',
        },
        'es_ES': {
          // General
          'login': 'Iniciar sesión',
          'email': 'Correo electrónico',
          'password': 'Contraseña',
          'loading': 'Cargando...',
          'error': 'Error',
          'success': 'Éxito',
          'back': 'Atrás',

          // Login
          'login_successful': 'Inicio de sesión exitoso',
          'invalid_credentials': 'Credenciales incorrectas',

          // Reset Password
          'reset_password': 'Restablecer Contraseña',
          'email_sent': 'Se envió un enlace de recuperación a tu correo',
          'email_required': 'El correo es requerido',

          'Forgot password?': '¿Olvidaste tu contraseña?',
          'An error occurred': 'Ha ocurrido un error',
          'Error Details:': 'Detalles del error:',
          'Close': 'Cerrar',

          //REGISTRO
          'register': 'Registro',
          'name': 'Nombre',
          'email': 'Correo Electrónico',
          'password': 'Contraseña',
          'confirm_password': 'Confirmar Contraseña',
          'select_profile': 'Selecciona tu tipo de perfil:',
          'company_name': 'Nombre de la Empresa',
          'rfc': 'RFC',
          'register_button': 'Registrarse',

          //SEGURIDAD
          'security': 'Security',
          'change_password': 'Change password',
          'enable_biometric_auth': 'Enable biometric authentication',
          'view_login_activity': 'View login activity',
          'privacy_policy': 'Privacy Policy',

//SOBRE LA APP
          'about_title': 'Sobre la App',
          'version': 'Versión 1.0.0',
          'about_what_title': '📌 ¿Qué es Open Cargo?',
          'about_what_desc':
              'Open Cargo es una plataforma avanzada para la gestión de transporte y logística, '
                  'diseñada para facilitar la administración de flotas, viajes y comunicación entre transportistas.',
          'about_features_title': '🔹 Características',
          'about_feature_1': '✔ Gestión de viajes y flotas.',
          'about_feature_2': '✔ Ofertas y contratos en tiempo real.',
          'about_feature_3': '✔ Soporte técnico 24/7.',
          'about_feature_4': '✔ Seguridad y privacidad de datos.',
          'copyright': '© 2025 Open Cargo. Todos los derechos reservados.',
          //SOPORTE
          'support_title': 'Soporte y Ayuda',
          'support_contact': '📞 Contacto de Soporte',
          'support_call': 'Llamada',
          'support_email': 'Correo Electrónico',
          'support_chat': 'Chat en Vivo',
          'support_chat_available': 'Disponible 24/7',
          'support_faq': '❓ Preguntas Frecuentes',
          'faq_create_account_q': '¿Cómo creo una cuenta?',
          'faq_create_account_a':
              'Puedes registrarte desde la pantalla principal, ingresando tus datos.',
          'faq_manage_trips_q': '¿Cómo gestiono mis viajes?',
          'faq_manage_trips_a':
              'Desde el panel principal, accede a la sección "Mis Viajes".',
          'faq_issues_q': '¿Qué hacer si tengo problemas?',
          'faq_issues_a': 'Contáctanos por teléfono o correo electrónico.',
          'copyright': '© 2025 Open Cargo. Todos los derechos reservados.',
//TABS
          'Home': 'Inicio',
          'Profile': 'Perfil',
          'Settings': 'Ajustes',
          'Agencia': 'Agencia',
          'Transporte': 'Transporte',
          'Público': 'Público',

          ///AJUSTES
          'account': 'Cuenta',
          'profile': 'Perfil',
          'navigate_profile': 'Navegar a ajustes del perfil',
          'change_password': 'Cambiar contraseña',
          'navigate_password': 'Navegar a cambio de contraseña',
          'preferences': 'Preferencias',
          'notifications': 'Notificaciones',
          'appearance': 'Apariencia',
          'security': 'Seguridad',
          'privacy_policy': 'Política de privacidad',
          'security_settings': 'Configuraciones de seguridad',
          'about': 'Acerca de',
          'about_app': 'Sobre la app',
          'support_help': 'Soporte y ayuda',

          ///APARICIA
          'appearance': 'Apariencia',
          'dark_mode': 'Modo oscuro',
          'font_size': 'Tamaño de fuente',
          'theme_color': 'Color del tema',
          'language': 'Idioma',
          'English': 'Inglés',
          'Español': 'Español',

          //CREAR VIAJE
          'create_trip': 'Crear un viaje',
          'origin': 'Origen',
          'destination': 'Destino',
          'departure_date': 'Fecha de salida',
          'vehicle_type': 'Tipo de vehículo',
          'load_number': 'Número de cargas',
          'transport_company': 'Empresa de transporte',
          'trip_cost': 'Costo del viaje',
          'trip_created': 'Viaje creado',
          'trip_success': 'Tu viaje ha sido registrado con éxito',

          //DETALLE DE OFERTADORES MODAL
          'trip_details': 'Detalle del Viaje',
          'estado': 'Estado',
          'tipo': 'Tipo',
          'flota': 'Flota',
          'origen': 'Origen',
          'destino': 'Destino',
          'fecha_salida': 'Fecha de Salida',
          'fecha_llegada': 'Fecha de Llegada',
          'accept_offer': 'Aceptar Oferta',
          'reject_offer': 'Rechazar Oferta',
          'offer_accepted': 'Oferta aceptada',
          'offer_rejected': 'Oferta rechazada',
          'not_specified': 'No especificada',
          'action': 'Acción',
          'no_trip_found': 'No se encontró el viaje',

          ///

          'cp_origen': 'Código Postal Origen',
          'cp_destino': 'Código Postal Destino',
          'no_contenedores': 'N.º de Contenedores',
          'tam_contenedor_num': 'Tamaño del Contenedor',
          'tam_contenedor_tipo': 'Tipo de Contenedor',
          'peso_min': 'Peso Mínimo',
          'peso_max': 'Peso Máximo',
          'modalidad': 'Modalidad',
          'precio_full': 'Precio Full',
          'precio_sencillo': 'Precio Sencillo',

          ///DETALLE DE PERFIL
          'call': 'Call',
          'message': 'Message',
          'email': 'Email',
          'contact_info': 'Contact Information',
          'phone': 'Phone',
          'location': 'Location',
          'services_offered': 'Services Offered',
          'heavy_transport': 'Heavy Transport',
          'refrigerated_cargo': 'Refrigerated Cargo',
          'international_logistics': 'International Logistics',
          'insured': 'Insured',

          //cambiar contrasena

          'change_password': 'Cambiar contraseña',
          'enter_email_instruction':
              'Ingresa tu correo electrónico para recibir un enlace de restablecimiento.',
          'email': 'Correo electrónico',
          'send_reset_link': 'Enviar enlace',
          'success': 'Éxito',
          'reset_link_sent':
              'Hemos enviado un enlace de restablecimiento a tu correo.',

          //DETALLE OFERTADORES
          'offers_received': 'Ofertas Recibidas',
          'no_offers_available': 'No hay ofertas disponibles',
          'fleet': 'Flota: @value',
          'status': 'Estado: @value',
          'view': 'Ver',

          ///
            'offer_details': 'Detalle de la Oferta',
  'offer_not_found': 'No se encontró la oferta',
  'fleet': 'Flota',
  'status': 'Estado',
  'price': 'Precio',
  'accept_offer': 'Aceptar Oferta',
  'reject_offer': 'Rechazar Oferta',
  'send_message': 'Enviar Mensaje',
  'action': 'Acción',
  'offer_accepted': 'Oferta aceptada',
  'offer_rejected': 'Oferta rechazada',
  'open_chat_with': 'Abriendo chat con',
        },
      };
}
