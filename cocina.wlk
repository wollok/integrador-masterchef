class Comida {
  var property cocinero
  method calorias() = 100 + 3 * self.grasas() 
  method grasas()
}

class Entrada inherits Comida{
  override method grasas() = 0
  method bonito() = true
}

class Principal inherits Comida{
  var property bonito = true
  const property grasas 
  override method grasas() = grasas
}
class Postre inherits Comida{
  const colores 
  override method grasas() = 120
  method bonito() = colores > 3
}
class Cocinero {
  var especialidad = sousChef

  method calificar(plato) = especialidad.calificar(plato)
  method cocinar() = especialidad.cocinar(self)
//  method cocinar() = especialidad.cocinar()

  method especialidad(nueva){
    especialidad = nueva
  }
}

class Pastelero {
  const nivelDeseado
  method calificar(plato) = (5 * plato.grasas() / nivelDeseado ).min(10)
  method cocinar(cocinero) = new Postre(colores = nivelDeseado/50,cocinero =cocinero)
//  method cocinar() = new Postre(colores = nivelDeseado/50)
}
class Chef {
  const calorias
  method calificar(plato) = if (plato.bonito()and plato.calorias() <= calorias ) 10 else 0
  method cocinar(cocinero) = new Principal(grasas = calorias, cocinero = cocinero)
//  method cocinar() = new Principal(grasas = calorias)
}

object sousChef {
  // Implementacioń inventada. Siempre es un numero entre 1 y 10. No califica con 0
  method calificar(plato) = plato.calorias()%10 + 1 
  method cocinar(cocinero) = new Entrada(cocinero = cocinero)
//  method cocinar() = new Entrada()
}
object concurso {

  const cocineros = []
  const platosPresentados = []
  method inscribirse(cocinero){
    cocineros.add(cocinero)
    platosPresentados.add(cocinero.cocinar())
  }
  method calificacion(plato) = cocineros.sum{cocinero=>cocinero.calificar(plato)}
  method ganador() = platosPresentados.max{plato => self.calificacion(plato)}.cocinero()
 
 // Variante, si en vez de cocinar el plato en el momento de inscribirse, lo hace al momento de obtener el ganador
 // En este caso, el plato no necesita conocer al cocinero que lo hizo la momento de cocinarse
 //  method ganador() = cocineros.max{cocinero => self.calificacion(cocinero.cocinar())}
}