//
//  ViewController.swift
//  Project16
//
//  Created by jc on 2020-06-30.
//  Copyright © 2020 J. All rights reserved.
//
import MapKit
import UIKit
import WebKit

class ViewController: UIViewController, MKMapViewDelegate, WKNavigationDelegate {

    @IBOutlet var mapView: MKMapView!
    var webView: WKWebView!
    
//    override func loadView() {
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view = webView
//    }
    
    override func viewDidLoad() {
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 236508), info: "Often called the City of Light")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.8895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(changeMapType))
    }
    
    @objc func changeMapType() {
        let ac = UIAlertController(title: "Change Map Type", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: { [weak self] (_) in
            self?.mapView.mapType = .standard
        }))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { [weak self] (_) in
            self?.mapView.mapType = .satellite
        }))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { [weak self] (_) in
            self?.mapView.mapType = .hybrid
        }))
        
        present(ac, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        let identifier = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            annotationView?.pinTintColor = .green
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
//        let placeInfo = capital.info

//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(ac, animated: true)
        if let placeName = capital.title {
            if let url = URL(string: "http://en.wikipedia.org/wiki/" + placeName) {
                webView.load(URLRequest(url: url))
            } else {
                print("website loading failed")
            }
        } else {
            print("place name not found")
        }
    }
    
}

