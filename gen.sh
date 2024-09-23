#!/bin/bash

# Nombre base para los módulos
MODULES=("Modulo1_Introduccion_Azure_Databricks" "Modulo2_Fundamentos_Apache_Spark_PySpark" "Modulo3_Introduccion_Python" "Modulo4_Azure_Databricks_Notebooks" "Modulo5_Ingesta_Transformacion_Datos" "Modulo6_Analisis_Datos_Machine_Learning" "Modulo7_Optimizacion_Mejores_Practicas")

# Títulos principales (Main Themes) de cada módulo
MAIN_THEMES=(
    "Introduccion_Computacion_Nube_Azure"
    "Conceptos_Basicos_Databricks"
    "Configuracion_Inicial_Azure"
    "Creacion_Workspace_Azure_Databricks"
    
    "Introduccion_Apache_Spark"
    "Introduccion_PySpark"
    "DataFrames_SQL_PySpark"
    
    "Fundamentos_Python"
    "Funciones_Modulos_Python"
    "Manejo_Excepciones_Archivos_Python"
    
    "Introduccion_Notebooks_Databricks"
    "Uso_Python_Notebooks_Databricks"
    "Ejemplos_Basicos_Databricks"
    
    "Cargando_Datos_Azure_Databricks"
    "Transformacion_Datos_PySpark"
    "Ejecucion_Procesos_Lotes"
    
    "Analisis_Exploratorio_Datos"
    "Introduccion_MLlib"
    
    "Optimizacion_Consultas_Jobs_Databricks"
    "Mejores_Practicas_Databricks"
)

# Subtemas (bullets) de cada main theme (a nivel de archivo markdown)
SUBTHEMES=(
    "Conceptos_basicos_computacion_nube.md"
    "Beneficios_usar_nube.md"
    "Introduccion_Microsoft_Azure.md"
    "Modelos_servicio_nube.md"
    "Modelos_implementacion_nube.md"
    "Laboratorio_portal_Azure.md"
    
    "Que_es_Databricks.md"
    "Historia_evolucion_Databricks.md"
    "Beneficios_casos_uso_Databricks.md"
    "Integracion_Azure.md"
    "Laboratorio_interfaz_Databricks.md"
    
    "Navegacion_portal_Azure.md"
    "Gestion_recursos_Azure.md"
    "Laboratorio_configuracion_Databricks.md"
    
    "Crear_recurso_Databricks_Azure.md"
    "Configuracion_basica_workspace.md"
    "Configuracion_avanzada_workspace.md"
    "Laboratorio_crear_cluster.md"
    "Laboratorio_configuracion_cluster.md"

    "Historia_Apache_Spark.md"
    "Arquitectura_Spark.md"
    "Componentes_Spark.md"
    "Ciclo_vida_aplicacion_Spark.md"
    "Laboratorio_crear_cluster_Spark.md"

    "Que_es_PySpark.md"
    "Instalacion_configuracion_PySpark.md"
    "Comparativa_PySpark_frameworks.md"
    "Laboratorio_RDDs.md"
    "Laboratorio_DataFrames.md"

    "Creacion_Manipulacion_DataFrames.md"
    "Operaciones_basicas_DataFrames.md"
    "Ejecucion_consultas_SQL.md"
    "Optimizacion_consultas_SQL_Spark.md"
    "Laboratorio_operaciones_DataFrames.md"
    "Laboratorio_SQL_DataFrames.md"
    
    "Historia_Python.md"
    "Instalacion_configuracion_Python.md"
    "Sintaxis_estructuras_control.md"
    "Laboratorio_scripts_basicos_Python.md"
    "Laboratorio_estructuras_control.md"

    "Definicion_funciones_Python.md"
    "Modulos_paquetes_Python.md"
    "Gestion_dependencias_pip.md"
    "Laboratorio_funciones_modulos.md"
    
    "Manejo_excepciones_Python.md"
    "Lectura_escritura_archivos.md"
    "Contextos_manejo_archivos.md"
    "Laboratorio_manejo_excepciones_archivos.md"

    "Que_es_Notebook.md"
    "Creacion_configuracion_Notebooks.md"
    "Buenas_practicas_Notebooks.md"
    "Laboratorio_creacion_Notebooks.md"
    
    "Escribir_codigo_Python_Notebook.md"
    "Celdas_magicas_Notebook.md"
    "Uso_librerias_externas.md"
    "Laboratorio_visualizacion_datos.md"
    
    "Lectura_escritura_datos.md"
    "Transformaciones_basicas_datos.md"
    "Manejo_excepciones_Notebooks.md"
    "Laboratorio_transfromaciones.md"

    "Cargar_datos_Azure_Blob_Storage.md"
    "Integracion_fuentes_datos.md"
    "Laboratorio_ingesta_datos.md"
    
    "Operaciones_transformacion_datos.md"
    "Uso_UDFs.md"
    "Optimizacion_transformaciones.md"
    "Laboratorio_transformacion_datos.md"
    
    "Creacion_pipeline_lotes.md"
    "Automatizacion_tareas.md"
    "Mejores_practicas_lotes.md"
    "Laboratorio_procesos_lotes.md"

    "EDA_PySpark.md"
    "Visualizacion_datos.md"
    "Uso_estadisticas_descriptivas.md"
    "Laboratorio_eda_datos.md"
    
    "Que_es_MLlib.md"
    "Algoritmos_disponibles_MLlib.md"
    "Casos_uso_MLlib.md"

    "Optimizacion_consultas_SQL.md"
    "Configuracion_Spark_rendimiento.md"
    "Uso_Spark_UI.md"
    "Laboratorio_optimizacion_consultas.md"
    
    "Gestion_cluster.md"
    "Seguridad_control_acceso.md"
    "Monitoreo_depuracion.md"
    "Laboratorio_gestion_cluster.md"
)

# Crear carpetas de módulos
for module in "${MODULES[@]}"; do
  mkdir -p "$module"
done

# Crear carpetas de main themes y archivos markdown
for i in {0..6}; do
  for j in {0..3}; do
    index=$((i * 4 + j))
    MAIN_THEME="${MAIN_THEMES[index]}"
    MODULE="${MODULES[i]}"
    
    mkdir -p "$MODULE/$MAIN_THEME"
    
    # Crear un README.md para cada main theme
    echo "# $MAIN_THEME" > "$MODULE/$MAIN_THEME/README.md"
    
    # Crear archivos markdown vacíos para cada bullet point
    for subtheme in "${SUBTHEMES[@]:$((j*5)):5}"; do
      touch "$MODULE/$MAIN_THEME/$subtheme"
      echo "- [$subtheme]($subtheme)" >> "$MODULE/$MAIN_THEME/README.md"
    done
  done
done

# Crear un README.md principal con enlaces a cada main theme
echo "# Curso de Azure y Databricks con PySpark" > README.md

for i in {0..6}; do
  MODULE="${MODULES[i]}"
  echo "## [$MODULE](./$MODULE)" >> README.md
  for j in {0..3}; do
    index=$((i * 4 + j))
    MAIN_THEME="${MAIN_THEMES[index]}"
    echo "- [$MAIN_THEME](./$MODULE/$MAIN_THEME/README.md)" >> README.md
  done
done

echo "Estructura de archivos y carpetas generada exitosamente."
