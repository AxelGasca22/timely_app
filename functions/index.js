
// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started


const functions = require("firebase-functions");
const { OpenAI } = require("openai");

const openai = new OpenAI({
  //apiKey: "AQUI_VA_LA_LLAVE_DE_LA_APII",
});

exports.generarRecomendaciones = functions.https.onCall(async (data, context) => {
  const { respuestas, texto } = data;

  const prompt = `
Tengo las siguientes respuestas de un usuario:
${respuestas}

Texto adicional del usuario:
"${texto}"

Dame 3 recomendaciones personalizadas para mejorar su situación.
`;

  const response = await openai.chat.completions.create({
    model: "gpt-4o",
    messages: [{ role: "user", content: prompt }],
  });

  return { resultado: response.choices[0].message.content };
});
