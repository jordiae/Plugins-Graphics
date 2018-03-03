#ifndef _REFLECTION_H
#define _REFLECTION_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>


class Reflection : public QObject, public BasicPlugin
{
     Q_OBJECT
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
     Q_INTERFACES(BasicPlugin)

 public:
    void onPluginLoad();
    bool paintGL();
    void onObjectAdd();
 
 private:
    QOpenGLShaderProgram* program;
    QOpenGLShader* vs;
    QOpenGLShader* fs;  
    GLuint textureId;

    // afegit per reflection:
    bool reflectionCreated;

    void drawReflection(GLWidget &g);
 };
 
 #endif
