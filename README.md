# Una vesión más de Tetris.

Autor:Diego Fernando Malagón Saénz. -- [Diekal](https://github.com/Diekal)

Universidad Nacional De Colombia.

Programación orientada a objetos.

## Introducción.

Desarrollar un programa capaz de reproducir el famoso video juego de Tetris, con el fin de repasar conceptos básicos de la programación estructurada. Para esto se hizo uso del entorno de desarrollo de processing el cual cuenta con su propio lenguaje de programación, además, este software libre presenta la facilidad de tener bien organizada su API o [referencias](https://processing.org/reference/) en su página oficial lo que facilitó el aprendizaje de este y posteriormente el desarrollo del código presente.

## Sobre el juego.

Es un hecho que la mayoría de las personas han jugado Tetris y al menos conocen las reglas, sin embargo, no sobra una pequeña explicación sobre este mismo. El juego consiste en organizar una serie de tetrominos que irán cayendo a cierta velocidad, la idea es no dejar espacios vacíos y completar hileras, al completar una línea esta se elimina y se suma cierta cantidad al puntaje, el objetivo es completar 10 líneas para así subir de nivel, el nivel se ve reflejado en la velocidad de caída de cada tetromino.

### Sistema de puntaje.
Existen dos maneras de sumar puntos, la primera es aumentando la velocidad de caída, dependiendo de la cantidad de tiempo en el que se mantenga oprimida la flecha de abajo, el contador ira subiendo, aunque el sumar puntos de esta manera puede llevar al jugador a equivocarse por lo que la dificultad del juego también depende en gran parte del usuario.

Por otro lado también se puede sumar puntos completando líneas, por cada línea completada se suman 100 puntos, pero ¿ qué pasa cuando se completan varias líneas al tiempo ? lo que ocurre es que estos puntos se suman pero con la diferencia de que estos se ven multiplicados por el número de filas completadas al tiempo, es decir que si por ejemplo se completan dos líneas al tiempo entonces se harían 300 puntos, pues la primera línea se multiplica por 1 dando 100 puntos y la segunda se multiplica por 2 por lo que esta da 200 puntos. De esta manera, con completar 3 filas al tiempo se harían 600 puntos y si se completan 4 al tiempo entonces se hacen 1000 puntos.


## Funcionamiento del código.

Para entender el funcionamiento del código primero hay que identificar las condiciones que son requeridas para el buen funcionamiento del juego, para así de manera más organizada y resumida se puede explicar la utilidad de cada función empleada.
- Se deben asegura los choques entre los bloques.
- El guardado del tablero con los bloques que ya han caído.
- Debe haber una rotación.
- El movimiento de izquierda a derecha y la caída rápida que depende del jugador.
- Debe haber un contador de puntos.
- El indicador de nivel y el cambio de este mismo.
- Se debe eliminar la fila que sea completada.
- Normalmente se muestra la figura que aparecerá luego de que la que está en juego caiga.
- Debe haber un final.

### Los choques y el guardado del tablero.
Para resolver el problema de lo choque lo que se hizo fue crear una matriz que guardaría información sobre la posición de los bloques que ya hallan caído, así mientas los términos van cayendo se está revisando constantemente si la siguiente posición ya está siendo ocupada por otra figura. Para el movimiento que el usuario realiza también se realiza un análisis previo de la futura posición que la figura para así evitar sobreposiciones.
Por otro lado, el proceso de guardado consiste en traducir la posición inicialmente en coordenadas X y Y de cada cuadrado en una posición en la matriz tablero para así poder evaluar cada caso.

### La rotación.
Pensando en la rotación de los términos, lo que se hizo fue definirlos bit a bit y guardarlos en un arreglo que contenga todas sus rotaciones, de esta manera se crea una variable Rotation que representará la posición en este arreglo y que cada vez que se oprime la flecha de arriba esta cambiara generando la rotación.

### Movimiento de izquierda a derecha.
Para controlar este movimiento lo que se hace es que cada que las flechas de izquierda y derecha son oprimidas las coordenadas en X cambian a escala de cada cuadrado, de esta manera si se quiere ir a la izquierda lo que se hace es restarle al valor de x, pero si por otro lado lo que se quiere es ir a la derecha los que se hace es sumarle a la variable X. Esto como ya se había dicho condicionada para que los choques ocurran correctamente.

### Interfaz.
Dentro de la interfaz se encuentran 3 conceptos importantes, el primero es la visualización de la próxima figura, para esto se crean dos arreglos que guardarán la información de las figuras que serán usadas. Primero se selecciona una figura al azar en el setup() para guardarla en el primer arreglo, para luego en el draw() asignar la información del primer arreglo en el segundo y sobre escribir en el primer arreglo otra figura al azar. De esta manera el primer arreglo llevará la información de la figura que está en juego y el segundo arreglo guardará la información de la figura que irá después.

por otro lado el contador de puntos se maneja como una variable global en dos puntos específicos del código, en la lectura de la tecla de la flecha hacia abajo en la funcion keyPressed() y en la función avance_nivel() en la que se eliminan las filas completadas. 

Y por último está el nivel, este se toma como un contador que empieza en 1, para que este cambie, se utilizó otro contador que en la función avance_nivel() va contando la líneas que son eliminadas, al eliminar 10, este contador se reinicia y el contador de nivel aumenta, la dificultad como ya se había dicho cambia con el aumento de la velocidad de caída por lo que al cambiar de nivel lo que se hace es restarle cierta cantidad a la variable dentro de la función Delay().

### Eliminación de filas.
Para la eliminación de las filas en la misma avance_nivel() lo que se hace es evaluar el estado de cada fila de abajo hacia arriba, cuando esta función detecta una fila completada, le asigna a esta fila los valores de la fila de arriba y así sucesivamente por todo el tablero asegurando la gravedad que se supone es consecuencia de la eliminación de esta fila.

### Game over.
Como lo hace la función avance_nivel(), la función game_over() está constantemente evaluando el estado del tablero, pero más específicamente en la primer fila, cuando esta función detecta que se ha guardado una figura en esta fila la función inmediatamente pone pausa a la función draw() dando fin al juego.

## Referencias .
1. [Juego guia tomado como referencia.](https://tetris.com/play-tetris)
2. [informacion adicional sobre el juego.](https://es.wikipedia.org/wiki/Tetris)
3. [Referencia de processing.](https://processing.org/reference/)
