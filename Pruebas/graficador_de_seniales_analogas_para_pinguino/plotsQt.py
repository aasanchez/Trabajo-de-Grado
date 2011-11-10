# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'plotsQt.ui'
#
# Created: Sat Aug 20 18:00:01 2011
#      by: PyQt4 UI code generator 4.8.3
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
        self.centralwidget = QtGui.QWidget(MainWindow)
        self.centralwidget.setObjectName(_fromUtf8("centralwidget"))
        self.gridLayout = QtGui.QGridLayout(self.centralwidget)
        self.gridLayout.setObjectName(_fromUtf8("gridLayout"))
        self.qwtPlot = QwtPlot(self.centralwidget)
        self.qwtPlot.setFrameShape(QtGui.QFrame.NoFrame)
        self.qwtPlot.setObjectName(_fromUtf8("qwtPlot"))
        self.gridLayout.addWidget(self.qwtPlot, 0, 0, 1, 1)
        MainWindow.setCentralWidget(self.centralwidget)
        self.statusBar = QtGui.QStatusBar(MainWindow)
        self.statusBar.setObjectName(_fromUtf8("statusBar"))
        MainWindow.setStatusBar(self.statusBar)
        self.dockWidget = QtGui.QDockWidget(MainWindow)
        self.dockWidget.setMinimumSize(QtCore.QSize(230, 465))
        self.dockWidget.setMaximumSize(QtCore.QSize(230, 524287))
        font = QtGui.QFont()
        font.setWeight(50)
        font.setBold(False)
        self.dockWidget.setFont(font)
        self.dockWidget.setAllowedAreas(QtCore.Qt.LeftDockWidgetArea|QtCore.Qt.RightDockWidgetArea)
        self.dockWidget.setObjectName(_fromUtf8("dockWidget"))
        self.dockWidgetContents = QtGui.QWidget()
        self.dockWidgetContents.setObjectName(_fromUtf8("dockWidgetContents"))
        self.gridLayout_2 = QtGui.QGridLayout(self.dockWidgetContents)
        self.gridLayout_2.setObjectName(_fromUtf8("gridLayout_2"))
        self.frame = QtGui.QFrame(self.dockWidgetContents)
        self.frame.setFrameShape(QtGui.QFrame.StyledPanel)
        self.frame.setFrameShadow(QtGui.QFrame.Raised)
        self.frame.setObjectName(_fromUtf8("frame"))
        self.gridLayout_3 = QtGui.QGridLayout(self.frame)
        self.gridLayout_3.setObjectName(_fromUtf8("gridLayout_3"))
        self.checkBox13 = QtGui.QCheckBox(self.frame)
        self.checkBox13.setChecked(True)
        self.checkBox13.setObjectName(_fromUtf8("checkBox13"))
        self.gridLayout_3.addWidget(self.checkBox13, 0, 0, 1, 1)
        self.checkBox14 = QtGui.QCheckBox(self.frame)
        self.checkBox14.setObjectName(_fromUtf8("checkBox14"))
        self.gridLayout_3.addWidget(self.checkBox14, 1, 0, 1, 1)
        self.checkBox15 = QtGui.QCheckBox(self.frame)
        self.checkBox15.setObjectName(_fromUtf8("checkBox15"))
        self.gridLayout_3.addWidget(self.checkBox15, 2, 0, 1, 1)
        spacerItem = QtGui.QSpacerItem(48, 28, QtGui.QSizePolicy.Minimum, QtGui.QSizePolicy.Fixed)
        self.gridLayout_3.addItem(spacerItem, 5, 0, 1, 1)
        self.radioButton_analog = QtGui.QRadioButton(self.frame)
        self.radioButton_analog.setChecked(True)
        self.radioButton_analog.setObjectName(_fromUtf8("radioButton_analog"))
        self.gridLayout_3.addWidget(self.radioButton_analog, 6, 0, 1, 1)
        self.radioButton_voltaje = QtGui.QRadioButton(self.frame)
        self.radioButton_voltaje.setObjectName(_fromUtf8("radioButton_voltaje"))
        self.gridLayout_3.addWidget(self.radioButton_voltaje, 7, 0, 1, 1)
        spacerItem1 = QtGui.QSpacerItem(20, 40, QtGui.QSizePolicy.Minimum, QtGui.QSizePolicy.Fixed)
        self.gridLayout_3.addItem(spacerItem1, 8, 0, 1, 1)
        self.checkBox_auto = QtGui.QCheckBox(self.frame)
        self.checkBox_auto.setObjectName(_fromUtf8("checkBox_auto"))
        self.gridLayout_3.addWidget(self.checkBox_auto, 9, 0, 1, 1)
        spacerItem2 = QtGui.QSpacerItem(189, 28, QtGui.QSizePolicy.Minimum, QtGui.QSizePolicy.Fixed)
        self.gridLayout_3.addItem(spacerItem2, 10, 0, 1, 1)
        self.pushButton_iniciar = QtGui.QPushButton(self.frame)
        self.pushButton_iniciar.setCheckable(True)
        self.pushButton_iniciar.setChecked(False)
        self.pushButton_iniciar.setAutoDefault(False)
        self.pushButton_iniciar.setDefault(False)
        self.pushButton_iniciar.setObjectName(_fromUtf8("pushButton_iniciar"))
        self.gridLayout_3.addWidget(self.pushButton_iniciar, 11, 0, 1, 1)
        spacerItem3 = QtGui.QSpacerItem(20, 142, QtGui.QSizePolicy.Minimum, QtGui.QSizePolicy.Expanding)
        self.gridLayout_3.addItem(spacerItem3, 12, 0, 1, 1)
        self.gridLayout_2.addWidget(self.frame, 0, 0, 1, 1)
        self.dockWidget.setWidget(self.dockWidgetContents)
        MainWindow.addDockWidget(QtCore.Qt.DockWidgetArea(2), self.dockWidget)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(QtGui.QApplication.translate("MainWindow", "Lectura ADXL335", None, QtGui.QApplication.UnicodeUTF8))
        self.statusBar.setStatusTip(QtGui.QApplication.translate("MainWindow", "Alexis A. Sanchez O.", None, QtGui.QApplication.UnicodeUTF8))
        self.checkBox13.setText(QtGui.QApplication.translate("MainWindow", "Z", None, QtGui.QApplication.UnicodeUTF8))
        self.checkBox14.setText(QtGui.QApplication.translate("MainWindow", "Y", None, QtGui.QApplication.UnicodeUTF8))
        self.checkBox15.setText(QtGui.QApplication.translate("MainWindow", "X", None, QtGui.QApplication.UnicodeUTF8))
        self.radioButton_analog.setText(QtGui.QApplication.translate("MainWindow", "Mostrar valor análogo", None, QtGui.QApplication.UnicodeUTF8))
        self.radioButton_voltaje.setText(QtGui.QApplication.translate("MainWindow", "Mostrar tensión", None, QtGui.QApplication.UnicodeUTF8))
        self.checkBox_auto.setText(QtGui.QApplication.translate("MainWindow", "Autoescala", None, QtGui.QApplication.UnicodeUTF8))
        self.pushButton_iniciar.setText(QtGui.QApplication.translate("MainWindow", "Iniciar", None, QtGui.QApplication.UnicodeUTF8))

from PyQt4.Qwt5 import *
