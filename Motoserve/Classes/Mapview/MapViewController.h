//
//  MapViewController.h
//  GMapSample
//
//  Created by VictorSebastian on 27/07/18.
//  Copyright © 2018 Thiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>


@interface MapViewController : UIViewController<GMSMapViewDelegate>

{
    GMSMarker *driverMarker;
}
@property (strong, nonatomic) NSMutableArray *CoordinateArr;
@property (strong, nonatomic) GMSMapView *mapView;
@property CLLocationCoordinate2D oldCoordinate;
@property (weak, nonatomic) NSTimer *timer;
@property (strong,nonatomic)NSString * latStr,*lonStr,*serviceprovidername;
@property NSInteger counter;



@end
