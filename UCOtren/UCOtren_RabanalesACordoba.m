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
@synthesize FechaActualizacion;

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
    
    [self inicioDelView];
}

- (void)inicioDelView
{
    //Declaración del puntero NSTimer (Contendra la dirección del contador)
    NSTimer *ContadorDeTiempo;
    
    //*********** VERIFICA SI EXISTE HORARIO, SINO LOS DESCARGA ************
    //
    //Declaración de los directorios de trabajo donde se almacenan los horarios
    NSArray *pathOfDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [pathOfDirectory objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"tramo-rabanales-cordoba.plist"];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    //
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSArray *dataFile = [[NSArray alloc] initWithContentsOfFile:filePath];
        if (![[dataFile objectAtIndex:5]isEqual:@"null"])
        {
            UIAlertView *alertM = [[UIAlertView alloc] initWithTitle:@"Información"
                                                             message:[dataFile objectAtIndex:5]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Cerrar"
                                                   otherButtonTitles:nil];
            [alertM show];
        }
    }
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
    //
    //******* FIN DE VERIFICA SI EXISTE HORARIO, SINO LOS DESCARGA *********
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

-(IBAction)recargarHorario:(id)sender {
    //Muestra la alerta que indica que se procede a descargar un horario
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Descargando horario\nPor favor, espere…" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    //
    //Muestra un Indicador de proceso en curso dentro de la alerta anterior
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //
    //Ajusta la posición del inicador dentro de la alerta
    indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50);
    //
    //Se procede a iniciar la animación y se ajusta el indicador dentro de view correspondiente al alert
    [indicator startAnimating];
    [alert addSubview:indicator];
    
    NSInteger statusCR = [self actualizaHorario:@"cordoba-rabanales"];
    NSInteger statusRC = [self actualizaHorario:@"rabanales-cordoba"];
    
    //Se detiene el indicador y se retira la alerta de la pantalla
    //[indicator stopAnimating];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    
    if ((statusCR==2)&&(statusRC==2))
    {
        UIAlertView *alertHAN = [[UIAlertView alloc] initWithTitle:@"Información"
                                                           message:@"No hay actualizaciones disponibles."
                                                          delegate:nil
                                                 cancelButtonTitle:@"Cerrar"
                                                 otherButtonTitles:nil];
        [alertHAN show];
    }else{
        if ((statusCR==1)&&(statusRC==1))
        {
            UIAlertView *alertHA = [[UIAlertView alloc] initWithTitle:@"Información"
                                                              message:@"Actualización realizada."
                                                             delegate:nil
                                                    cancelButtonTitle:@"Cerrar"
                                                    otherButtonTitles:nil];
            [alertHA show];
        }else{
            UIAlertView *alertNC = [[UIAlertView alloc] initWithTitle:@"Información"
                                                              message:@"Imposible descargar los horarios del servidor, revise su conexión a internet."
                                                             delegate:nil
                                                    cancelButtonTitle:@"Cerrar"
                                                    otherButtonTitles:nil];
            [alertNC show];
        }
    }
    
    //Declaración de los directorios de trabajo donde se almacenan los horarios
    NSArray *pathOfDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [pathOfDirectory objectAtIndex:0];
    NSString *fileNameT1 = [NSString stringWithFormat:@"tramo-rabanales-cordoba.plist"];
    NSString *filePathT1 = [documentDirectory stringByAppendingPathComponent:fileNameT1];
    NSString *fileNameT2 = [NSString stringWithFormat:@"tramo-cordoba-rabanales.plist"];
    NSString *filePathT2 = [documentDirectory stringByAppendingPathComponent:fileNameT2];
    //
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePathT1])
    {
        NSArray *dataFileT1 = [[NSArray alloc] initWithContentsOfFile:filePathT1];
        if (![[dataFileT1 objectAtIndex:5]isEqual:@"null"])
        {
            UIAlertView *alertM = [[UIAlertView alloc] initWithTitle:@"Información"
                                                             message:[dataFileT1 objectAtIndex:5]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Cerrar"
                                                   otherButtonTitles:nil];
            [alertM show];
        }
    }
    //
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePathT2])
    {
        NSArray *dataFileT2 = [[NSArray alloc] initWithContentsOfFile:filePathT2];
        if (![[dataFileT2 objectAtIndex:5]isEqual:@"null"])
        {
            UIAlertView *alertM = [[UIAlertView alloc] initWithTitle:@"Información"
                                                             message:[dataFileT2 objectAtIndex:5]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Cerrar"
                                                   otherButtonTitles:nil];
            [alertM show];
        }
    }
}


