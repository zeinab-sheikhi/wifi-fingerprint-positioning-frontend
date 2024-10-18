# WiFi Positioning Application

This project involves a Flutter frontend for a WiFi positioning application. It utilizes various libraries and technologies to create an intuitive user interface for collecting and processing WiFi data. The app facilitates both online and offline phases for efficient data management.

![App Screenshot 1](path/to/image1.png)
![App Screenshot 2](path/to/image2.png)
![App Screenshot 3](path/to/image3.png)

## Project Structure

- `api/`
  - `api.dart`
  - `api_offline_phase.dart`
  - `api_online_phase.dart`
  - `api_result.dart`
  
- `models/`
  - `point.dart`
  
- `utils/`
  - `api_utils.dart`
  - `assets_urls.dart`
  - `color_utils.dart`
  - `helper.dart`
  - `location_service.dart`
  - `preference_util.dart`
  - `string_utils.dart`

- `views/`
  - `help/`
    - `help_screen.dart`
  
  - `home/`
    - `home_screen.dart`
  
  - `offline_phase/`
    - `circular_timer.dart`
    - `coordinate_text_field.dart`
    - `data_collection_content.dart`
    - `data_collection_dialog.dart`
    - `minus_button.dart`
    - `offline_phase_screen.dart`
    - `plus_button.dart`
  
  - `online_phase/`
    - `map_marker_container.dart`
    - `online_phase_screen.dart`
  
  - `settings/`
    - `offline_phase_tile.dart`
    - `server_tile.dart`
    - `settings_screen.dart`
    - `slider.dart`
    - `wifi_tile.dart`
  
  - `splash/`
    - `splash_screen.dart`
  
  - `widgets/`
    - `shapes/`
      - `curve_shape.dart`
      - `hexagon_shape.dart`
      - `pentagon_shape.dart`
    
    - `floor_map.dart`
    - `map_marker.dart`
    - `my_button.dart`
    - `my_expansion_tile.dart`
    - `my_icons.dart`
    - `my_list_tile.dart`
    - `my_snack_bar.dart`
    - `my_text_field.dart`
    - `my_tile_icon.dart`
  
  - `wifi-scanner/`
    - `level_indicator.dart`
    - `wifi_card.dart`
    - `wifi_info_dialog.dart`
    - `wifi_screen.dart`
  
- `main.dart`
