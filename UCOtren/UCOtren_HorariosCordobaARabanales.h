//
//  UCOtren_HorariosCordobaARabanales.h
//  UCOtren
//
//  Creado por Francisco Gómez Pino
//  Ideado por Gonzalo Toledano
//  Copyright (c) 2013 Francisco Gómez Pino. Todos los derechos reservados.
//

#import <Foundation/Foundation.h>


@interface UCOtren_HorariosCordobaARabanales : UITableViewController <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *origenSalidasCordobaARabanales;
    int horaSiguiente;
}

@property (nonatomic,retain) NSMutableArray *origenSalidasCordobaARabanales;
@property (assign) int horaSiguiente;

@end