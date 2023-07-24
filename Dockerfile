# Use an official Python runtime as the base image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy the application files to the container
COPY . .

# Install application dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port that your application listens on
EXPOSE 5000

# Define the command to run your application
CMD ["python", "app.py"]
