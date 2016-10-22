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
    origenSalidasRabanalesACordoba = [[NSMutableArray alloc] initWithObjects:@"7:30",@"7:50",@"8:25",@"8:55",@"9:20",@"10:15",@"11:15",@"12:15",@"13:15",@"14:15",@"14:40",@"15:10",@"15:55",@"16:55",@"17:55",@"19:15",@"19:45",@"20:30",@"21:30",nil];
    
    //Declaración del horario de cada una de las salidas, el ultimo valor del vector y de un contador auxiliar que se usa en la función
    int horario[] = {27000, 28200, 30300, 32100, 33600, 36900, 40500, 44100, 47700, 51300, 52800, 54600, 57300, 60900, 64500, 69300, 71100, 73800, 77400};
    int ultimoValorHorario = 77400;
    int contadorAuxiliar = 0;
    
    //Declaración de un puntero que contiene un formateador de fecha, usado para convertir la hora actual en segundos
    NSDateFormatter *FormateadorFecha = [[NSDateFormatter alloc] init];
    
    //Se define en el formateador de fecha que se quiere devolver las horas y se guardan en la variable
    [FormateadorFecha setDateFormat:@"HH"];
    int HorasActual = [[FormateadorFecha stringFromDate:[NSDate date]] intValue];
    
    //Se define en el formateador de fecha que se quiere devolver los minutos y se guardan en la variable
    [FormateadorFecha setDateFormat:@"mm"];
    int MinutosActual = [[FormateadorFecha stringFromDate:[NSDate date]] intValue];
    
    //Se define en el formateador de fecha que se quiere devolver los segundos y se guardan en la variable
    [FormateadorFecha setDateFormat:@"ss"];
    int SegundosActual = [[FormateadorFecha stringFromDate:[NSDate date]] intValue];
    
    //Se define en el formateador de fecha que se quiere devolver el día de la semana y se guarda en la variable
    [FormateadorFecha setDateFormat:@"e"];
    int DiaSemanaActual = [[FormateadorFecha stringFromDate:[NSDate date]] intValue];
    
    //Se suma todo y se almacena en la variable
    int TotalSegundosActual = HorasActual*3600+MinutosActual*60+SegundosActual;
    
    //Se verifica que el total de segundos no sea mayor que el ultimo de los horarios y no sea sabado o domingo
    if((TotalSegundosActual > ultimoValorHorario)||(DiaSemanaActual==6)||(DiaSemanaActual==7))
    {
        //Si se da el caso anterior, pues se empieza mostrando el horario del siguiente día
        contadorAuxiliar=0;
    }else{
        //Si no se da el caso anterior, pues se recorre el vector horario hasta que encontremos la salida inminente
        while(TotalSegundosActual > horario[contadorAuxiliar])
        {
            contadorAuxiliar++;
        }
    }
    
    horaSiguiente = horario[contadorAuxiliar];
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
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    
    NSArray *datosSeparados = [cell.textLabel.text componentsSeparatedByString:@":"];
    
    int segundosCelda = ([[datosSeparados objectAtIndex:0] intValue]*3600)+([[datosSeparados objectAtIndex:1] intValue]*60);
    
    if (horaSiguiente==segundosCelda)
    {
        cell.textLabel.textColor = [UIColor orangeColor];
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

@end
