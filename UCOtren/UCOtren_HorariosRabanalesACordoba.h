//
//  UCOtren_HorariosRabanalesACordoba.h
//  UCOtren
//
//  Creado por Francisco Gómez Pino
//  Ideado por Gonzalo Toledano
//  Copyright (c) 2013 Francisco Gómez Pino. Todos los derechos reservados.
//

#import <Foundation/Foundation.h>


@interface UCOtren_HorariosRabanalesACordoba : UITableViewController <UITableViewDataSource, UITableViewDelegate>{
    NSArray *origenSalidasRabanalesACordoba;
    int horaSiguiente;
}

@property (nonatomic,retain) NSArray *origenSalidasRabanalesACordoba;
@property (assign) int horaSiguiente;

-(NSInteger) StringASegundos: (NSString *) hora;

@end