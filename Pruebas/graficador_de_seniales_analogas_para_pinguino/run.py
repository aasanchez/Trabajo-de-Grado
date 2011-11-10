#! /usr/bin/python
#-*- coding: utf-8 -*-

u"""Ejemplo para el uso y configuración de Qwt (QwtPlot) para plotear
señales análogas tomadas con Pinguino (PIC18F2550). 
"""

from metodos import *
from PyQt4.Qt import *

import sys

def main(args):
    app=QApplication(args)
    frame=Metodos()
    frame.show()
    sys.exit(app.exec_())

if __name__=='__main__':
    main(sys.argv)