//
//  UCOtren_HorariosCordobaARabanales.m
//  UCOtren
//
//  Creado por Francisco Gómez Pino
//  Ideado por Gonzalo Toledano
//  Copyright (c) 2013 Francisco Gómez Pino. Todos los derechos reservados.
//

#import "UCOtren_HorariosCordobaARabanales.h"


@implementation UCOtren_HorariosCordobaARabanales

@synthesize origenSalidasCordobaARabanales;
@synthesize horaSiguiente;

#pragma mark - View lifecycle

-(void) viewDidLoad
{
	origenSalidasCordobaARabanales = [[NSMutableArray alloc] initWithObjects:@"7:20",@"7:40",@"8:15",@"8:45",@"9:10",@"10:05",@"10:45",@"11:50",@"13:00",@"14:00",@"14:30",@"15:00",@"15:45",@"16:45",@"17:45",@"19:05",@"19:35",@"20:20",@"21:20",nil];
    
    //Declaración del horario de cada una de las salidas, el ultimo valor del vector y de un contador auxiliar que se usa en la función
    int horario[] = {26400, 27600, 29700, 31500, 33000, 36300, 38700, 42600, 46800, 50400, 52200, 54000, 56700, 60300, 63900, 68700, 70500, 73200, 76800};
    int ultimoValorHorario = 76800;
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
    
    horaSiguiente=horario[contadorAuxiliar];
}

#pragma mark - TableView Data Source methods

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Córdoba";
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return [origenSalidasCordobaARabanales count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [origenSalidasCordobaARabanales objectAtIndex:indexPath.row];
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
