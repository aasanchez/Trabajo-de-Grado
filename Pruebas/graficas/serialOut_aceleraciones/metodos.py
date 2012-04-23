#! /usr/bin/python
#-*- coding: utf-8 -*-

import serial
from plotsQt import *
from PyQt4.Qt import *
from PyQt4.Qwt5.anynumpy import *

class Metodos(QtGui.QMainWindow):
    def __init__(self, *args):
               
        QtGui.QMainWindow.__init__(self)
        self.ventana=Ui_MainWindow()
        self.ventana.setupUi(self)
        
        self.setWindowTitle("Graficador USB")
        
        #color de fondo
        self.ventana.qwtPlot.setCanvasBackground(Qt.white)
        
        #leyendas
        self.ventana.qwtPlot.setTitle("Aceleraciones")
        self.ventana.qwtPlot.setAxisTitle(Qwt.QwtPlot.yLeft, "Lectura")
        self.ventana.qwtPlot.setAxisTitle(Qwt.QwtPlot.xBottom, "Tiempo")
        
        #aplicar leyendas
        self.ventana.qwtPlot.insertLegend(Qwt.QwtLegend(), Qwt.QwtPlot.BottomLegend)
        
        
        self.maximo=100  #máxima cantidad de valores en x, (en y es automático)
        self.primer_vez=True  #para controlar la conexión (ver iniciar())
        
        self.frecuencia = 20
        
        self.crear_lineas()
        self.crear_escalas()
        self.centrar()
        
        self.connect(self.ventana.pushButton_iniciar, QtCore.SIGNAL("clicked()"), self.iniciar)
        
        #agregar las rejillas
        gr=Qwt.QwtPlotGrid()
        gr.setPen(QPen(Qt.gray))
        gr.enableX(1)
        gr.enableY(1)
        gr.attach(self.ventana.qwtPlot)
        
    
    #----------------------------------------------------------------------
    def centrar(self):
        #centrar la ventana en la pantalla
        screen = QtGui.QDesktopWidget().screenGeometry()
        size =  self.geometry()
        self.move((screen.width()-size.width())/2, (screen.height()-size.height())/2)
        

    #----------------------------------------------------------------------
    def conectarPinguino(self):
        #intenta conectarse con el primero que pueda de los primeros 20 puertos
        for port in range(20):
            try:
                self.pinguino = serial.Serial('/dev/ttyUSB%s' %port, timeout=1)
                return True
            except: pass
        return False
        

    #----------------------------------------------------------------------
    def crear_escalas(self):
        #constantemente hay 6 listas de 100 valores cada una para graficarlas 
        self.cantidad_valores=arange(0, self.maximo, 1)
        valores_1=zeros(len(self.cantidad_valores))#,Float)
        valores_2=zeros(len(self.cantidad_valores))
        valores_3=zeros(len(self.cantidad_valores))
        valores_4=zeros(len(self.cantidad_valores))
        self.all_valores=[valores_1, valores_2, valores_3, valores_4]
        
    #----------------------------------------------------------------------
    def crear_lineas(self):
        #se crean cada linea que se va a graficar y se le asigna un color,
        #al final se agregan todas en una lista y se activan (attach)
        
        valor1=Qwt.QwtPlotCurve("Accel Y")
        valor1.setPen(QPen(Qt.cyan)) 
        
        valor2=Qwt.QwtPlotCurve("Accel X")
        valor2.setPen(QPen(Qt.magenta))
        
        valor3=Qwt.QwtPlotCurve("ACC_angle")
        valor3.setPen(QPen(Qt.green))
        
        valor4=Qwt.QwtPlotCurve("actAngle")
        valor4.setPen(QPen(Qt.red))
        
        self.all_lineas=[valor1, valor2, valor3, valor4]
        for linea in self.all_lineas:  linea.attach(self.ventana.qwtPlot) 
        
    #----------------------------------------------------------------------
    def iniciar(self):
        if self.primer_vez:
            #la primera ejecusión desde que se inicia el programa
            if not self.conectarPinguino(): return
            self.valor=0
            self.pause=False
            self.primer_vez=False
            self.ventana.pushButton_iniciar.setText("Pausar")
            return self.startTimer(self.frecuencia)   
        
        #para pausar el ploteado
        if self.ventana.pushButton_iniciar.isChecked():
            self.ventana.pushButton_iniciar.setText("Pausar")
            self.pause=False
        else:
            self.ventana.pushButton_iniciar.setText("Iniciar")
            self.pause=True
            
            
    #
    # ----------------------------------------------------------------------
    def getData(self):
        #retorna una lista con los valores leidos

        data = self.pinguino.readline() 
        data_string_list = data.split(",")
        
        data_int_list = map(lambda i : int (i), [i for i in data_string_list if i != ""])

        if len(data_int_list) == 4:
            #depronto sea útil ver los valores en la statusbar :)
            self.ventana.statusBar.showMessage(str(data_int_list))
            return data_int_list
        else: return [0, 0, 0, 0]  #por si ha ocurrido un error
        
            
    #----------------------------------------------------------------------
    def timerEvent(self, time):
        #aquí se plotea :)
        
        #la función setData es de Qwt, NO está relacionada con getData
        
        #básicamente toma cada una de las 6 listas que se está ploteando
        #elimina el primer valor, agrega el nuevo al final,
        #y actualiza la grafica (self.ventana.qwtPlot.replot())
    
        if not self.pause:
            data = self.getData()
            for i in range(4):
                value = data[i]
                
                if self.valor<self.maximo: self.all_valores[i][self.valor]=value
                else:  self.all_valores[i]=concatenate((self.all_valores[i][1:],[value]),1)

                self.all_lineas[i].setData(self.cantidad_valores,self.all_valores[i])
                
            self.ventana.qwtPlot.replot()
            self.valor+=1
