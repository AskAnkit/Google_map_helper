 handleTap(LatLng point) async{
    try {
      if (mapLoading.isFalse) {
        tapped.value = true;
        markers.clear();
        markerId = MarkerId("1");
        markers[markerId] = Marker(
          markerId: MarkerId(point.toString()),
          position: point,
        );

        mapController.animateCamera(
            CameraUpdate.newCameraPosition(CameraPosition(
              target: point,
              zoom: 12,
            )));

        lat = point.latitude;
        lng = point.longitude;
        SOURCE_LOCATION = LatLng(lat!, lng!);
        if (lat != null && lng != null) {
          List<Placemark> placeMarks = await placemarkFromCoordinates(lat!, lng!);
          latitude = lat!;
          longitude = lng!;
          var placeMark = placeMarks.first;
          String? name = placeMark.name;
          String? street = placeMark.street;
          String? subLocality = placeMark.subLocality;
          String? locality = placeMark.locality;
          String? administrativeArea = placeMark.administrativeArea;
          String? postalCode = placeMark.postalCode;
          String? country = placeMark.country;
          String address = "$name, $street,  $subLocality, $locality, $administrativeArea $postalCode, $country";
          locationController.text = address;

        } else {
          return null;
        }
        tapped.value = false;
      }
    }
    catch(e){
      print(e.toString());
    }
  }
