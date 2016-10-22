//
//  UCOtren_Horarios.h
//  UCOtren
//
//  Creado por Francisco Gómez Pino
//  Ideado por Gonzalo Toledano
//  Copyright (c) 2013 Francisco Gómez Pino. Todos los derechos reservados.
//

#import <UIKit/UIKit.h>
#import "UCOtren_HorariosCordobaARabanales.h"
#import "UCOtren_HorariosRabanalesACordoba.h"


@interface UCOtren_Horarios : UIViewController <UITableViewDataSource>
{
    UCOtren_HorariosCordobaARabanales *controllerSalidasCordobaARabanales;
    UCOtren_HorariosRabanalesACordoba *controllerSalidasRabanalesACordoba;
    IBOutlet UITableView *tablaSalidasCordobaARabanales;
    IBOutlet UITableView *tablaSalidasRabanalesACordoba;
    IBOutlet UIScrollView *Scroller;
    IBOutlet UIScrollView *Scroller_iPad;
}

@property (nonatomic,retain) IBOutlet UITableView *tablaSalidasCordobaARabanales;
@property (nonatomic,retain) IBOutlet UITableView *tablaSalidasRabanalesACordoba;
@property (nonatomic,retain) IBOutlet UIScrollView *Scroller;
@property (nonatomic,retain) IBOutlet UIScrollView *Scroller_iPad;

-(IBAction)volverAtras:(id)sender;

@end