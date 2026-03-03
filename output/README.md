# Proyecto Transversal: Gestión de Proyectos de Investigación y Ciencia Abierta

# Paper seleccionado  
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
│   ├── logs/             # Archivos de ejecución
│
├── docs/
│   ├── avance1.pdf
│   ├── avance2.pdf
│   ├── proyecto_transversal.pdf
│
└── README.md
</pre>

# Fuentes de datos
Repositorio en Zenodo:
- DOI: 10.5281/zenodo.8206117

Repositorio en Dryad:
- DOI: 10.5061/dryad.z8w9ghxjm

# Requisitos iniciales identificados
- Acceso a los datos y scripts originales del paper  
- Git y GitHub para control de versiones  
- Stata 16
- Paquetes estadísticos y de visualización (reghdfe, gtools, spmap)
- Entorno reproducible (renv o equivalente)  
- Documentación clara del flujo de trabajo  
