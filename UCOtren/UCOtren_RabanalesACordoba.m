//
//  UCOtren_RabanalesACordoba.m
//  UCOtren
//
//  Creado por Francisco Gómez Pino
//  Ideado por Gonzalo Toledano
//  Copyright (c) 2013 Francisco Gómez Pino. Todos los derechos reservados.
//

#import "UCOtren_RabanalesACordoba.h"

@interface UCOtren_RabanalesACordoba ()

@end

@implementation UCOtren_RabanalesACordoba

//Se relacionan las variables glovales con el entorno actual (labels)
@synthesize horaSalidaRabanalesACordoba;
@synthesize SombraSalidaRabanalesACordoba;
@synthesize HorasRestantesSalidaRabanalesACordoba;
@synthesize SombraHorasRestantesSalidaRabanalesACordoba;
@synthesize MinutosRestantesSalidaRabanalesACordoba;
@synthesize SombraMinutosRestantesSalidaRabanalesACordoba;
@synthesize horaProximaSalidaRabanalesACordoba;
@synthesize SombraProximaSalidaRabanalesACordoba;

//Se relacionan las variables globales con el entorno actual (enteros)
@synthesize segundosSalida;
@synthesize segundosRestantesSalida;
@synthesize segundosProximaSalida;
@synthesize alternador;
@synthesize errorMemoria;

#pragma mark - View lifecycle

//FUNCION: viewDidLoad (Se activa al arranque del view)
- (void)viewDidLoad
{
    //Arranque por defecto de la función viewDidLoad
    [super viewDidLoad];
    //Se realiza la configuración adicional después de cargar la vista
    
    //Declaración del puntero NSTimer (Contendra la dirección del contador)
    NSTimer *ContadorDeTiempo;
    
    //Declaración del puntero cadena (Contiene el modelo de dispositivo)
    NSString *deviceType = [UIDevice currentDevice].model;
    
    //Establece las fuentes
    NSLog(@" * Estableciendo fuentes (Rabanales a Córdoba)...");
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //Tamaño de fuentes en caso de ser un iPhone
        horaSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:75];
        SombraSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:75];
        HorasRestantesSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:75];
        SombraHorasRestantesSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:75];
        MinutosRestantesSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:75];
        SombraMinutosRestantesSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:75];
        horaProximaSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:50];
        SombraProximaSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:50];
    }
    else if([deviceType isEqualToString:@"iPad"]) {
        //Tamaño de fuentes en caso de ser un iPad
        horaSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:180];
        SombraSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:180];
        HorasRestantesSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:180];
        SombraHorasRestantesSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:180];
        MinutosRestantesSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:180];
        SombraMinutosRestantesSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:180];
        horaProximaSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:120];
        SombraProximaSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:120];
    }
    else {
        //Tamaño de fuentes en caso de ser un iPod touch, simuladores u otros
        horaSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:75];
        SombraSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:75];
        HorasRestantesSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:75];
        SombraHorasRestantesSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:75];
        MinutosRestantesSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:75];
        SombraMinutosRestantesSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:75];
        horaProximaSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:50];
        SombraProximaSalidaRabanalesACordoba.font = [UIFont fontWithName:@"Digital-7" size:50];
    }
    
    
    
    //Se establece el alternador y errorMemoria a 0
    alternador = 0;
    errorMemoria = 0;
    
    //Arranca la función encargada del reloj antes de esperar el primer segundo
    NSLog(@" !* Arrancando la función relojEnCurso (Rabanales a Córdoba) por primera vez\n");
    [self relojEnCurso:nil];
    
    //Arranca la funcion encargada del reloj ejecutandose cada segundo, esperando un primer segundo
    NSLog(@" !* Arrancando la función relojEnCurso (Rabanales a Córdoba) con el temporizador\n");
    ContadorDeTiempo = [NSTimer scheduledTimerWithTimeInterval:1
                                                        target:self
                                                      selector:@selector(relojEnCurso:)
                                                      userInfo:nil
                                                       repeats:YES];
}

