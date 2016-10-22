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
    NSArray *origenSalidasCordobaARabanales;
    int horaSiguiente;
}

@property (nonatomic,retain) NSArray *origenSalidasCordobaARabanales;
@property (assign) int horaSiguiente;

-(NSInteger) StringASegundos: (NSString *) hora;

@end