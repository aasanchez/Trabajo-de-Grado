#! /usr/bin/python
#-*- coding: utf-8 -*-

from pynguino import PinguinoProcessing
from plotsQt import *
from PyQt4.Qt import *
from PyQt4.Qwt5.anynumpy import *

no_pinguino=u"""No se ha detectado ningún dispositivo pinguino conectado,
por favor revise la conexión e inténtelo de nuevo.\n
Asegúrese de tener en el pinguino el código de pynguino.pde."""

class Metodos(QtGui.QMainWindow):
    def __init__(self, *args):
               
        QtGui.QMainWindow.__init__(self)
        self.ventana=Ui_MainWindow()
        self.ventana.setupUi(self)
        
        self.ventana.qwtPlot.setCanvasBackground(Qt.white)
        self.ventana.qwtPlot.setTitle("Lectura Canales Analogicos")
        self.ventana.qwtPlot.insertLegend(Qwt.QwtLegend(), Qwt.QwtPlot.BottomLegend);
        #self.ventana.qwtPlot.setAxisTitle(Qwt.QwtPlot.xBottom, "Cantidad de valores tomados")
        #self.ventana.qwtPlot.setAxisTitle(Qwt.QwtPlot.yLeft, u"Lectura análoga")
        
        self.all_checks=[self.ventana.checkBox13,self.ventana.checkBox14,self.ventana.checkBox15]
        
        self.maximo=100
        self.primera=True
        
        self.crear_lineas()
        self.crear_escalas()
        self.ajustar_lineas()
        self.ajustar_eje()
        self.autoescala()
        self.centrar()
        
        self.connect(self.ventana.pushButton_iniciar, QtCore.SIGNAL("clicked()"), self.iniciar)
        
        for check in self.all_checks:    
            self.connect(check, QtCore.SIGNAL("clicked()"), self.ajustar_lineas)
        self.connect(self.ventana.radioButton_analog, QtCore.SIGNAL("clicked()"), self.ajustar_eje)
        self.connect(self.ventana.radioButton_voltaje, QtCore.SIGNAL("clicked()"), self.ajustar_eje)
        self.connect(self.ventana.checkBox_auto, QtCore.SIGNAL("clicked()"), self.autoescala)  
            
        #mY = Qwt.QwtPlotMarker()
        #mY.setLabelAlignment(Qt.AlignRight | Qt.AlignTop)
        #mY.setLineStyle(Qwt.QwtPlotMarker.HLine)
        #mY.setYValue(0.0)
        #mY.attach(self.ventana.qwtPlot)
        
        #sY = Qwt.QwtPlotMarker()
        #sY.setLabelAlignment(Qt.AlignRight | Qt.AlignTop)
        #sY.setLineStyle(Qwt.QwtPlotMarker.HLine)
        #sY.setYValue(1023)
        #sY.attach(self.ventana.qwtPlot)
        
        gr=Qwt.QwtPlotGrid()
        gr.setPen(QPen(Qt.gray))
        gr.enableX(1)
        #gr.enableXMin(1)
        gr.enableY(1)
        #gr.enableYMin(1)
        gr.attach(self.ventana.qwtPlot)
        
    #----------------------------------------------------------------------
    def centrar(self):
            screen = QtGui.QDesktopWidget().screenGeometry()
            size =  self.geometry()
            self.move((screen.width()-size.width())/2, (screen.height()-size.height())/2)
        
    #----------------------------------------------------------------------
    def autoescala(self):
        if not self.ventana.checkBox_auto.isChecked():
            self.follow.attach(self.ventana.qwtPlot) 
        else: self.follow.detach()
            
    #----------------------------------------------------------------------
    def ajustar_eje(self):
        if self.ventana.radioButton_analog.isChecked():
            self.ventana.qwtPlot.setAxisTitle(Qwt.QwtPlot.yLeft, u"Lectura análoga")
        else: self.ventana.qwtPlot.setAxisTitle(Qwt.QwtPlot.yLeft, u"Tensión (V)")

    #----------------------------------------------------------------------
    def conectarPinguino(self):
        self.pinguino=PinguinoProcessing()
        if not self.pinguino.RecursiveConect(): self.criticalMessage() 
        for pin in range(13,18):
            self.pinguino.pinMode(pin,"input")
        
    #----------------------------------------------------------------------
    def criticalMessage(self):    
        reply = QtGui.QMessageBox.critical(self, "Error",
                no_pinguino,
                QtGui.QMessageBox.Abort | QtGui.QMessageBox.Retry)
        if reply == QtGui.QMessageBox.Abort:
            pass
        elif reply == QtGui.QMessageBox.Retry:
            try:
                self.pinguino.reset()
                self.pinguino.ProcessingClose()
                del(self.pinguino)
            except: pass
            self.conectarPinguino()
    
    #----------------------------------------------------------------------
    def crear_escalas(self):
        self.cantidad_valores=arange(0, self.maximo, 1)
        self.valores_pin13=zeros(len(self.cantidad_valores))#,Float)
        self.valores_pin14=zeros(len(self.cantidad_valores))
        self.valores_pin15=zeros(len(self.cantidad_valores))
        self.all_valores=[self.valores_pin13,self.valores_pin14,self.valores_pin15]
        
    #----------------------------------------------------------------------
    def crear_lineas(self):
        self.pin13=Qwt.QwtPlotCurve("Z")
        self.pin13.setPen(QPen(Qt.cyan)) 
        
        self.pin14=Qwt.QwtPlotCurve("Y")
        self.pin14.setPen(QPen(Qt.magenta))
        
        self.pin15=Qwt.QwtPlotCurve("X")
        self.pin15.setPen(QPen(Qt.green))
                
        self.follow=Qwt.QwtPlotCurve("AutoRango")
        self.follow.setPen(QPen(Qt.white))
        self.follow.hide()
        
        self.all_lineas=[self.pin13,self.pin14,self.pin15]
        
    #----------------------------------------------------------------------
    def ajustar_lineas(self):
        for i in range(3):
            if self.all_checks[i].isChecked():
                self.all_lineas[i].attach(self.ventana.qwtPlot) 
            else: self.all_lineas[i].detach()
          
    #----------------------------------------------------------------------
    def iniciar(self):
        if self.primera:
            self.conectarPinguino()
            self.valor=0
            self.pause=False
            self.primera=False
            self.ventana.pushButton_iniciar.setText("Pausar")
            return self.startTimer(50)   
        
        if self.ventana.pushButton_iniciar.isChecked():
            self.ventana.pushButton_iniciar.setText("Pausar")
            self.pause=False
        else:
            self.ventana.pushButton_iniciar.setText("Iniciar")
            self.pause=True
            
    #----------------------------------------------------------------------
    def timerEvent(self,argumento_obligatorio):
        if not self.pause:
            
            #if self.valor>self.maximo:
                #self.cantidad_valores=concatenate((self.cantidad_valores[1:],[self.cantidad_valores[-1]+1]),1)
                #self.cantidad_valores=arange(self.valor, self.maximo+self.valor, 1)
                
            for i in range(3):
                if self.ventana.radioButton_analog.isChecked():
                    value=self.pinguino.analogRead(i+13)
                    max_scale=1023
                else:
                    value=(self.pinguino.analogRead(i+13)/1023.0)*5
                    max_scale=5
                    
                if self.valor<self.maximo:
                    self.all_valores[i][self.valor]=value
                else:
                    self.all_valores[i]=concatenate((self.all_valores[i][1:],[value]),1)

                self.all_lineas[i].setData(self.cantidad_valores,self.all_valores[i])
                
            self.follow.setData([0,1],[0,max_scale])
            self.ventana.qwtPlot.replot()
            self.valor+=1
