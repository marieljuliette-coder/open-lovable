# Usa una imagen ligera de Node
FROM node:18-alpine AS builder

# Define el directorio de trabajo
WORKDIR /app

# Copia los archivos de dependencias
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia todo el código del proyecto
COPY . .

# Construye el proyecto para producción
RUN npm run build

# Segunda etapa: servidor ligero para servir la app
FROM node:18-alpine

WORKDIR /app

# Copia los archivos construidos desde la etapa anterior
COPY --from=builder /app ./

# Exponer el puerto donde correrá la app
EXPOSE 3000

# Iniciar la aplicación
CMD ["npm", "run", "start"]
