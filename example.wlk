class Nave {
  var velocidad
  var dirAlSol = 0
  method acelerar(cuanto) {
    velocidad = 100000.min(velocidad + cuanto)
  }

  method desacelerar(cuanto){
    velocidad = 0.max(velocidad - cuanto)
  }

  method irHaciaElSol(){ dirAlSol = 10 }
  method escaparDelSol(){ dirAlSol = -10 }
  method ponerseParaleloAlSol(){ dirAlSol = 0} 

  method acercarseUnPocoAlSol(){
    dirAlSol = (dirAlSol + 1).min(10)
  }

  method alejarseUnPocoDelSol() {
    dirAlSol = (dirAlSol - 1).max(-10)
  }

}

class NaveBaliza inherits Nave {
  var colorBaliza 

  method cambiarColorBaliza(colorNuevo){
    colorBaliza = colorNuevo
  }
}

class NavePasajeros inherits Nave{
  const pasajeros
  var comida = 0
  var bebida = 0

  method cargar(cantBebidas,cantComidas){
    bebida = bebida +  cantBebidas
    comida = comida +  cantComidas
  }

  method descargar(cantBebidas,cantComidas){
    bebida = 0.max(bebida -  cantBebidas)
    comida = 0.max(comida -  cantComidas)
  }


}

class NaveCombate inherits Nave{
  var visible = true
  var misilesDesplegados = false
  const mensajes = [] // new List() 

  method ponerseVisible(){ visible = true }
  method ponerseInvisible() { visible = false }
  method estaInvisible() = !visible

  method misiblesDesplegados() = misilesDesplegados
  method desplegarMisiles() { misilesDesplegados = true}
  method replegarMisiles() { misilesDesplegados = false }

  method emitirMensaje(mensaje){ mensajes.add(mensaje) }
  method mensajesEmitidos() = mensajes.size()
  method primerMensajeEmitido() {
    if (mensajes.isEmpty()){
      self.error("La lista mensajes esta vacia")
    }
  }//= mensajes.first()
  


}
