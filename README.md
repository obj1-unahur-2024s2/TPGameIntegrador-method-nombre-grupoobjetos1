# Instrucciones
- Se mueve con las flechitas izquierda y derecha
- Se dispara con la flecha hacia arriba
- El enemigo tiene 3 vidas


## Otros

- Unahur
- Una vez terminado, no tenemos problemas en que el repositorio sea público

## TO-DO
- Hacer que el enemigo dispare tambien (se puede reutilizar la clase "Llama" cambiandola para que tome como parametro quien la esta lanzando y la direccion a la que debe moverse)
- Agregar una pantalla de game over y una forma de reiniciar el juego sin tener que lanzarlo de vuelta (osea sin usar game.stop())
- Agregar vidas al jugador y un metodo recibirImpacto() similar al del enemigo (tiene que ser polimorfico si vamos a reutilizar la clase "Llama")
- Agregar objetos que aparezcan en una posicion x random a la altura del jugador, que aumenten la vida quizas
- Limitar la frecuencia con la que podemos disparar para que las llamas no colisionen entre si, y para que sea mas divertido el juego
- Destruir las llamas una vez que o impactan con el enemigo o salen de la pantalla (no se como se hace eso)
