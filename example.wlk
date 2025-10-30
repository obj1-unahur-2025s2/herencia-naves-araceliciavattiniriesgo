//LOOK AT METHOD

class Nave {// clase abstracta 
  var velocidad
  var dirAlSol = 0
  var combustible = 0
  method acelerar(cuanto) { velocidad = 100000.min(velocidad + cuanto) }
  method desacelerar(cuanto){ velocidad = 0.max(velocidad - cuanto) }
  method irHaciaElSol(){ dirAlSol = 10 }
  method escaparDelSol(){ dirAlSol = -10 }
  method ponerseParaleloAlSol(){ dirAlSol = 0} 
  method acercarseUnPocoAlSol(){ dirAlSol = (dirAlSol + 1).min(10) }
  method alejarseUnPocoDelSol() { dirAlSol = (dirAlSol - 1).max(-10) }

  method prepararViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
    self.accionAdicional()
  }

  method cargarCombustible(cuanto){ combustible =+ cuanto  }
  method descargarCombustible(cuanto){ combustible = 0.max(combustible - cuanto) }

  method accionAdicional()
  method estaTranquila(){
    return combustible >= 4000 && velocidad < 12000 && self.condicionAdicional()
  }

  method condicionAdicional()
  method recibirAmenaza(){
    self.escapar()
    self.avisar()
  }

  method escapar()
  method avisar()

  method estaDeRelajo(){
    return self.estaTranquila() && self.tienePocaActividad()
  }

  method tienePocaActividad()
}

class NaveBaliza inherits Nave {
  var colorBaliza 
  var cambioBaliza = false
  method initialize(){

  }

  method cambiarColorBaliza(colorNuevo){ 
    cambioBaliza = true
    colorBaliza = colorNuevo 
  }

  override method accionAdicional(){
    self.cambiarColorBaliza("verde")
    self.ponerseParaleloAlSol()
  }

  override method condicionAdicional(){
    return colorBaliza != 'rojo'
  }

  override method escapar(){
    self.irHaciaElSol()
  }

  override method avisar(){
    self.cambiarColorBaliza('rojo')
  }

  override method tienePocaActividad() = !cambioBaliza

}

class NavePasajeros inherits Nave{
  const pasajeros
  var comida = 0
  var bebida = 0
  var comidaServida = 0

  method cargar(cantBebidas,cantComidas){
    comidaServida += cantComidas
    bebida = bebida +  cantBebidas
    comida = comida +  cantComidas
  }

  method descargar(cantBebidas,cantComidas){
    comidaServida += cantComidas
    bebida = 0.max(bebida -  cantBebidas)
    comida = 0.max(comida -  cantComidas)
  }

  override method accionAdicional(){
    self.cargar(4*pasajeros,6*pasajeros)
    self.acercarseUnPocoAlSol()
  }

  override method condicionAdicional(){
    return true
  }

  override method escapar(){
    self.acelerar(velocidad * 2)
  }

  override method avisar(){
    self.descargar(pasajeros * 2, pasajeros * 1)
  }

  override method tienePocaActividad(){
    return comidaServida < 50
  }

}

class NaveCombate inherits Nave{
  var visible = true
  var misilesDesplegados = false
  const mensajes = [] 
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
    return mensajes.first()
  }

  method ultimoMensajeEmitido() {
    if (mensajes.isEmpty()){
      self.error("La lista mensajes esta vacia")
    }
    return mensajes.last()
  }

  method esEscueta(){ return mensajes.all({m=>m.length()<30}) }
  method emitioMensaje(mensaje){ mensajes.contains(mensaje) }

  override method accionAdicional(){
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en Mision")
  }

  override method condicionAdicional(){
    return !misilesDesplegados
  }

  override method escapar(){
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }

  override method avisar(){
    self.emitirMensaje('Amenaza recibida')
  }

  override method tienePocaActividad() {
    return true
  } 
}

class NaveHospital inherits NavePasajeros{
  var quirofanosPreparados = false

  override method condicionAdicional(){
    return !quirofanosPreparados
  }

  method prepararQuirofanos(){
    quirofanosPreparados = true
  }

  override method recibirAmenaza(){
    super()
    self.prepararQuirofanos()
  }

  override method tienePocaActividad() {
    return true
  } 


}

class NaveSigilosa inherits NaveCombate {

  override method condicionAdicional(){
    return super() && !self.estaInvisible()
  }

  override method escapar(){
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }


}