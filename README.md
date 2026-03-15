# Proyecto Transversal: Gestión de Proyectos de Investigación y Ciencia Abierta

# Artículo a reproducir  
**Are Cryptocurrencies Currencies? Bitcoin as Legal Tender in El Salvador**  
Fernando Alvarez, David Argente y Diana Van Patten  

# Integrantes del equipo y sus respectivos roles
Maria Camila Caraballo: Coordinación del repositorio y apoyo en replicación empírica 
Laura Sarif Rivera Sanabria: Limpieza de datos y estructuración del pipeline de código
Zaira Alejandra Garcia Bernal: Limpieza de datos y estructuración del pipeline de código
Sergio Andres Melo Garcia: Automatización, reproducibilidad y control de versiones 

# Descripción general del proyecto 
El propósito de este ejercicio es el de replicar los hallazgos encontrados por Fernando Alvarez, David Argente y Diana Van Patten en su artículo de investigación "Are cryptocurrencies currencies? Bitcoin as legal tender in El Salvador" como parte de la clase de gestión de proyectos de investigación y ciencia abierta. La replicación se realizará utilizando los insumos de replicación proporcionados por los autores, siguiendo principios de ciencia abierta y buenas prácticas de gestión de proyectos de investigación. El objetivo es reconstruir los resultados principales del paper y documentar de manera clara el proceso, los desafíos encontrados y las decisiones metodológicas tomadas.

La estructura del proyecto se ve de la siguiente manera:
<pre>
proyecto_transversal/
│
├── data/
│   ├── raw/              # Datos originales
│   ├── processed/        # Datos transformados
│
├── code/
│   ├── original/         # Scripts originales descargados de Zenodo
│   ├── replication/      # Scripts modificados para ejecución local
│
├── output/
│   ├── figures/          # Gráficas reproducidas
│
├── docs/
│   ├── avance1.pdf
│   ├── avance2.pdf
│   ├── final_proyecto_transversal.pdf
│
└── README.md
</pre>

# Fuentes de datos
Repositorio en Zenodo:
- DOI: 10.5281/zenodo.8206117

Repositorio en Dryad:
- DOI: 10.5061/dryad.z8w9ghxjm

# Requisitos iniciales identificados
- Acceso a los datos y scripts originales del artículo  
- Git y GitHub para control de versiones  
- Stata 16
- Paquetes estadísticos y de visualización (reghdfe, gtools, spmap)
- Entorno reproducible (renv o equivalente)  
- Documentación clara del flujo de trabajo  


# Cómo ejecutar la replicación

Para reproducir los resultados generados en este repositorio:

1. Clonar el repositorio

2. Abrir Stata.

3. Ejecutar el siguiente script desde la raíz del proyecto con el siguiente comando-> do run_replication.do


El script utiliza rutas relativas, por lo que el código puede ejecutarse en diferentes computadores siempre que se mantenga la estructura del repositorio.

Durante la ejecución se cargan los datos ubicados en: data/raw

y los resultados se guardan automáticamente en:output/figures

---

# Resultados generados

La ejecución del código de replicación produce las siguientes figuras:

- **FigureS24_replication.png**  
  Replica de la Figura S24: *Chivo's Blockchain Transaction Size by Type*

- **FigureE1b_replication.png**  
  Replica de la Figura S27(b): *Change in Volume vs Change in Price*

Estas figuras se encuentran en: output/figures

---

# Notas de reproducibilidad

Se realizaron algunos ajustes al código original para garantizar la reproducibilidad dentro del repositorio:

- Eliminación de rutas locales dependientes del computador.
- Uso de rutas relativas para acceder a datos y guardar resultados.
- Corrección de rutas hacia la carpeta `data/raw`.
- Automatización del guardado de figuras en `output/figures`.

Estos cambios permiten que cualquier usuario pueda ejecutar el script y reproducir los resultados sin modificar manualmente las rutas del proyecto.



