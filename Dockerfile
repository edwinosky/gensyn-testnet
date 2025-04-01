# Usamos una imagen base con Node.js 22
FROM node:22

# Instalamos git, python3-pip y python3-venv
RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    python3-venv \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Establecemos el directorio de trabajo
WORKDIR /app

# Clonamos el repositorio oficial de rl-swarm desde GitHub
RUN git clone https://github.com/gensyn-ai/rl-swarm.git .

# Creamos un entorno virtual y lo configuramos
RUN python3 -m venv .venv
RUN . .venv/bin/activate && pip install -r requirements.txt

# Damos permisos de ejecución al script
RUN chmod +x run_rl_swarm.sh

# Ejecutamos el script dentro del entorno virtual
CMD [".venv/bin/bash", "run_rl_swarm.sh"]
