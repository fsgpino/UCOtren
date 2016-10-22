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
@synthesize FechaActualizacion;
@synthesize bacercade;
@synthesize bhorario;

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

    //Establece las fuentes
    NSLog(@" * Estableciendo fuentes (Córdoba a Rabanales)...");
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
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
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
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

    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f) {
        [bacercade setImage:[UIImage imageNamed:@"TabBarImage-InfoA.png"]];
        [bhorario setImage:[UIImage imageNamed:@"TabBarImage-HorariosA.png"]];
    }
    
    //Se establece el alternador y errorMemoria a 0
    alternador = 0;
    errorMemoria = 0;
    
    [self inicioDelView];
}

- (void)inicioDelView
{
    NSInteger status = [self actualizaHorario];
    NSString *MStatus = nil;

    if (status==0)
    {
        MStatus = [NSString stringWithFormat:@"¡Nuevos horarios descargados! ¡Revisalos!"];
    }else if (status==1)
    {
        MStatus = [NSString stringWithFormat:@"No hay actualizaciones disponibles"];
    }else if (status==2)
    {
        MStatus = [NSString stringWithFormat:@"¡Actualización de UCOtren disponible! Actualiza la aplicación para poder recibir actualizaciones de horarios"];
    }else if (status==3)
    {
        MStatus = [NSString stringWithFormat:@"¡Error de consulta! Nuestros tecnicos lo resolveran lo antes posible"];
    }else if (status==4)
    {
        MStatus = [NSString stringWithFormat:@"¡Servidor de horarios en mantenimiento! Por favor, intente realizar la actualización más tarde"];
    }else if (status==5)
    {
        MStatus = [NSString stringWithFormat:@"¡Error de parametros! Nuestros tecnicos lo resolveran lo antes posible"];
    }else{
        MStatus = [NSString stringWithFormat:@"¡No hay conexión a internet! Revisa tu conexión y vuelve a intentarlo"];
    }

    //Declaración de los directorios de trabajo donde se almacena el mensaje
    NSArray *pathOfDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [pathOfDirectory objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"mensaje.txt"];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    //
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSString *dataFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        if (![dataFile isEqual:@"n/a"])
        {
            UIAlertView *alertM = [[UIAlertView alloc] initWithTitle:@"Mensaje del servidor"
                                                             message:dataFile
                                                            delegate:nil
                                                   cancelButtonTitle:@"Cerrar"
                                                   otherButtonTitles:nil];
            [alertM show];
        }
    }

    NSString *fileNameCR = [NSString stringWithFormat:@"tramo-CR.plist"];
    NSString *filePathCR = [documentDirectory stringByAppendingPathComponent:fileNameCR];
    NSString *fileNameRC = [NSString stringWithFormat:@"tramo-RC.plist"];
    NSString *filePathRC = [documentDirectory stringByAppendingPathComponent:fileNameRC];

    if((status==0)||(status==2)||(!([[NSFileManager defaultManager] fileExistsAtPath:filePathCR]))||(!([[NSFileManager defaultManager] fileExistsAtPath:filePathRC])))
    {
        UIAlertView *alertD = [[UIAlertView alloc] initWithTitle:@"Información"
                                                         message:MStatus
                                                        delegate:nil
                                               cancelButtonTitle:@"Cerrar"
                                               otherButtonTitles:nil];
        [alertD show];
    }

    //Arranca la función encargada del reloj antes de esperar el primer segundo
    NSLog(@" !* Arrancando la función relojEnCurso (Córdoba a Rabanales) por primera vez\n");
    [self relojEnCurso:nil];
        
    //Arranca la funcion encargada del reloj ejecutandose cada segundo, esperando un primer segundo
    NSLog(@" !* Arrancando la función relojEnCurso (Córdoba a Rabanales) con el temporizador\n");
    [NSTimer scheduledTimerWithTimeInterval:1
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
                                                   delegate:self
                                          cancelButtonTitle:@"Cerrar"
                                          otherButtonTitles:@"Actualizar horarios",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0) {
        [self recargarHorario:0];
    }
}

