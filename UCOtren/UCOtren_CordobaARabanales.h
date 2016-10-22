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
@property (nonatomic,strong) IBOutlet UILabel *FechaActualizacion;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *bacercade;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *bhorario;

@property (assign) NSUInteger segundosSalida;
@property (assign) NSUInteger segundosRestantesSalida;
@property (assign) NSUInteger segundosProximaSalida;
@property (assign) NSUInteger alternador;
@property (assign) NSUInteger errorMemoria;

- (void)inicioDelView;
- (IBAction)informacion:(id)sender;
- (IBAction)recargarHorario:(id)sender;
- (void)relojEnCurso:(NSTimer *)timer;
- (void)actualizarDatosEnPantalla;
- (NSUInteger) StringASegundos: (NSString *) hora;
- (NSUInteger) actualizaHorario;
@end
