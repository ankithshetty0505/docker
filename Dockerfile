FROM python:3.11-slim
WORKDIR /app

# Copy and install dependencies first (for better caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your application code
COPY app.py .

# Expose the port Flask runs on
EXPOSE 8095

# Corrected CMD syntax
CMD ["python", "app.py"]
