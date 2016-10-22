//
//  UCOtren_RabanalesACordoba.h
//  UCOtren
//
//  Creado por Francisco Gómez Pino
//  Ideado por Gonzalo Toledano
//  Copyright (c) 2013 Francisco Gómez Pino. Todos los derechos reservados.
//

#import <UIKit/UIKit.h>
#import <pthread.h>

@interface UCOtren_RabanalesACordoba : UIViewController

@property (nonatomic,strong) IBOutlet UILabel *horaSalidaRabanalesACordoba;
@property (nonatomic,strong) IBOutlet UILabel *SombraSalidaRabanalesACordoba;
@property (nonatomic,strong) IBOutlet UILabel *HorasRestantesSalidaRabanalesACordoba;
@property (nonatomic,strong) IBOutlet UILabel *SombraHorasRestantesSalidaRabanalesACordoba;
@property (nonatomic,strong) IBOutlet UILabel *MinutosRestantesSalidaRabanalesACordoba;
@property (nonatomic,strong) IBOutlet UILabel *SombraMinutosRestantesSalidaRabanalesACordoba;
@property (nonatomic,strong) IBOutlet UILabel *horaProximaSalidaRabanalesACordoba;
@property (nonatomic,strong) IBOutlet UILabel *SombraProximaSalidaRabanalesACordoba;
@property (nonatomic,strong) IBOutlet UILabel *FechaActualizacion;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *bacercade;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *bhorario;

@property (assign) int segundosSalida;
@property (assign) int segundosRestantesSalida;
@property (assign) int segundosProximaSalida;
@property (assign) int alternador;
@property (assign) int errorMemoria;

- (void)inicioDelView;
- (IBAction)informacion:(id)sender;
- (IBAction)recargarHorario:(id)sender;
- (void)relojEnCurso:(NSTimer *)timer;
- (void)actualizarDatosEnPantalla;
- (NSInteger) StringASegundos: (NSString *) hora;
- (NSInteger) actualizaHorario;

@end
