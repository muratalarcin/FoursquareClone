//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Murat Alarcin on 4.03.2025.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsPlaceNameLabel: UILabel!
    @IBOutlet weak var detailsPlaceTypeLabel: UILabel!
    @IBOutlet weak var detailsPlaceAtmosphereLabel: UILabel!
    @IBOutlet weak var detailsMapView: MKMapView!
    
    var choosenPlaceId = ""
    var choosenLatitude = Double()
    var choosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getDataParse()
        detailsMapView.delegate = self
        
        
    }
    
    
    func getDataParse() {
        
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: choosenPlaceId)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                
            } else {
                if objects != nil {
                    if objects!.count > 0 {
                        let choosenPlaceObject = objects![0]
                        if let placeName = choosenPlaceObject.object(forKey: "name") as? String {
                            self.detailsPlaceNameLabel.text = placeName
                        }
                        
                        if let placeType = choosenPlaceObject.object(forKey: "type") as? String {
                            self.detailsPlaceTypeLabel.text = placeType
                        }
                        
                        if let placeAtmosphere = choosenPlaceObject.object(forKey: "atmosphere") as? String {
                            self.detailsPlaceAtmosphereLabel.text = placeAtmosphere
                        }
                        
                        if let placeLatitude = choosenPlaceObject.object(forKey: "latitude") as? String {
                            if let placeLatitudeDouble = Double(placeLatitude) {
                                self.choosenLatitude = placeLatitudeDouble
                            }
                        }
                        
                        if let placeLongitude = choosenPlaceObject.object(forKey: "longitude") as? String {
                            if let placeLongitudeDouble = Double(placeLongitude) {
                                self.choosenLongitude = placeLongitudeDouble
                            }
                        }
                        
                        if let imageData = choosenPlaceObject.object(forKey: "image") as? PFFileObject {
                            imageData.getDataInBackground { data, error in
                                if error == nil {
                                    if data != nil {
                                        self.detailsImageView.image = UIImage(data: data!)
                                    }
                                }
                            }
                        }
                        
                        // MAPS
                        
                        let location = CLLocationCoordinate2D(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
                        
                        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                        
                        let region = MKCoordinateRegion(center: location, span: span)
                        
                        self.detailsMapView.setRegion(region, animated: true)
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location
                        annotation.title = self.detailsPlaceNameLabel.text!
                        annotation.subtitle = self.detailsPlaceTypeLabel.text!
                        self.detailsMapView.addAnnotation(annotation)
                        
                        
                    }
                }
            }
        }
    }
    //pin oluşturmaca
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.choosenLongitude != 0.0 && self.choosenLatitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.choosenLatitude, longitude: self.choosenLongitude)

            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                if let firstPlacemark = placemarks?.first {
                    let mkPlaceMark = MKPlacemark(placemark: firstPlacemark)
                    let mapItem = MKMapItem(placemark: mkPlaceMark)
                    mapItem.name = self.detailsPlaceNameLabel.text
                    
                    let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                    
                    mapItem.openInMaps(launchOptions: launchOptions)
                } else {
                    print("Hata: Geçerli bir konum bulunamadı.")
                }
            }
        } else {
            print("Hata: Geçersiz koordinatlar.")
        }
    }

    //haritalar app açtırmaca
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        let reuseId = "pin"

        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView

        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
        }

        return pinView
    }

}
