//
//  UCOtren_CordobaARabanales.h
//  UCOtren
//
//  Creado por Francisco Gómez Pino
//  Ideado por Gonzalo Toledano
//  Copyright (c) 2013 Francisco Gómez Pino. Todos los derechos reservados.
//

#import <UIKit/UIKit.h>

@interface UCOtren_CordobaARabanales : UIViewController

@property (nonatomic,strong) IBOutlet UILabel *horaSalidaCordobaARabanales;
@property (nonatomic,strong) IBOutlet UILabel *SombraSalidaCordobaARabanales;
@property (nonatomic,strong) IBOutlet UILabel *HorasRestantesSalidaCordobaARabanales;
@property (nonatomic,strong) IBOutlet UILabel *SombraHorasRestantesSalidaCordobaARabanales;
@property (nonatomic,strong) IBOutlet UILabel *MinutosRestantesSalidaCordobaARabanales;
@property (nonatomic,strong) IBOutlet UILabel *SombraMinutosRestantesSalidaCordobaARabanales;
@property (nonatomic,strong) IBOutlet UILabel *horaProximaSalidaCordobaARabanales;
@property (nonatomic,strong) IBOutlet UILabel *SombraProximaSalidaCordobaARabanales;

@property (assign) int segundosSalida;
@property (assign) int segundosRestantesSalida;
@property (assign) int segundosProximaSalida;
@property (assign) int alternador;
@property (assign) int errorMemoria;

-(IBAction)informacion:(id)sender;

@end
