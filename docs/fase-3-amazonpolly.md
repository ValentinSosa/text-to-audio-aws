🧩 FASE 3 — Conversión de texto a audio con Amazon Polly

🎯 Objetivo

Completar el flujo del proyecto implementando el procesamiento real del texto cargado en S3, convirtiéndolo en audio utilizando Amazon Polly, y almacenando el resultado en un bucket de salida.

Esta fase transforma la arquitectura de prueba de la Fase 2 en un sistema funcional end-to-end.

🏗️ Arquitectura final

Flujo completo:

Usuario / App Web
        |
        v
S3 (input bucket)
        |
        v
Evento ObjectCreated (.txt)
        |
        v
Lambda (Python)
        |
        +--> CloudWatch Logs
        |
        v
Amazon Polly
        |
        v
S3 (output bucket .mp3)

📁 Infraestructura creada

En esta fase se agregaron:

✅ Bucket S3 de salida para audios
✅ Permisos IAM específicos (S3 + Polly + Logs)
✅ Refactor del rol Lambda (principio de mínimo privilegio)
✅ Lambda con lógica de procesamiento real

Todo gestionado con Terraform.

🔐 IAM y seguridad

Se reemplazó la policy genérica utilizada en Fase 2 por políticas personalizadas:

Permisos otorgados a la Lambda

s3:GetObject (bucket input)

s3:PutObject (bucket output)

polly:SynthesizeSpeech

Logs en CloudWatch

Esto mejora:

seguridad

control

claridad de permisos

⚙️ Lógica de la Lambda

La función Lambda realiza:

Lee el archivo .txt desde S3 (input)

Extrae el texto

Invoca Amazon Polly

Genera un archivo .mp3

Guarda el audio en el bucket de salida

Registra logs en CloudWatch

📦 Código Lambda

Ubicación:

lambda/text_to_audio.py


Características:

Runtime: Python 3.11

Ejecución asincrónica

Manejo de errores básico

Logs detallados para debugging

🧪 Prueba funcional

Se realizó una prueba end-to-end:

Subida de archivo .txt desde la app web

S3 dispara evento

Lambda ejecuta correctamente

Polly genera el audio

Archivo .mp3 aparece en bucket output

Logs visibles en CloudWatch

✔️ Flujo validado completamente

🌐 App Web (frontend)

Se desarrolló una app web simple para:

Subir archivos .txt

Simular un escenario real de uso

Evitar pruebas manuales desde la consola

La app no es el core del proyecto, pero aporta contexto realista al flujo completo.

🧠 Aprendizajes clave

Integración real S3 → Lambda → Polly

Manejo de eventos asincrónicos

IAM avanzado y refactor de permisos

Debugging con CloudWatch Logs

Arquitectura serverless orientada a eventos

Terraform aplicado a un flujo productivo

✅ Estado final del proyecto

✔ Infraestructura declarada con IaC
✔ Arquitectura serverless funcional
✔ Flujo asincrónico end-to-end
✔ Proyecto listo para portfolio Cloud / DevOps

🚀 Próximas mejoras (futuras)

Validación de formato del texto

Selección de voz / idioma

SNS o email de notificación

API Gateway

CI/CD con GitHub Actions
