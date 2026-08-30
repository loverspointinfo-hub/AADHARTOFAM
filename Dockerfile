FROM python:3.11-slim

# Install Tesseract OCR engine
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    tesseract-ocr \
    tesseract-ocr-eng \
    libtesseract-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY app.py .

# Expose port
EXPOSE 3000

# Start with gunicorn
CMD gunicorn app:app --bind 0.0.0.0:3000 --workers 2 --timeout 120