//FUNCION: didReceiveMemoryWarning (Se activa por aviso de sobrecarga de memoria)
- (void)didReceiveMemoryWarning
{
    //Arranque por defecto de la función didReceiveMemoryWarning
    [super didReceiveMemoryWarning];
    //Se eliminan de todos los recursos que pueden ser recreados.
    
    NSLog(@"\n !* Error de memoria, abortando ejecución reloj Rabanales a Córdoba\n\n");
    
    //Si ocurre un error de memoria se establece errorMemoria a 1 para abortar la ejecución del contador
    errorMemoria = 1;
}

-(IBAction)informacion:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Acerca de"
                                                    message:@"Idea original: Gonzalo Toledano\nAutor: Francisco Gómez Pino\nE-Mail: i12gopif@uco.es\nTwitter: @fsgpino"
                                                   delegate:nil
                                          cancelButtonTitle:@"Cerrar"
                                          otherButtonTitles:nil];
    [alert show];
}

//FUNCION: relojEnCurso (función de tiempo, realiza el calculo entre el tiempo actual y los tiempos del vector)
- (void)relojEnCurso:(NSTimer *)timer
{
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
        segundosSalida=horario[0];
        segundosRestantesSalida = (86400 - TotalSegundosActual + 60) + horario[0];
        segundosProximaSalida=horario[1];
        
        if (DiaSemanaActual==5) //Si es viernes ultima hora, el proximo tren es el lunes (salta 2 días)
            segundosRestantesSalida = segundosRestantesSalida + (86400*2);
        if (DiaSemanaActual==6) //Si es sabado ultima hora, el proximo tren es el lunes (salta 1 día)
            segundosRestantesSalida = segundosRestantesSalida + 86400;
        
    }else{
        //Si no se da el caso anterior, pues se recorre el vector horario hasta que encontremos la salida inminente
        while(TotalSegundosActual > horario[contadorAuxiliar])
        {
            contadorAuxiliar++;
        }
        segundosSalida=horario[contadorAuxiliar];
        segundosRestantesSalida = horario[contadorAuxiliar] - TotalSegundosActual + 60;
        if (horario[contadorAuxiliar] == ultimoValorHorario)
            segundosProximaSalida=horario[0];
        else
            segundosProximaSalida=horario[contadorAuxiliar+1];
    }
    
    //Se muestra un resumen de los datos en el Log
     NSLog(@" * Reloj de Rabanales a Córdoba: Segundos salida inminente: %d, Segundos restantes salida inminente: %d, Segundos Próxima salida: %d, Segundos Actual: %d\n", segundosSalida, segundosRestantesSalida, segundosProximaSalida, TotalSegundosActual);
    
    //Se llama a una función encargada de mostrar los resultados por pantalla
    [self actualizarDatosEnPantalla];
    
    //En caso de error de memoria se invalida el timer
    if (errorMemoria==1)
        [timer invalidate];
}

//FUNCION: actualizarDatosEnPantalla (Muestra las variables globales por pantalla)
- (void)actualizarDatosEnPantalla
{
    //Se muestra la hora de la salida inminente y proxima, alternandose los : cada segundo que transcurre
    if (alternador==0)
    {
        self.horaSalidaRabanalesACordoba.text =[NSString stringWithFormat:@"%02d %02d",segundosSalida/3600,(segundosSalida/60)%60];
        self.horaProximaSalidaRabanalesACordoba.text =[NSString stringWithFormat:@"%02d %02d",segundosProximaSalida/3600,(segundosProximaSalida/60)%60];
        alternador=1;
    }else{
        self.horaSalidaRabanalesACordoba.text =[NSString stringWithFormat:@"%02d:%02d",segundosSalida/3600,(segundosSalida/60)%60];
        self.horaProximaSalidaRabanalesACordoba.text =[NSString stringWithFormat:@"%02d:%02d",segundosProximaSalida/3600,(segundosProximaSalida/60)%60];
        alternador=0;
    }
    
    //Se muestra el tiempo restante para la salida inminente
    self.HorasRestantesSalidaRabanalesACordoba.text =[NSString stringWithFormat:@"%02d",segundosRestantesSalida/3600];
    self.MinutosRestantesSalidaRabanalesACordoba.text =[NSString stringWithFormat:@"%02d",(segundosRestantesSalida/60)%60];
}

@end
