# 🧩 FASE 2 — Lambda asincrónica (S3 → Lambda)

## 🎯 Objetivo

Implementar una arquitectura *event-driven* donde la carga de un archivo `.txt` en un bucket S3 dispare automáticamente una función AWS Lambda de forma asincrónica.

En esta fase, la Lambda **no procesa el texto**, sino que registra en logs la información del evento recibido. Esto permite validar:

* Integración S3 → Lambda
* Permisos IAM correctos
* Flujo asincrónico funcionando

---

## 🏗️ Arquitectura

Flujo de eventos:

```
Usuario
  |
  v
S3 (bucket input)
  |
  v
Evento ObjectCreated (.txt)
  |
  v
Lambda (async)
  |
  v
CloudWatch Logs
```

---

## 📁 Estructura del proyecto

```
infra/
├── iam.tf        # Rol y permisos para Lambda
├── lambda.tf     # Definición de la función Lambda
├── s3_input.tf   # Bucket S3 + notificación a Lambda
```

---

## 🔐 IAM Role para Lambda

Se creó un rol IAM que permite:

* Que el servicio Lambda asuma el rol
* Escritura de logs en CloudWatch

Se utilizó la policy administrada:

```
AWSLambdaBasicExecutionRole
```

Esto sigue el principio de **mínimos privilegios**.

---

## ⚙️ Definición de la Lambda

Características:

* Runtime: `python3.12`
* Handler: `lambda_function.lambda_handler`
* Código empaquetado en un archivo `.zip`

Código base de la función:

```python
def lambda_handler(event, context):
    print("Evento recibido:")
    print(event)
```

El `source_code_hash` se utiliza para que Terraform detecte cambios en el código.

---

## 🔔 Notificación S3 → Lambda

Se configuró el bucket S3 para:

* Disparar eventos `ObjectCreated`
* Filtrar únicamente archivos con extensión `.txt`

Además, se agregó un permiso explícito (`aws_lambda_permission`) para permitir que S3 invoque la función Lambda.

---

## 🧪 Prueba funcional

Se realizó una prueba subiendo un archivo `.txt` al bucket S3.

Resultado:

* El evento disparó la ejecución de la Lambda
* El evento completo fue registrado correctamente en CloudWatch Logs

Esto valida que el flujo asincrónico funciona correctamente.

---

## 🧠 Aprendizajes clave

* Cómo integrar S3 con Lambda usando eventos
* Importancia de los permisos IAM explícitos
* Uso de CloudWatch Logs para observabilidad
* Arquitecturas orientadas a eventos en AWS

---

## ✅ Estado de la fase

✔ Infraestructura creada con Terraform
✔ Lambda ejecutándose correctamente
✔ Flujo validado con prueba real

La base está lista para avanzar a **FASE 3 — Conversión de texto a audio con Amazon Polly** 🚀
