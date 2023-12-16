//
//  ViewController.swift
//  Project16
//
//  Created by Антон Кашников on 16/12/2023.
//

import MapKit
import UIKit

final class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(
            title: "London",
            coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            info: "Home to the 2012 Summer Olympics."
        )
        let oslo = Capital(
            title: "Oslo",
            coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75),
            info: "Founded over a thousand years ago."
        )
        let paris = Capital(
            title: "Paris",
            coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508),
            info: "Often called the City of Light."
        )
        let rome = Capital(
            title: "Rome",
            coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5),
            info: "Has a whole country inside it."
        )
        let washington = Capital(
            title: "Washington DC",
            coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667),
            info: "Named after George himself."
        )
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
}

// MARK: - MKMapViewDelegate

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // If the annotation isn't from a capital city, it must return nil so iOS uses a default view.
        guard annotation is Capital else { return nil }
        
        // Define a reuse identifier. This is a string that will be used to ensure we reuse annotation views as much as possible.
        let identifier = "Capital"
        
        // Try to dequeue an annotation view from the map view's pool of unused views.
        var annotaionView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotaionView == nil {
            // If it isn't able to find a reusable view, create a new one using MKPinAnnotationView and sets its canShowCallout property to true. This triggers the popup with the city name.
            annotaionView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotaionView?.canShowCallout = true
            
            // Create a new UIButton using the built-in .detailDisclosure type. This is a small blue "i" symbol with a circle around it.
            annotaionView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            // If it can reuse a view, update that view to use a different annotation.
            annotaionView?.annotation = annotation
        }
        
        return annotaionView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let alertController = UIAlertController(title: capital.title, message: capital.info, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

