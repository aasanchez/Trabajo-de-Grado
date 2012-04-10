# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'plotsQt.ui'
#
# Created: Wed Feb 15 15:32:50 2012
#      by: PyQt4 UI code generator 4.8.5
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    _fromUtf8 = lambda s: s

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName(_fromUtf8("MainWindow"))
        MainWindow.resize(938, 487)
        MainWindow.setWindowTitle(QtGui.QApplication.translate("MainWindow", "title", None, QtGui.QApplication.UnicodeUTF8))
        self.centralwidget = QtGui.QWidget(MainWindow)
        self.centralwidget.setObjectName(_fromUtf8("centralwidget"))
        self.gridLayout = QtGui.QGridLayout(self.centralwidget)
        self.gridLayout.setObjectName(_fromUtf8("gridLayout"))
        self.qwtPlot = QwtPlot(self.centralwidget)
        self.qwtPlot.setFrameShape(QtGui.QFrame.NoFrame)
        self.qwtPlot.setObjectName(_fromUtf8("qwtPlot"))
        self.gridLayout.addWidget(self.qwtPlot, 1, 0, 1, 1)
        self.pushButton_iniciar = QtGui.QPushButton(self.centralwidget)
        self.pushButton_iniciar.setText(QtGui.QApplication.translate("MainWindow", "Iniciar", None, QtGui.QApplication.UnicodeUTF8))
        self.pushButton_iniciar.setCheckable(True)
        self.pushButton_iniciar.setChecked(False)
        self.pushButton_iniciar.setAutoDefault(False)
        self.pushButton_iniciar.setDefault(False)
        self.pushButton_iniciar.setObjectName(_fromUtf8("pushButton_iniciar"))
        self.gridLayout.addWidget(self.pushButton_iniciar, 2, 0, 1, 1)
        MainWindow.setCentralWidget(self.centralwidget)
        self.statusBar = QtGui.QStatusBar(MainWindow)
        self.statusBar.setObjectName(_fromUtf8("statusBar"))
        MainWindow.setStatusBar(self.statusBar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        pass

from PyQt4.Qwt5 import *
