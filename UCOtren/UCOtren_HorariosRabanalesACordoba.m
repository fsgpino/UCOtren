//
//  UCOtren_HorariosRabanalesACordoba.m
//  UCOtren
//
//  Creado por Francisco Gómez Pino
//  Ideado por Gonzalo Toledano
//  Copyright (c) 2013 Francisco Gómez Pino. Todos los derechos reservados.
//

#import "UCOtren_HorariosRabanalesACordoba.h"


@implementation UCOtren_HorariosRabanalesACordoba

@synthesize origenSalidasRabanalesACordoba;
@synthesize horaSiguiente;

#pragma mark - View lifecycle

-(void) viewDidLoad
{
    //Declaración de los directorios de trabajo donde se almacenan los horarios
    NSArray *pathOfDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [pathOfDirectory objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"tramo-RC.plist"];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    
    //Declaración del horario de cada una de las salidas, el ultimo valor del vector y de un contador auxiliar que se usa en la función
    NSArray *dataFile = [[NSArray alloc] initWithContentsOfFile:filePath];
    origenSalidasRabanalesACordoba = [[dataFile objectAtIndex:3] componentsSeparatedByString: @"|"];
    
    //Declaración del horario de cada una de las salidas, el ultimo valor del vector y de un contador auxiliar que se usa en la función
    NSUInteger ultimoValorHorario = ([origenSalidasRabanalesACordoba count] - 1);
    NSUInteger contadorAuxiliar = 0;
    
    //Declaración de un puntero que contiene un formateador de fecha, usado para convertir la hora actual en segundos
    NSDateFormatter *FormateadorFecha = [[NSDateFormatter alloc] init];
    
    //Se define en el formateador de fecha que se quiere devolver las horas y se guardan en la variable
    [FormateadorFecha setDateFormat:@"HH"];
    NSUInteger HorasActual = [[FormateadorFecha stringFromDate:[NSDate date]] intValue];
    
    //Se define en el formateador de fecha que se quiere devolver los minutos y se guardan en la variable
    [FormateadorFecha setDateFormat:@"mm"];
    NSUInteger MinutosActual = [[FormateadorFecha stringFromDate:[NSDate date]] intValue];
    
    //Se define en el formateador de fecha que se quiere devolver los segundos y se guardan en la variable
    [FormateadorFecha setDateFormat:@"ss"];
    NSUInteger SegundosActual = [[FormateadorFecha stringFromDate:[NSDate date]] intValue];
    
    //Se define en el formateador de fecha que se quiere devolver el día de la semana y se guarda en la variable
    [FormateadorFecha setDateFormat:@"e"];
    NSUInteger DiaSemanaActual = [[FormateadorFecha stringFromDate:[NSDate date]] intValue];
    
    //Se suma todo y se almacena en la variable
    NSUInteger TotalSegundosActual = HorasActual*3600+MinutosActual*60+SegundosActual;
    
    //Se verifica que el total de segundos no sea mayor que el ultimo de los horarios y no sea sabado o domingo
    if((TotalSegundosActual > [self StringASegundos:[origenSalidasRabanalesACordoba objectAtIndex:ultimoValorHorario]])||(DiaSemanaActual==6)||(DiaSemanaActual==7))
    {
        //Si se da el caso anterior, pues se empieza mostrando el horario del siguiente día
        contadorAuxiliar=0;
    }else{
        //Si no se da el caso anterior, pues se recorre el vector horario hasta que encontremos la salida inminente
        while(TotalSegundosActual > [self StringASegundos:[origenSalidasRabanalesACordoba objectAtIndex:contadorAuxiliar]])
        {
            contadorAuxiliar++;
        }
    }
    
    horaSiguiente = [self StringASegundos:[origenSalidasRabanalesACordoba objectAtIndex:contadorAuxiliar]];
    
    [super viewDidLoad];
}

//FUNCION: StringASegundos (Devuelve en segundos la hora pasada como parametro HH:MM -> S)
-(NSUInteger) StringASegundos: (NSString *) hora
{
    NSArray* HH_MM = [hora componentsSeparatedByString: @":"];
    
    NSUInteger Horas = [[HH_MM objectAtIndex:0] integerValue];
    NSUInteger Minutos = [[HH_MM objectAtIndex:1] integerValue];
    
    return ((Horas*3600)+(Minutos*60));
}

#pragma mark - TableView Data Source methods

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Rabanales";
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return [origenSalidasRabanalesACordoba count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [origenSalidasRabanalesACordoba objectAtIndex:indexPath.row];
    //cell.textLabel.textAlignment = UITextAlignmentCenter; // Deprecated in iOS 6
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    NSArray *datosSeparados = [cell.textLabel.text componentsSeparatedByString:@":"];
    
    NSUInteger segundosCelda = ([[datosSeparados objectAtIndex:0] intValue]*3600)+([[datosSeparados objectAtIndex:1] intValue]*60);
    
    if (horaSiguiente==segundosCelda)
    {
        cell.textLabel.textColor = [UIColor orangeColor];
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

@end
