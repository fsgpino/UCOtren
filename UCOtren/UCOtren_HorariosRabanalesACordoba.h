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
    NSMutableArray *origenSalidasRabanalesACordoba;
    int horaSiguiente;
}

@property (nonatomic,retain) NSMutableArray *origenSalidasRabanalesACordoba;
@property (assign) int horaSiguiente;

@end