-(IBAction)recargarHorario:(id)sender {

    NSInteger status = [self actualizaHorario];
    NSString *MStatus = nil;

    if (status==0)
    {
        MStatus = [NSString stringWithFormat:@"Actualización realizada"];
    }else if (status==1)
    {
        MStatus = [NSString stringWithFormat:@"No hay actualizaciones disponibles"];
    }else if (status==2)
    {
        MStatus = [NSString stringWithFormat:@"¡Actualización de UCOtren disponible! Actualiza la aplicación para poder realizar actualizaciones de horarios"];
    }else if (status==3)
    {
        MStatus = [NSString stringWithFormat:@"¡Error de consulta! Nuestros tecnicos lo resolveran lo antes posible"];
    }else if (status==4)
    {
        MStatus = [NSString stringWithFormat:@"¡Servidor de horarios en mantenimiento! Por favor, intente realizar la actualización más tarde"];
    }else if (status==5)
    {
        MStatus = [NSString stringWithFormat:@"¡Error de parametros! Nuestros tecnicos lo resolveran lo antes posible"];
    }else{
        MStatus = [NSString stringWithFormat:@"¡No hay conexión a internet! Revisa tu conexión y vuelve a intentarlo"];
    }

    if(status==0)
    {
        //Declaración de los directorios de trabajo donde se almacena el mensaje
        NSArray *pathOfDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [pathOfDirectory objectAtIndex:0];
        NSString *fileName = [NSString stringWithFormat:@"mensaje.txt"];
        NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
        //
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        {
            NSString *dataFile = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            if (![dataFile isEqual:@"n/a"])
            {
                UIAlertView *alertM = [[UIAlertView alloc] initWithTitle:@"Mensaje del servidor"
                                                                 message:dataFile
                                                                delegate:nil
                                                       cancelButtonTitle:@"Cerrar"
                                                       otherButtonTitles:nil];
                [alertM show];
            }
        }
    }

    UIAlertView *alertD = [[UIAlertView alloc] initWithTitle:@"Información"
                                                     message:MStatus
                                                    delegate:nil
                                           cancelButtonTitle:@"Cerrar"
                                           otherButtonTitles:nil];
    [alertD show];
}

