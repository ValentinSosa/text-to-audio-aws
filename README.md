# 🎧 Text to Audio — AWS Serverless Project

Proyecto serverless en AWS que convierte archivos de texto (`.txt`) en audio (`.mp3`) de forma **asincrónica**, utilizando una arquitectura **event-driven** y **100% definida con Terraform**.

El objetivo del proyecto es demostrar buenas prácticas de **Cloud / DevOps**, trabajando con servicios administrados de AWS, infraestructura reproducible y documentación clara por fases.

---

## 🧠 Idea del proyecto

El sistema permite subir un archivo de texto y obtener automáticamente un archivo de audio generado por AWS, sin servidores, sin procesos manuales y sin intervención humana.

Todo el flujo ocurre de manera desacoplada y asincrónica.

---

## 🏗️ Arquitectura general

Usuario / Web App
|
v
S3 (Input Bucket)
|
v
Evento ObjectCreated (.txt)
|
v
AWS Lambda
|
v
Amazon Polly
|
v
S3 (Output Bucket - MP3)


---

## ⚙️ Tecnologías utilizadas

- **Amazon S3**
  - Bucket de entrada (archivos .txt)
  - Bucket de salida (archivos .mp3)
- **AWS Lambda**
  - Runtime Python
  - Ejecución asincrónica
- **Amazon Polly**
  - Conversión de texto a voz
- **IAM**
  - Roles y policies con mínimos privilegios
- **Amazon CloudWatch**
  - Logs y observabilidad
- **Terraform**
  - Infraestructura como Código
- **Next.js (opcional)**
  - Interfaz web para subir archivos

---

## 📁 Estructura del repositorio

text-to-audio-aws/
├── infra/ # Infraestructura AWS (Terraform)
│ ├── provider.tf
│ ├── iam.tf
│ ├── lambda.tf
│ ├── notifications.tf
│ ├── random.tf
│ ├── s3_input.tf
│ ├── s3_output.tf
│ └── .terraform.lock.hcl
│
├── lambda/ # Código de la función Lambda
│ ├── text_to_audio.py
│ └── text_to_audio.zip
│
├── app/
│ └── frontend/ # Frontend web (Next.js)
│
├── docs/ # Documentación detallada por fases
│ ├── fase-1-s3-infrastructure.md
│ ├── fase-2-lambda.md
│ └── fase-3-amazonpolly.md
│
└── README.md



---

## 🧩 Fase 1 — Infraestructura base (S3)

### 🎯 Objetivo
Crear la infraestructura inicial del proyecto utilizando Terraform, sin usar la consola de AWS.

### 🏗️ Qué se implementó
- Bucket S3 de entrada
- Nombre único a nivel global (random_id)
- Versionado habilitado
- Infraestructura 100% declarativa

### 🧠 Aprendizajes
- Uso de Terraform para crear recursos en AWS
- Importancia del versionado
- Buenas prácticas de control de versiones

📄 Documentación completa:  
`docs/fase-1-s3-infrastructure.md`

---

## 🧩 Fase 2 — Arquitectura asincrónica (S3 → Lambda)

### 🎯 Objetivo
Validar una arquitectura orientada a eventos donde S3 dispare automáticamente una función Lambda.

### 🏗️ Qué se implementó
- Evento `ObjectCreated` en S3
- Lambda asincrónica
- Rol IAM para ejecución
- Logs en CloudWatch

### 🧪 Resultado
- Subir un `.txt` dispara la Lambda
- El evento se registra correctamente en CloudWatch

📄 Documentación completa:  
`docs/fase-2-lambda.md`

---

## 🧩 Fase 3 — Conversión de texto a audio (Amazon Polly)

### 🎯 Objetivo
Procesar el contenido del archivo `.txt` y generar un archivo de audio `.mp3`.

### 🏗️ Qué se implementó
- Lectura del archivo desde S3 input
- Conversión del texto con Amazon Polly
- Escritura del `.mp3` en S3 output
- Permisos IAM específicos para S3 y Polly

### ✅ Resultado final
- Flujo completo funcionando
- Archivo `.mp3` generado automáticamente
- Logs visibles en CloudWatch

📄 Documentación completa:  
`docs/fase-3-amazonpolly.md`

---

## 🌐 Frontend (opcional)

El proyecto incluye un frontend desarrollado en **Next.js**, cuyo objetivo es simular un uso real del sistema:

- Subida de archivos `.txt`
- Integración con el bucket S3 de entrada

El frontend **no es el foco principal del proyecto**, pero aporta contexto realista al flujo completo.

Ubicación:
app/frontend



---

## 🔐 Buenas prácticas aplicadas

- Infraestructura como Código
- Arquitectura serverless
- Separación clara entre código, infraestructura y documentación
- Principio de mínimos privilegios
- Observabilidad con CloudWatch
- Repositorio organizado y profesional

---

## 📌 Estado del proyecto

✔ Infraestructura desplegada con Terraform  
✔ Flujo asincrónico validado  
✔ Conversión texto → audio funcionando  
✔ Documentación completa  

---

## 👤 Autor

**Valentín Sosa**  
Cloud / DevOps Trainee
