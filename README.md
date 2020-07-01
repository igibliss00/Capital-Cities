# Capital Cities

An iOS app to demonstrate the use case of MKMapView, MKAnnotation, MKPinAnnotationView, and CLLocationCoordinate2D.  Project 16 from hackingwithswift.com.

<img src="https://github.com/igibliss00/Capital-Cities/blob/master/README_assets/1.png" width="400">

<img src="https://github.com/igibliss00/Capital-Cities/blob/master/README_assets/2.png" width="400">

## Features

### MKAnnotation

An object that adopts this protocol manages the data that you want to display on the map surface. It does not provide the visual representation displayed by the map. Instead, your map view's delegate provides the MKAnnotationView objects needed to display the content of your annotations. When you want to display content at a specific point on the map, add an annotation object to the map view. When the annotation's coordinate is visible on the map, the map view asks its delegate to provide an appropriate view to display any content associated with the annotation. You implement the mapView(_:viewFor:) method of the delegate to provide that view. 
An object that adopts this protocol must implement the coordinate property. The other methods of this protocol are optional. ([Source](https://developer.apple.com/documentation/mapkit/mkannotation))

### Annotation Object vs Annotation View

Annotation object is a class or a struct that conforms to the MKAnnotation protocol.  This is a group of information that contains everything about each annotation.  In the current project’s case, it would be the Capital class:

```
class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
```

The annotation view is an instance of the MKAnnotationView class that’s responsible for the presentation of annotation objects on the screen.  This would be equivalent to a cell in a table view or a collection view.  The viewFor method is called to create the view for each annotation:

```
func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard annotation is Capital else { return nil }
    let identifier = "Capital"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
    
    return annotationView
}
```

The annotation view can be null in which case the iOS will just display the standard annotation view on the map. 

### calloutAccessoryControlTapped

When the annotation view is tapped, the following method is called to execute any custom actions:

```
func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    guard let capital = view.annotation as? Capital else { return }
    let placeName = capital.title
    let placeInfo = capital.info

    let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(ac, animated: true)
}
```