//FUNCION: relojEnCurso (función de tiempo, realiza el calculo entre el tiempo actual y los tiempos del vector)
- (void)relojEnCurso:(NSTimer *)timer
{
    //Declaración de los directorios de trabajo donde se almacenan los horarios
    NSArray *pathOfDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [pathOfDirectory objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"tramo-rabanales-cordoba.plist"];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
    
        //Declaración del horario de cada una de las salidas, el ultimo valor del vector y de un contador auxiliar que se usa en la función
        NSArray *dataFile = [[NSArray alloc] initWithContentsOfFile:filePath];
        NSArray* horario = [[dataFile objectAtIndex:4] componentsSeparatedByString: @"|"];
    
        if ([horario count] > 0)
        {
            int ultimoValorHorario = ([horario count] - 1);
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
            if((TotalSegundosActual > [self StringASegundos:[horario objectAtIndex:ultimoValorHorario]])||(DiaSemanaActual==6)||(DiaSemanaActual==7))
            {
                //Si se da el caso anterior, pues se empieza mostrando el horario del siguiente día
                segundosSalida=[self StringASegundos:[horario objectAtIndex:0]];
                segundosRestantesSalida = (86400 - TotalSegundosActual + 60) + [self StringASegundos:[horario objectAtIndex:0]];
                segundosProximaSalida=[self StringASegundos:[horario objectAtIndex:1]];
            
                if (DiaSemanaActual==5) //Si es viernes ultima hora, el proximo tren es el lunes (salta 2 días)
                    segundosRestantesSalida = segundosRestantesSalida + (86400*2);
                if (DiaSemanaActual==6) //Si es sabado ultima hora, el proximo tren es el lunes (salta 1 día)
                    segundosRestantesSalida = segundosRestantesSalida + 86400;
            
            }else{
                //Si no se da el caso anterior, pues se recorre el vector horario hasta que encontremos la salida inminente
                while(TotalSegundosActual > [self StringASegundos:[horario objectAtIndex:contadorAuxiliar]])
                {
                    contadorAuxiliar++;
                }
                segundosSalida=[self StringASegundos:[horario objectAtIndex:contadorAuxiliar]];
                segundosRestantesSalida = [self StringASegundos:[horario objectAtIndex:contadorAuxiliar]] - TotalSegundosActual + 60;
                if ([self StringASegundos:[horario objectAtIndex:contadorAuxiliar]] == [self StringASegundos:[horario objectAtIndex:ultimoValorHorario]])
                    segundosProximaSalida=[self StringASegundos:[horario objectAtIndex:0]];
                else
                    segundosProximaSalida=[self StringASegundos:[horario objectAtIndex:(contadorAuxiliar+1)]];
            }
    
            //Se muestra un resumen de los datos en el Log
            NSLog(@" * Reloj de Rabanales a Córdoba: Segundos salida inminente: %d, Segundos restantes salida inminente: %d, Segundos Próxima salida: %d, Segundos Actual: %d\n", segundosSalida, segundosRestantesSalida, segundosProximaSalida, TotalSegundosActual);
    
            //Se llama a una función encargada de mostrar los resultados por pantalla
            [self actualizarDatosEnPantalla];
            self.FechaActualizacion.text = [NSString stringWithFormat:@"Última actualización: %@",[dataFile objectAtIndex:3]];
        }else{
            [timer invalidate];
        }
    }
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

//FUNCION: StringASegundos (Devuelve en segundos la hora pasada como parametro HH:MM -> S)
-(NSInteger) StringASegundos: (NSString *) hora
{
    NSArray* HH_MM = [hora componentsSeparatedByString: @":"];
    
    NSInteger Horas = [[HH_MM objectAtIndex:0] integerValue];
    NSInteger Minutos = [[HH_MM objectAtIndex:1] integerValue];
    
    return ((Horas*3600)+(Minutos*60));
}

