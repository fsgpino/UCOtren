//
//  UCOtren_Horarios.m
//  UCOtren
//
//  Creado por Francisco Gómez Pino
//  Ideado por Gonzalo Toledano
//  Copyright (c) 2013 Francisco Gómez Pino. Todos los derechos reservados.
//

#import "UCOtren_Horarios.h"

@interface UCOtren_Horarios ()

@end

@implementation UCOtren_Horarios

@synthesize tablaSalidasCordobaARabanales;
@synthesize tablaSalidasRabanalesACordoba;
@synthesize Scroller;
@synthesize Scroller_iPad;

#pragma mark - View lifecycle

//FUNCION: viewDidLoad (Se activa al arranque del view)
- (void)viewDidLoad
{
    //Arranque por defecto de la función viewDidLoad
    [super viewDidLoad];
    
    NSArray *pathOfDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [pathOfDirectory objectAtIndex:0];
    NSString *fileNameCR = [NSString stringWithFormat:@"tramo-CR.plist"];
    NSString *filePathCR = [documentDirectory stringByAppendingPathComponent:fileNameCR];
    NSString *fileNameRC = [NSString stringWithFormat:@"tramo-RC.plist"];
    NSString *filePathRC = [documentDirectory stringByAppendingPathComponent:fileNameRC];
    
    if (([[NSFileManager defaultManager] fileExistsAtPath:filePathRC])&&([[NSFileManager defaultManager] fileExistsAtPath:filePathCR]))
    {
        //Se realiza la configuración adicional después de cargar la vista
        if (controllerSalidasCordobaARabanales == nil) {
            controllerSalidasCordobaARabanales = [[UCOtren_HorariosCordobaARabanales alloc] init];
        }
        if (controllerSalidasRabanalesACordoba == nil) {
            controllerSalidasRabanalesACordoba = [[UCOtren_HorariosRabanalesACordoba alloc] init];
        }
        [tablaSalidasCordobaARabanales setDataSource:controllerSalidasCordobaARabanales];
        [tablaSalidasRabanalesACordoba setDataSource:controllerSalidasRabanalesACordoba];
	
        [tablaSalidasCordobaARabanales setDelegate:controllerSalidasCordobaARabanales];
        [tablaSalidasRabanalesACordoba setDelegate:controllerSalidasRabanalesACordoba];
        controllerSalidasCordobaARabanales.view = controllerSalidasCordobaARabanales.tableView;
        controllerSalidasRabanalesACordoba.view = controllerSalidasRabanalesACordoba.tableView;
    
        [Scroller setScrollEnabled:YES];
        [Scroller setContentSize:CGSizeMake(320, 858)];
        [Scroller_iPad setScrollEnabled:YES];
        [Scroller_iPad setContentSize:CGSizeMake(540, 858)];
    }else{
        UIAlertView *alertHAN = [[UIAlertView alloc] initWithTitle:@"Información"
                                                           message:@"No hay horarios descargados."
                                                          delegate:nil
                                                 cancelButtonTitle:@"Cerrar"
                                                 otherButtonTitles:nil];
        [alertHAN show];
    }
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

//FUNCION: didReceiveMemoryWarning (Se activa por aviso de sobrecarga de memoria)
- (void)didReceiveMemoryWarning
{
    //Arranque por defecto de la función didReceiveMemoryWarning
    [super didReceiveMemoryWarning];
    //Se eliminan de todos los recursos que pueden ser recreados.
}

//FUNCION: volverAtras (Se activa llamada por un boton y cierra el view)
-(IBAction)volverAtras:(id)sender {
    //[self dismissModalViewControllerAnimated:YES]; // DEPRECATED in iOS 6
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
