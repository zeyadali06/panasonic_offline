import 'package:flutter/material.dart';

const KPrimayColor = Color(0xff0041c0);
const String usersCollection = 'UsersAndTheirDevices';
const String allProductsCollection = 'AllProducts';
const String usernameCollection = 'UsernameCollection';
const Set<String> allCategories = {
  'Air Conditioning',
  'Automation Control Components',
  'Blu-ray Disc',
  'Broadcast & Professional Video',
  'Business Communication Systems',
  'Business Fax',
  'Capacitors',
  'Document Scanner',
  'Electronic Materials',
  'Electronic Whiteboard',
  'FA Sensors & Components',
  'Factory Automation, Welding Machines',
  'HD Visual Communications System',
  'Housing Equipment Devices',
  'Inductors (Coils)',
  'Industrial Batteries',
  'IP Phone',
  'Lighting',
  'Media Entertainment',
  'Mobile PC / Tablet',
  'Motors, Compressors',
  'Multi-Function Laser',
  'Optical Disc Archive Solution',
  'Photovoltaic',
  'POS Workstation',
  'Professional Displays',
  'Projector',
  'Resistors',
  'SD Memory Card',
  'Security',
  'Semiconductors',
  'Sensors',
  'Silky Fine Mist Systems',
  'Thermal Management Solutions',
  'Ventilating Fan',
  'Visual Sort Assist',
};
const Set<String> allCompatibleDevices = {
  'KX-TEA308',
  'KX-TES824',
  'KX-TEM824',
  'KX-TDA30',
  'KX-TDA100',
  'KX-TDA100D',
  'KX-TDA200',
  'KX-TDA600',
  'KX-TDA620',
  'KX-NCP500',
  'KX-NCP1000',
  'KX-TDE100',
  'KX-TDE200',
  'KX-TDE600',
  'KX-TDE620',
  'KX-NS500',
  'KX-NS1000',
};
double widthOfCustoms(BuildContext context) => MediaQuery.of(context).size.width - KHorizontalPadding * 2;
const double KHorizontalPadding = 15;
BorderRadius KRadius = BorderRadius.circular(10);
const double heightOfCustoms = 55;
const Map<String, IconData> categoryIcons = {
  'Air Conditioning': Icons.ac_unit,
  'Automation Control Components': Icons.settings,
  'Blu-ray Disc': Icons.disc_full_outlined,
  'Broadcast & Professional Video': Icons.live_tv,
  'Business Communication Systems': Icons.call,
  'Business Fax': Icons.print,
  'Capacitors': Icons.battery_full,
  'Document Scanner': Icons.scanner,
  'Electronic Materials': Icons.electrical_services,
  'Electronic Whiteboard': Icons.picture_in_picture,
  'FA Sensors & Components': Icons.settings_input_component,
  'Factory Automation, Welding Machines': Icons.build,
  'HD Visual Communications System': Icons.tv,
  'Housing Equipment Devices': Icons.home,
  'Inductors (Coils)': Icons.timeline,
  'Industrial Batteries': Icons.battery_charging_full,
  'IP Phone': Icons.phone_iphone,
  'Lighting': Icons.lightbulb,
  'Media Entertainment': Icons.movie,
  'Mobile PC / Tablet': Icons.laptop,
  'Motors, Compressors': Icons.electrical_services_rounded,
  'Multi-Function Laser': Icons.print_rounded,
  'Optical Disc Archive Solution': Icons.disc_full,
  // 'Photovoltaic': Icons.solar_panel,
  'POS Workstation': Icons.point_of_sale,
  'Professional Displays': Icons.desktop_windows,
  'Projector': Icons.video_label,
  'Resistors': Icons.swap_horiz,
  'SD Memory Card': Icons.sd_card,
  'Security': Icons.security,
  // 'Semiconductors': Icons.chip,
  'Sensors': Icons.waves,
  'Silky Fine Mist Systems': Icons.cloud,
  'Thermal Management Solutions': Icons.ac_unit_rounded,
  'Ventilating Fan': Icons.air,
  'Visual Sort Assist': Icons.sort_by_alpha,
};
const String KProductsBox = 'ProductModelBox';
const String KIsDarkBox = 'IsDarkBox';