//FUNCION: actualizaHorario (Actualiza el horarios almacenados en ficheros plist conectandose a la API de UCOmove)
- (NSInteger)actualizaHorario: (NSString *) tramo
{
    // Actualiza el horarios almacenados en ficheros plist conectandose a la API de UCOmove
    //
    //Declaración de los directorios de trabajo donde se almacenan los horarios
    NSArray *pathOfDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [pathOfDirectory objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"tramo-%@.plist", tramo];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    //
    //************************* ALERTA DE INICIO DE DESCARGA *************************
    //
    //Muestra la alerta que indica que se procede a descargar un horario
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Descargando horario\nPor favor, espere…" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    //
    //Muestra un Indicador de proceso en curso dentro de la alerta anterior
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //
    //Ajusta la posición del inicador dentro de la alerta
    indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50);
    //
    //Se procede a iniciar la animación y se ajusta el indicador dentro de view correspondiente al alert
    [indicator startAnimating];
    [alert addSubview:indicator];
    //
    //******************** SE PROCEDE A LA DESCARGA DEL HORARIO **********************
    //
    NSError *error = nil;
    NSString *URLdownload = [NSString stringWithFormat:@"http://your.server/your/api/endpoint.php?plataforma=ios&tipo=tren&tramo=%@", tramo]; // Change me / Cambialo
    NSString *response=[NSString stringWithContentsOfURL:[NSURL URLWithString:URLdownload] encoding:NSUTF8StringEncoding error:&error];
    //
    //Se comprueba si se recibe respuesta del servidor
    if (response)
    {
        //******************** SE RECIBE RESPUESTA DEL SERVIDOR **********************
        //
        //Se almacena el contenido descargado del servidor en un Array
        NSArray* dataDownload = [response componentsSeparatedByString: @"//"];
        //
        //Se comprueba si el servidor ha aceptado la consulta
        if ([[dataDownload objectAtIndex:0]isEqual:@"On"])
        {
            //****************** EL SERVIDOR ACEPTA LA CONSULTA **********************
            //
            if ([[dataDownload objectAtIndex:1]isEqual:@"Ok"])
            {
                //*********** EL SERVIDOR REALIZO CON EXITO LA CONSULTA **************
                //
                //Se comprueba si el archivo ya existe
                if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
                {
                    //** EN CASO DE QUE EL ARCHIVO EXISTA SE COMPRUEBAN LAS FECHAS ***
                    NSArray *dataFile = [[NSArray alloc] initWithContentsOfFile:filePath];
                    //
                    //Se comprueban si las fechas son iguales
                    if([[dataDownload objectAtIndex:3]isEqual:[dataFile objectAtIndex:3]])
                    {
                        //**** EL CONTENIDO DESCARGADO ES EL MISMO QUE EL ACTUAL *****
                        //
                        //Se detiene el indicador y se retira la alerta de la pantalla
                        [indicator stopAnimating];
                        [alert dismissWithClickedButtonIndex:0 animated:YES];
                        //
                        NSLog(@"Descarga del horario %@ completada, no actualizado.", tramo);
                        //
                        //Se devuelve 2 indicando que la descarga es la misma que la actual
                        return 2;
                    }else{
                        //** EL CONTENIDO DESCARGADO NO ES EL MISMO QUE EL ACTUAL ***
                        //
                        //Se elimina el contenido actual del archivo
                        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                        //
                        //Se crea un nuevo archivo con los datos nuevos
                        [dataDownload writeToFile:filePath atomically:YES];
                        //
                        //Se detiene el indicador y se retira la alerta de la pantalla
                        [indicator stopAnimating];
                        [alert dismissWithClickedButtonIndex:0 animated:YES];
                        //
                        NSLog(@"Descarga del horario %@ completada, actualizado", tramo);
                        //
                        //Se devuelve 1 indicando que la descarga se ha realizado
                        return 1;
                    }
                }else{
                    //EL ARCHIVO NO EXISTE, SE CREA UNO NUEVO CON LOS DATOS DESCARGADOS
                    [dataDownload writeToFile:filePath atomically:YES];
                    //
                    //Se detiene el indicador y se retira la alerta de la pantalla
                    [indicator stopAnimating];
                    [alert dismissWithClickedButtonIndex:0 animated:YES];
                    //
                    NSLog(@"Descarga del horario %@ completada, actualizado.", tramo);
                    //
                    //Se devuelve 1 indicando que la descarga se ha realizado
                    return 1;
                }
            }else{
                //********** EL SERVIDOR NO REALIZO CON EXITO LA CONSULTA ************
                //
                //Se detiene el indicador y se retira la alerta de la pantalla
                [indicator stopAnimating];
                [alert dismissWithClickedButtonIndex:0 animated:YES];
                //
                NSLog(@"#ERROR#: Servidor apagado, no acepta conexiones.");
                //
                //Se devuelve 0 indicando que la descarga no a sido posible
                return 0;
            }
        }else{
            //***************** EL SERVIDOR NO ACEPTA LA CONSULTA ********************
            //
            //Se detiene el indicador y se retira la alerta de la pantalla
            [indicator stopAnimating];
            [alert dismissWithClickedButtonIndex:0 animated:YES];
            //
            //Se observa si el fallo de no aceptar la consulta es por desconeción o otra cosa
            if ([[dataDownload objectAtIndex:0]isEqual:@"Off"])
            {
                NSLog(@"#ERROR#: Servidor apagado, no acepta conexiones.");
            }else{
                NSLog(@"%@",[dataDownload objectAtIndex:0]);
            }
            //
            //Se devuelve 0 indicando que la descarga no a sido posible
            return 0;
        }
    }else{
        //******************* NO SE RECIBE RESPUESTA DEL SERVIDOR ********************
        //
        //Se detiene el indicador y se retira la alerta de la pantalla
        [indicator stopAnimating];
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        //
        //Se manda al log el error de la descarga
        NSLog(@"#Error#: Imposible descargar horario del servidor\n###############################\n%@\n###############################\n", error);
        //
        //Se devuelve 0 indicando que la descarga no a sido posible
        return 0;
    }
}

@end
