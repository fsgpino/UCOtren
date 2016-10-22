//
//  UCOtren_CordobaARabanales.m
//  UCOtren
//
//  Creado por Francisco Gómez Pino
//  Ideado por Gonzalo Toledano
//  Copyright (c) 2013 Francisco Gómez Pino. Todos los derechos reservados.
//

#import "UCOtren_CordobaARabanales.h"

@interface UCOtren_CordobaARabanales ()

@end

@implementation UCOtren_CordobaARabanales

//Se relacionan las variables glovales con el entorno actual (labels)
@synthesize horaSalidaCordobaARabanales;
@synthesize SombraSalidaCordobaARabanales;
@synthesize HorasRestantesSalidaCordobaARabanales;
@synthesize SombraHorasRestantesSalidaCordobaARabanales;
@synthesize MinutosRestantesSalidaCordobaARabanales;
@synthesize SombraMinutosRestantesSalidaCordobaARabanales;
@synthesize horaProximaSalidaCordobaARabanales;
@synthesize SombraProximaSalidaCordobaARabanales;

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
    NSLog(@" * Estableciendo fuentes (Córdoba a Rabanales)...");
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //Tamaño de fuentes en caso de ser un iPhone
        horaSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:75];
        SombraSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:75];
        HorasRestantesSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:75];
        SombraHorasRestantesSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:75];
        MinutosRestantesSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:75];
        SombraMinutosRestantesSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:75];
        horaProximaSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:50];
        SombraProximaSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:50];
    }
    else if([deviceType isEqualToString:@"iPad"]) {
        //Tamaño de fuentes en caso de ser un iPad
        horaSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:180];
        SombraSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:180];
        HorasRestantesSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:180];
        SombraHorasRestantesSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:180];
        MinutosRestantesSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:180];
        SombraMinutosRestantesSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:180];
        horaProximaSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:120];
        SombraProximaSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:120];
    }
    else {
        //Tamaño de fuentes en caso de ser un iPod touch, simuladores u otros
        horaSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:75];
        SombraSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:75];
        HorasRestantesSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:75];
        SombraHorasRestantesSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:75];
        MinutosRestantesSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:75];
        SombraMinutosRestantesSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:75];
        horaProximaSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:50];
        SombraProximaSalidaCordobaARabanales.font = [UIFont fontWithName:@"Digital-7" size:50];
    }
    
    //Se establece el alternador y errorMemoria a 0
    alternador = 0;
    errorMemoria = 0;
    
    //Arranca la función encargada del reloj antes de esperar el primer segundo
    NSLog(@" !* Arrancando la función relojEnCurso (Córdoba a Rabanales) por primera vez\n");
    [self relojEnCurso:nil];
    
    //Arranca la funcion encargada del reloj ejecutandose cada segundo, esperando un primer segundo
    NSLog(@" !* Arrancando la función relojEnCurso (Córdoba a Rabanales) con el temporizador\n");
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
    
    NSLog(@"\n !* Error de memoria, abortando ejecución reloj Cordoba a Rabanales\n\n");
    
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
    NSLog(@" * Reloj de Córdoba a Rabanales: Segundos salida inminente: %d, Segundos restantes salida inminente: %d, Segundos Próxima salida: %d, Segundos Actual: %d\n", segundosSalida, segundosRestantesSalida, segundosProximaSalida, TotalSegundosActual);
    
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
        self.horaSalidaCordobaARabanales.text =[NSString stringWithFormat:@"%02d %02d",segundosSalida/3600,(segundosSalida/60)%60];
        self.horaProximaSalidaCordobaARabanales.text =[NSString stringWithFormat:@"%02d %02d",segundosProximaSalida/3600,(segundosProximaSalida/60)%60];
        alternador=1;
    }else{
        self.horaSalidaCordobaARabanales.text =[NSString stringWithFormat:@"%02d:%02d",segundosSalida/3600,(segundosSalida/60)%60];
        self.horaProximaSalidaCordobaARabanales.text =[NSString stringWithFormat:@"%02d:%02d",segundosProximaSalida/3600,(segundosProximaSalida/60)%60];
        alternador=0;
    }
    
    //Se muestra el tiempo restante para la salida inminente
    self.HorasRestantesSalidaCordobaARabanales.text =[NSString stringWithFormat:@"%02d",segundosRestantesSalida/3600];
    self.MinutosRestantesSalidaCordobaARabanales.text =[NSString stringWithFormat:@"%02d",(segundosRestantesSalida/60)%60];
}

@end
