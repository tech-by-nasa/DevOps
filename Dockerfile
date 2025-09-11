# Use a lightweight official Python image as the base
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container
COPY ./app/requirements.txt ./

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire app directory into the container
COPY ./app/ ./

# Expose the port the app runs on
EXPOSE 5000

# Set the command to run the application
CMD ["python", "app.py"]


Once you have created and saved the `Dockerfile` in the correct location, you just need to commit and push your changes to trigger a new, successful pipeline run.

---

### **The Final Commands**

1.  **Stage your changes:**
    ```bash
    git add .
    ```

2.  **Commit your changes:**
    ```bash
    git commit -m "fix: Add missing Dockerfile to the root directory"
    ```

3.  **Push to GitHub:**
    ```bash
    git push origin main
    ```
