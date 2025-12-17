# 🧩 Fase 1 — Infraestructura base: Bucket S3 con Terraform

## 🎯 Objetivo

El objetivo de esta fase es crear la **infraestructura base** del proyecto *text-to-audio-aws* utilizando **Infraestructura como Código (IaC)**, sin usar la consola de AWS.

En esta etapa se implementa un **bucket de Amazon S3** que servirá como punto de entrada para archivos de texto en fases posteriores del proyecto.

---

## 🧠 Contexto del proyecto

Este proyecto busca convertir archivos de texto en audio de forma **asincrónica** utilizando servicios de AWS (S3, Lambda, Polly, SNS).

La Fase 1 se enfoca exclusivamente en sentar las bases de la arquitectura, priorizando:

* buenas prácticas
* reproducibilidad
* control de versiones

---

## 🏗️ Infraestructura creada

En esta fase se creó:

* ✅ Un **bucket S3**
* ✅ Nombre **único a nivel global** (usando `random_id`)
* ✅ **Versionado habilitado**
* ✅ Todo definido con **Terraform**

No se utilizaron recursos manuales desde la consola de AWS.

---

## 📁 Estructura del proyecto (infra)

```
infra/
├── provider.tf
├── s3_input.tf
└── .terraform.lock.hcl
```

### Descripción de archivos

* **provider.tf**
  Define el provider de AWS, la región y las versiones requeridas.

* **s3_input.tf**
  Contiene la definición del bucket S3, el versionado y el identificador aleatorio para garantizar un nombre único.

* **.terraform.lock.hcl**
  Archivo de bloqueo de versiones de providers. Se versiona para garantizar consistencia entre entornos.

---

## 🧱 Decisiones de arquitectura

### ¿Por qué S3?

* Servicio altamente disponible y duradero
* Ideal para almacenamiento de archivos (texto y audio)
* Integración nativa con eventos y Lambda

### ¿Por qué Terraform?

* Infraestructura reproducible
* Versionada junto al código
* Evita configuraciones manuales
* Buenas prácticas DevOps

### ¿Por qué nombres únicos?

Los buckets S3 requieren nombres únicos a nivel global. Se utilizó `random_id` para evitar colisiones y permitir múltiples despliegues.

---

## 🔐 Seguridad y buenas prácticas

* No se versionan archivos sensibles (`tfstate`, `tfvars`)
* No se versiona `.terraform/`
* Se utiliza `.gitignore` correctamente

---

## 📚 Aprendizajes clave

Durante esta fase aprendí:

* Cómo declarar providers en Terraform
* Cómo crear recursos en AWS usando IaC
* La importancia del versionado en S3
* Por qué ciertos archivos no deben subirse a GitHub

---

## 🚀 Próximo paso

En la **Fase 2** se incorporará procesamiento asincrónico:

* Evento S3 → Lambda
* Conversión de texto a audio con AWS Polly
* Almacenamiento del audio generado

---

> Esta fase representa la base del proyecto y establece un flujo de trabajo profesional orientado a Cloud / DevOps.
