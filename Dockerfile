# Usamos una imagen base con Node.js 22
FROM node:22

# Instalamos git, python3-pip, python3-venv y python3
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

# Modificamos el archivo YAML para usar un modelo más ligero (Qwen2-0.5B) y otros ajustes
RUN sed -i 's/model_name_or_path: Gensyn\/Qwen2.5-0.5B-Instruct/model_name_or_path: Qwen\/Qwen2-0.5B/' ./hivemind_exp/configs/mac/grpo-qwen-2.5-0.5b-deepseek-r1.yaml
RUN sed -i '/training arguments/a\max_grad_norm: 0.5' ./hivemind_exp/configs/mac/grpo-qwen-2.5-0.5b-deepseek-r1.yaml
RUN sed -i 's/torch_dtype: bfloat16/torch_dtype: float32/' ./hivemind_exp/configs/mac/grpo-qwen-2.5-0.5b-deepseek-r1.yaml

# Creamos un entorno virtual y lo configuramos
RUN python3 -m venv .venv
RUN . .venv/bin/activate && pip install -r requirements.txt
RUN . .venv/bin/activate && pip install -r requirements-hivemind.txt

# Damos permisos de ejecución al script
RUN chmod +x run_rl_swarm.sh

# Establecemos la variable de entorno experimental
ENV PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0

# Ejecutamos el script con bash, activando el entorno virtual
CMD ["/bin/bash", "-c", ". .venv/bin/activate && ./run_rl_swarm.sh"]
