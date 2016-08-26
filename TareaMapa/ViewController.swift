//
//  ViewController.swift
//  TareaMapa
//
//  Created by XrgerX on 13/08/16.
//  Copyright © 2016 XrgerX. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    private let manejador = CLLocationManager()
    private var distanciaRecorrida: Double = 0.0
    private var localizacionActual = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manejador.delegate = self
        manejador.desiredAccuracy = kCLLocationAccuracyBest
        manejador.requestWhenInUseAuthorization()
        manejador.distanceFilter = 50.0
        mapa.zoomEnabled = true
        mapa.setCenterCoordinate(localizacionActual, animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            manejador.startUpdatingLocation()
            mapa.showsUserLocation = true
        } else {
            manejador.stopUpdatingLocation()
            mapa.showsUserLocation = false
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var puntoactual = CLLocationCoordinate2D()
         puntoactual.latitude = manager.location!.coordinate.latitude
         puntoactual.longitude = manager.location!.coordinate.longitude
         distanciaRecorrida = distanciaRecorrida + 50.0
         let pinactual = MKPointAnnotation()
         pinactual.title = "Lat.: \(Float(puntoactual.latitude)) , Long: \(Float(puntoactual.longitude))"
         pinactual.subtitle = "\(distanciaRecorrida)"
         pinactual.coordinate = puntoactual
         mapa.addAnnotation(pinactual)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let alerta = UIAlertController(title: "Error", message: "error \(error.code)", preferredStyle: .Alert)
        let accionOk = UIAlertAction(title: "OK", style: .Default, handler: {
            accion in
            //..
        })
        
        alerta.addAction(accionOk)
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    @IBAction func mapaNormal() {
        mapa.mapType = MKMapType.Standard
    }
    
    @IBAction func mapaSatelital() {
        mapa.mapType = MKMapType.Satellite
    }
    
    @IBAction func mapaHibrido() {
        mapa.mapType = MKMapType.Hybrid
    }

}

