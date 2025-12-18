import { NextRequest, NextResponse } from "next/server";
import AWS from "aws-sdk";

// Configuramos AWS SDK
const s3 = new AWS.S3({
  region: "us-east-1",
  // Las credenciales las toma de tu perfil ~/.aws/credentials o variables de entorno
});

export async function POST(req: NextRequest) {
  try {
    const formData = await req.formData();
    const file = formData.get("file") as Blob;

    if (!file) {
      return NextResponse.json({ error: "No se recibió archivo" }, { status: 400 });
    }

    const buffer = Buffer.from(await file.arrayBuffer());
    const params = {
      Bucket: "text-to-audio-aws-input-c38cb20c", // tu bucket real
      Key: file.name,
      Body: buffer,
    };

    await s3.putObject(params).promise();

    return NextResponse.json({ message: "Archivo subido correctamente a S3!" });
  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: "Error subiendo archivo" }, { status: 500 });
  }
}
