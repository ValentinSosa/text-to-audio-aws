"use client";
import { useState } from "react";

export default function Home() {
  const [file, setFile] = useState<File | null>(null);
  const [status, setStatus] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!file) return;

    setStatus("Subiendo...");
    const formData = new FormData();
    formData.append("file", file);

    try {
      const res = await fetch("/api/upload", {
        method: "POST",
        body: formData,
      });

      if (res.ok) setStatus("Archivo subido correctamente!");
      else setStatus("Error al subir archivo");
    } catch (err) {
      setStatus("Error en la conexión");
    }
  };

  return (
    <main className="p-8">
      <h1 className="text-2xl font-bold mb-4">Text to Audio</h1>
      <form onSubmit={handleSubmit}>
        <input
          type="file"
          accept=".txt"
          onChange={(e) => setFile(e.target.files?.[0] || null)}
          className="mb-4"
        />
        <button type="submit" className="bg-blue-500 text-white px-4 py-2">
          Procesar
        </button>
      </form>
      {status && <p className="mt-4">{status}</p>}
    </main>
  );
}

