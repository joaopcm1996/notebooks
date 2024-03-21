ARG VERSION
FROM vllm/vllm-openai:$VERSION

# Make server compatible with SageMaker Hosting contract
RUN sed -i 's|/health|/ping|g' vllm/entrypoints/openai/api_server.py 
RUN sed -i 's|/v1/completions|/invocations|g' vllm/entrypoints/openai/api_server.py 

COPY sagemaker_entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]