//FUNCION: relojEnCurso (función de tiempo, realiza el calculo entre el tiempo actual y los tiempos del vector)
- (void)relojEnCurso:(NSTimer *)timer
{
    //Declaración de los directorios de trabajo donde se almacenan los horarios
    NSArray *pathOfDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [pathOfDirectory objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"tramo-CR.plist"];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
    
        //Declaración del horario de cada una de las salidas, el ultimo valor del vector y de un contador auxiliar que se usa en la función
        NSArray *dataFile = [[NSArray alloc] initWithContentsOfFile:filePath];
        NSArray* horario = [[dataFile objectAtIndex:3] componentsSeparatedByString: @"|"];
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
            NSLog(@" * Reloj de Córdoba a Rabanales: Segundos salida inminente: %d, Segundos restantes salida inminente: %d, Segundos Próxima salida: %d, Segundos Actual: %d\n", segundosSalida, segundosRestantesSalida, segundosProximaSalida, TotalSegundosActual);
    
            //Se llama a una función encargada de mostrar los resultados por pantalla
            [self actualizarDatosEnPantalla];
            self.FechaActualizacion.text = [NSString stringWithFormat:@"Última actualización: %@",[dataFile objectAtIndex:2]];
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

//FUNCION: StringASegundos (Devuelve en segundos la hora pasada como parametro HH:MM -> S)
-(NSInteger) StringASegundos: (NSString *) hora
{
    NSArray* HH_MM = [hora componentsSeparatedByString: @":"];
    
    NSInteger Horas = [[HH_MM objectAtIndex:0] integerValue];
    NSInteger Minutos = [[HH_MM objectAtIndex:1] integerValue];
    
    return ((Horas*3600)+(Minutos*60));
}

//FUNCION: actualizaHorario (Actualiza el horarios almacenados en ficheros conectandose a la API de UCOmove)
- (NSInteger)actualizaHorario
{
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                          //
    //                      FUNCIÓN DE ACTUALIZACIÓN DE HORARIOS CON UCOAPI 1.2 - Por Francisco Gómez Pino                      //
    //                                                                                                                          //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                          //
    //  - VERSIÓN PARA: UCOTREN 1.6                                                                                             //
    //                                                                                                                          //
    //  - SALIDAS DE LA FUNCIÓN:                                                                                                //
    //      - return 0: Actualización realizada con exito.                                                                      //
    //      - return 1: No hay actualizaciones disponibles.                                                                     //
    //      - return 2: El servidor no autoriza la aplicación.                                                                  //
    //      - return 3: Consulta realizada incorrectamente.                                                                     //
    //      - return 4: Servidor desconectado o en mantenimiento.                                                               //
    //      - return 5: Parametros incompletos u otros posibles errores.                                                        //
    //      - return 6: Imposible establecer conexión con el servidor (Terminal sin acceso a la red).                           //
    //                                                                                                                          //
    //  - PARAMETROS DE CONFIGURACIÓN:                                                                                          //
    //                                                                                                                          //
    NSString *pApp          = [NSString stringWithFormat:@"UCOtren"];                       // Nombre de la aplicación          //
    NSString *pVersion      = [NSString stringWithFormat:@"1.6"];                           // Versión de la aplicación         //
    NSString *pBuild        = [NSString stringWithFormat:@"10615"];                         // Build de la aplicación           //
    NSString *pPlataform    = [NSString stringWithFormat:@"ios"];                           // Plataforma de la aplicación      //
    NSString *pTipoH        = [NSString stringWithFormat:@"tren"];                          // Tipo de horario a pedir          //
    NSString *pTramos       = [NSString stringWithFormat:@"cordoba-rabanales;rabanales-cordoba"]; // Horarios a pedir           //
    NSString *pFormatH      = [NSString stringWithFormat:@"1"];                             // Formato de horario a pedir       //
    //                                                                                                                          //
    //  - PARAMETROS DE CONEXÍON (URL de descarga):                                                                             //
    //                                                                                                                          //
    NSString *URLdownload = [NSString stringWithFormat:@"http://your.server/your/api/endpoint.php?app=%@&vapp=%@&bapp=%@&plataforma=%@&tipo=%@&tramos=%@&fhorario=%@", pApp, pVersion, pBuild, pPlataform, pTipoH, pTramos, pFormatH]; // Change me / Cambialo
    //                                                                                                                          //
    //  - PARAMETROS DE ALMACENAMIENTO:                                                                                         //
    //                                                                                                                          //
    NSString *fileNameCR = [NSString stringWithFormat:@"tramo-CR.plist"];   // Nombre el horario Cordoba-Rabanales              //
    NSString *fileNameRC = [NSString stringWithFormat:@"tramo-RC.plist"];   // Nombre el horario Rabanales-Cordoba              //
    NSString *fileNameMS = [NSString stringWithFormat:@"mensaje.txt"];      // Nombre para el mensaje                           //
    //                                                                                                                          //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    //Declaración de los directorios de trabajo donde se almacenan los horarios CR y RC y el mensaje
    NSArray *pathOfDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [pathOfDirectory objectAtIndex:0];
    NSString *filePathCR = [documentDirectory stringByAppendingPathComponent:fileNameCR];
    NSString *filePathRC = [documentDirectory stringByAppendingPathComponent:fileNameRC];
    NSString *filePathMS = [documentDirectory stringByAppendingPathComponent:fileNameMS];
    //
    //******************** SE PROCEDE A LA DESCARGA DE LOS HORARIOS **********************
    //
    NSError *error = nil;
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
                // Se define una bandera para comprobar si algo se actualiza
                int banderaActualizacion=0;
                //
                //// - INICIANDO COMPROBACIÓN DE HORARIO CR
                //
                // Se obtiene el horario de la descarga
                NSArray *dataDownloadCR = [[dataDownload objectAtIndex:2] componentsSeparatedByString:@"$$"];
                //
                //Se comprueba si el archivo ya existe
                if ([[NSFileManager defaultManager] fileExistsAtPath:filePathCR])
                {
                    // Si es así se comprueba el contenido del archivo actual, con el contenido descargado
                    NSArray *dataFileCR = [[NSArray alloc] initWithContentsOfFile:filePathCR];
                    //
                    //Se comprueban si los codigos y fechas son iguales
                    if(([[dataDownloadCR objectAtIndex:0]isEqual:[dataFileCR objectAtIndex:0]])&&([[dataDownloadCR objectAtIndex:2]isEqual:[dataFileCR objectAtIndex:2]]))
                    {
                        //**** EL CONTENIDO DESCARGADO ES EL MISMO QUE EL ACTUAL *****
                        //
                        NSLog(@" #FAHorario: Horario CR no actualizado\n");
                    }else{
                        //** EL CONTENIDO DESCARGADO NO ES EL MISMO QUE EL ACTUAL ***
                        //
                        //Se elimina el contenido actual del archivo
                        [[NSFileManager defaultManager] removeItemAtPath:filePathCR error:nil];
                        //
                        //Se crea un nuevo archivo con los datos nuevos
                        [dataDownloadCR writeToFile:filePathCR atomically:YES];
                        //
                        NSLog(@" #FAHorario: Horario CR actualizado\n");
                        //
                        banderaActualizacion = 1; // Se considera como actualizado
                    }
                }else{
                    //EL ARCHIVO NO EXISTE, SE CREA UNO NUEVO CON LOS DATOS DESCARGADOS
                    [dataDownloadCR writeToFile:filePathCR atomically:YES];
                    //
                    NSLog(@" #FAHorario: Horario CR creado\n");
                    //
                    banderaActualizacion = 1; // Se considera como actualizado
                }
                //
                //// - INICIANDO COMPROBACIÓN DE HORARIO RC
                //
                // Se obtiene el horario de la descarga
                NSArray *dataDownloadRC = [[dataDownload objectAtIndex:3] componentsSeparatedByString:@"$$"];
                //
                //Se comprueba si el archivo ya existe
                if ([[NSFileManager defaultManager] fileExistsAtPath:filePathRC])
                {
                    // Si es así se comprueba el contenido del archivo actual, con el contenido descargado
                    NSArray *dataFileRC = [[NSArray alloc] initWithContentsOfFile:filePathRC];
                    //
                    //Se comprueban si los codigos y fechas son iguales
                    if(([[dataDownloadRC objectAtIndex:0]isEqual:[dataFileRC objectAtIndex:0]])&&([[dataDownloadRC objectAtIndex:2]isEqual:[dataFileRC objectAtIndex:2]]))
                    {
                        //**** EL CONTENIDO DESCARGADO ES EL MISMO QUE EL ACTUAL *****
                        //
                        NSLog(@" #FAHorario: Horario RC no actualizado\n");
                    }else{
                        //** EL CONTENIDO DESCARGADO NO ES EL MISMO QUE EL ACTUAL ***
                        //
                        //Se elimina el contenido actual del archivo
                        [[NSFileManager defaultManager] removeItemAtPath:filePathRC error:nil];
                        //
                        //Se crea un nuevo archivo con los datos nuevos
                        [dataDownloadRC writeToFile:filePathRC atomically:YES];
                        //
                        NSLog(@" #FAHorario: Horario RC actualizado\n");
                        //
                        banderaActualizacion = 1; // Se considera como actualizado
                    }
                }else{
                    //EL ARCHIVO NO EXISTE, SE CREA UNO NUEVO CON LOS DATOS DESCARGADOS
                    [dataDownloadRC writeToFile:filePathRC atomically:YES];
                    //
                    NSLog(@" #FAHorario: Horario RC creado\n");
                    //
                    banderaActualizacion = 1; // Se considera como actualizado
                }
                //
                //// - INICIANDO COMPROBACIÓN DEL MENSAJE
                //
                NSString *downloadMS = [dataDownload objectAtIndex:4];
                //
                //Se comprueba si el archivo ya existe
                if ([[NSFileManager defaultManager] fileExistsAtPath:filePathMS])
                {
                    // Si es así se comprueba el contenido del archivo actual, con el contenido descargado
                    NSString *dataFileMS = [NSString stringWithContentsOfFile:filePathMS encoding:NSUTF8StringEncoding error:nil];
                    //
                    //Se comprueba si los mensajes son iguales
                    if([downloadMS isEqual:dataFileMS])
                    {
                        //**** EL CONTENIDO DESCARGADO ES EL MISMO QUE EL ACTUAL *****
                        //
                        NSLog(@" #FAHorario: Mensaje no actualizado\n");
                    }else{
                        //** EL CONTENIDO DESCARGADO NO ES EL MISMO QUE EL ACTUAL ***
                        //
                        //Se elimina el contenido actual del archivo
                        [[NSFileManager defaultManager] removeItemAtPath:filePathMS error:nil];
                        //
                        //Se crea un nuevo archivo con los datos nuevos
                        [downloadMS writeToFile:filePathMS atomically:YES encoding:NSUTF8StringEncoding error:nil];
                        //
                        NSLog(@" #FAHorario: Mensaje actualizado\n");
                    }
                }else{
                    //EL ARCHIVO NO EXISTE, SE CREA UNO NUEVO CON LOS DATOS DESCARGADOS
                    [downloadMS writeToFile:filePathMS atomically:YES encoding:NSUTF8StringEncoding error:nil];
                    //
                    NSLog(@" #FAHorario: Mensaje creado\n");
                }
                //
                // Se verifica la bandera, 1 se a actualizado, 0 no
                if(banderaActualizacion==1)
                {
                    return 0; // Se devuelve 0, puesto que se ha realizado al menos una actualización
                }else{
                    return 1; // Se devuelve 1, puesto que no se ha realizado ninguna actualización
                }
            }else{
                //********** EL SERVIDOR NO REALIZO CON EXITO LA CONSULTA ************
                //
                //Se observa si el fallo de consulta falllida o por aplicación no permitida
                if ([[dataDownload objectAtIndex:1]isEqual:@"Fail"])
                {
                    NSLog(@" #FAHorario: Error -> Consulta fallida\n");
                    //
                    return 3; // Se devuelve 3, puesto que la consulta se a realizado de forma incorrecta
                }else{
                    NSLog(@" #FAHorario: Aplicación denegada por el servidor\n");
                    //
                    return 2; // Se devuelve 2, puesto que el servidor no permite la descarga a esta versión
                }
            }
        }else{
            //***************** EL SERVIDOR NO ACEPTA LA CONSULTA ********************
            //
            //Se observa si el fallo de no aceptar la consulta es por desconeción o otra cosa
            if ([[dataDownload objectAtIndex:0]isEqual:@"Off"])
            {
                NSLog(@" #FAHorario: Error -> Servidor offline\n");
                //
                return 4; // Se devuelve 4, puesto que el servidor se encuentra desconectado
            }else{
                NSLog(@" #FAHorario: %@\n",[dataDownload objectAtIndex:0]);
                //
                return 5; // Se devuelve 5, puesto que el servidor a devuelto algun error de parametros
            }
        }
    }else{
        //******************* NO SE RECIBE RESPUESTA DEL SERVIDOR ********************
        //
        //Se manda al log el error de la descarga
        NSLog(@" #FAHorario: Error -> Imposible realizar la conexión\n%@\n", error);
        //
        return 6; // Se devuelve 6, puesto que es imposible establecer la conexión
    }
}

@end
